# TNPA Telegram Alert EA Specification

## 1. Objective

Build an alert-only MT5 Expert Advisor that monitors configured symbols and timeframes for EMA 34/89 trend alert conditions and sends Telegram notifications.

The EA is intended for TNPA Trading OS as a notification tool only. It must support later extension with TNPA filters, but v0.1 should remain limited to alert generation.

## 2. Scope

Version v0.2 covers:

- Alert-only Expert Advisor for MetaTrader 5.
- Symbols:
  - `XAUUSD`
  - `EURUSD`
  - `BTCUSD`
- Primary timeframe:
  - `H1`
- Optional future timeframes:
  - `H4`
  - `D1`
- Signal foundation:
  - EMA 34/89 crossover or trend-change alert.
  - TNPA filter extension points prepared for later versions.
- Alert delivery:
  - Telegram message using user-provided bot token and chat ID.
- Alert frequency:
  - One alert per closed candle per symbol per timeframe.
- Duplicate prevention:
  - Track `lastSuccessfulAlertBarTime` per symbol and timeframe.
  - Track pending failed alerts separately.

## 3. Non-goals

The EA must not:

- Place market orders.
- Place pending orders.
- Modify positions.
- Close positions.
- Manage stop loss or take profit.
- Perform position sizing.
- Connect to broker account management features.
- Store, request, or handle broker credentials.
- Optimize strategy parameters.
- Claim profitability or trading performance.
- Treat TNPA filters as implemented in v0.1.

## 4. Inputs

User-configurable inputs:

- `TelegramBotToken`
  - Telegram bot token provided by the user.
  - Used only for sending Telegram alerts.
- `TelegramChatID`
  - Telegram chat ID provided by the user.
  - Used only as the alert destination.
- `Symbols`
  - Default: `XAUUSD,EURUSD,BTCUSD`.
- `PrimaryTimeframe`
  - Default: `H1`.
- `EnableH4`
  - Default: disabled.
  - Reserved for later timeframe expansion.
- `EnableD1`
  - Default: disabled.
  - Reserved for later timeframe expansion.
- `FastEMA`
  - Default: `34`.
- `SlowEMA`
  - Default: `89`.
- `EnableTNPAFilters`
  - Default: disabled.
  - Reserved for later extension.
- `SendStartupTestMessage`
  - Default: enabled.
  - Sends one Telegram connection test message after successful EA initialization when Telegram alerts are enabled and Telegram credentials are configured.

Required runtime assumptions:

- Telegram web requests are configured by the user in MT5 terminal settings.
- The Telegram API URL is allowed in MT5 WebRequest settings before live alert delivery is expected to work.
- Symbols are available in the broker's Market Watch.
- Each configured symbol has enough available history to calculate EMA 34 and EMA 89.
- Alerts are evaluated on closed candles, not on the still-forming candle.

## 5. Signal Logic v0.1

Signal foundation v0.1:

- Calculate EMA 34 and EMA 89 for each configured symbol and timeframe.
- Evaluate signals only after a candle has closed.
- Use closed candles only.
- Use close price as the EMA applied price unless a later approved specification changes this.
- Use the most recently closed candle as the current signal candle.
- Use the prior closed candle to confirm crossover or trend-change direction.

BUY alert condition:

- EMA 34 crosses above EMA 89 on the most recently closed candle.
- The prior closed candle must show EMA 34 at or below EMA 89.
- The most recently closed candle must show EMA 34 above EMA 89.
- No successful alert has already been sent for the same symbol, timeframe, and closed-candle time.

SELL alert condition:

- EMA 34 crosses below EMA 89 on the most recently closed candle.
- The prior closed candle must show EMA 34 at or above EMA 89.
- The most recently closed candle must show EMA 34 below EMA 89.
- No successful alert has already been sent for the same symbol, timeframe, and closed-candle time.

Neutral condition:

- If no EMA 34/89 crossover or trend-change occurs on the most recently closed candle, no alert is sent.
- Do not send alerts on every candle during the same trend state.
- If EMA 34 and EMA 89 are equal on the most recently closed candle, no alert is sent.

Startup and restart behavior:

- On EA startup, do not send historical alerts.
- Initialize monitoring state from the latest available closed candle.
- Start evaluating alerts from the next newly closed candle after initialization.
- If the EA restarts, it should not backfill historical alerts from candles that closed before restart.
- If `SendStartupTestMessage` is enabled, send one startup Telegram connection test message after successful initialization when Telegram is enabled and both Telegram inputs are configured.
- Startup test messages must not affect signal evaluation, duplicate prevention, or pending failed alert state.

TNPA filter extension points:

- v0.2 should reserve structure for future TNPA filters.
- Future filters may include session logic, market structure, volatility, confirmation rules, or higher-timeframe alignment.
- In v0.1, TNPA filters must not block or modify alerts unless explicitly implemented in a later approved specification.

## 6. Telegram Alert Format

Each Telegram alert should include:

- EA name.
- Symbol.
- Timeframe.
- Signal direction.
- EMA values or EMA state.
- Closed candle time.
- Reminder that the EA is alert-only.

Required message structure:

```text
TNPA Telegram Alert EA
Symbol: <SYMBOL>
Timeframe: <TIMEFRAME>
Signal: <BULLISH_TREND | BEARISH_TREND>
Basis: EMA 34/89 closed-candle crossover
Closed candle time: <BAR_TIME>
Mode: Alert only, no trade execution
```

The message must not include:

- Broker credentials.
- Account number.
- Account balance.
- Position size.
- Profit guarantees.
- Direct financial advice.

Startup connection test message:

```text
TNPA Telegram Alert EA Connected

Version: v0.2
Broker: <broker>
Account: <account number>
Mode: Demo or Live
Symbols: <configured symbols>
Timeframe: <configured timeframe>

Connection Test: SUCCESS
```

Startup connection test rules:

- Send only once per EA initialization.
- Send only if `SendStartupTestMessage=true`.
- Send only if `EnableTelegramAlert=true`.
- Send only if `TelegramBotToken` is configured.
- Send only if `TelegramChatID` is configured.
- If send fails, log the exact Telegram/WebRequest failure reason, even when routine print logging is disabled.
- Do not mark any signal alert as successfully delivered because of the startup test.
- Do not create or modify pending failed signal alert state because of the startup test.

## 7. Duplicate Alert Rules

Duplicate prevention requirement:

- The EA must send at most one successful alert per closed candle per symbol per timeframe.
- The EA must store the last successfully alerted closed-candle time as `lastSuccessfulAlertBarTime`.
- `lastSuccessfulAlertBarTime` must be tracked separately for each symbol and timeframe.
- Pending failed alerts must be tracked separately from successful alerts.
- Pending failed alert tracking must include symbol, timeframe, closed-candle time, signal direction, and retry status.

Expected behavior:

- If the current closed candle time equals `lastSuccessfulAlertBarTime`, do not send another successful alert for that symbol and timeframe.
- If a new closed candle appears and the crossover condition is true, attempt one Telegram alert.
- Do not mark the alert as successfully sent until Telegram confirms success.
- If Telegram confirms success, update `lastSuccessfulAlertBarTime`.
- If Telegram send fails, log the failure and create or update a pending failed alert record.
- Do not spam retries after failure.
- Allow one retry on the next timer cycle only if the same closed candle is still the latest signal.
- If the retry succeeds, update `lastSuccessfulAlertBarTime` and clear the pending failed alert.
- If the retry fails, log the failure and clear or expire the pending retry so it does not repeat indefinitely.
- If a newer candle appears before retry, do not retry the older failed alert.
- If a new closed candle appears and no crossover condition is true, do not update `lastSuccessfulAlertBarTime`.

Future consideration:

- If later versions add separate alert types, duplicate tracking may need to include signal type as well as symbol, timeframe, and bar time.

## 8. Safety Rules

The EA must:

- Remain alert-only.
- Never call order placement behavior.
- Never call position modification behavior.
- Never close positions.
- Never read, store, or request broker credentials.
- Use Telegram credentials only for alert delivery.
- Avoid logging sensitive Telegram token values.
- Fail safely if Telegram configuration is missing or invalid.
- Fail safely if MT5 WebRequest permission for Telegram is missing.
- Validate configured symbol availability before monitoring each symbol.
- Validate that enough historical data exists for EMA calculation before evaluating signals.
- Handle invalid indicator handles safely.
- Handle missing or unavailable indicator buffer data safely.
- Continue monitoring other configured symbols if one symbol is unavailable, where practical.
- Report configuration or delivery failures clearly without attempting trading actions.
- Keep TNPA filters disabled unless a later approved implementation explicitly defines them.

Human approval is required before:

- Adding order placement.
- Adding position management.
- Adding broker integration.
- Adding account-specific behavior.
- Enabling TNPA filters that change alert behavior.
- Expanding from alerts into automated trade execution.

## 9. Testing Checklist

Configuration tests:

- EA accepts Telegram bot token and chat ID as user inputs.
- EA accepts `SendStartupTestMessage` as a user input.
- EA handles missing Telegram token safely.
- EA handles missing Telegram chat ID safely.
- EA reports missing MT5 WebRequest permission for Telegram safely.
- EA does not print full Telegram token in logs.
- EA sends one startup test message after successful initialization when Telegram is enabled and credentials are configured.
- EA does not send startup test message when `SendStartupTestMessage=false`.
- EA does not send startup test message when Telegram is disabled.
- EA logs the exact reason when startup test message fails, even when routine print logging is disabled.
- EA handles unavailable symbols gracefully.
- EA validates enough history exists for EMA 34/89 calculation.
- EA handles invalid indicator handles safely.
- EA handles missing or unavailable indicator buffer data safely.

Signal tests:

- EMA 34/89 values are evaluated on closed candles.
- BUY alert is produced when EMA 34 crosses above EMA 89 on the most recently closed candle.
- SELL alert is produced when EMA 34 crosses below EMA 89 on the most recently closed candle.
- No alert is produced on every candle during the same trend state.
- No alert is produced when no valid crossover condition exists.
- No alert is produced when EMA 34 and EMA 89 are equal on the most recently closed candle.
- No historical alert is sent on EA startup.
- Monitoring begins from the next newly closed candle after initialization.
- Primary timeframe `H1` is evaluated by default.
- `H4` and `D1` are not active unless later enabled by approved implementation.

Duplicate prevention tests:

- Only one successful alert is sent for a closed candle per symbol per timeframe.
- Repeated ticks on the same candle do not produce duplicate alerts.
- New closed candle can produce a new alert when the signal condition is true.
- `lastSuccessfulAlertBarTime` is tracked separately for `XAUUSD`, `EURUSD`, and `BTCUSD`.
- Pending failed alerts are tracked separately from successful alerts.
- Failed Telegram sends do not update `lastSuccessfulAlertBarTime`.
- One retry is allowed on the next timer cycle only if the same closed candle remains the latest signal.
- Failed alert retries do not repeat indefinitely.

Safety tests:

- EA does not place orders.
- EA does not modify positions.
- EA does not close positions.
- EA does not access broker credentials.
- EA does not perform position sizing.
- Telegram delivery failure does not trigger trading behavior.
- Telegram delivery failure is logged without retry spam.

Review tests:

- Reviewer confirms the EA matches alert-only scope.
- Reviewer confirms TNPA filters are reserved for later extension only.
- Reviewer confirms implementation does not exceed v0.1 specification.

## 10. Implementation Approval Gate

This specification is not approval to write MQ5 code.

Implementation may begin only after the human operator approves:

- This specification.
- Alert-only scope.
- Symbols: `XAUUSD`, `EURUSD`, `BTCUSD`.
- Primary timeframe: `H1`.
- EMA settings: `34` and `89`.
- Telegram input approach.
- Startup connection test message behavior.
- EMA 34/89 crossover-only signal trigger.
- Startup behavior that does not send historical alerts.
- Telegram failure and one-retry behavior.
- Duplicate prevention using `lastSuccessfulAlertBarTime` and pending failed alert tracking.
- MT5 WebRequest setup requirement.
- Symbol and history validation requirements.
- No order placement.
- No position modification.
- No broker credential handling.

Before implementation starts, Commander must confirm:

- The task is scoped to v0.2.
- Coder is authorized to create MQ5 code.
- Tester has the validation checklist.
- Reviewer has the acceptance criteria.
