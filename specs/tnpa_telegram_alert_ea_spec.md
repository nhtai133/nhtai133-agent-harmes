# TNPA Telegram Alert EA Specification

## 1. Objective

Upgrade the alert-only MT5 Expert Advisor into TNPA Signal Engine v0.4: a multi-symbol, multi-timeframe TNPA Radar Scanner that sends Telegram, popup, and print alerts for closed-candle TNPA signal state changes.

The EA remains notification-only. It must never place, modify, close, or manage trades.

## 2. Scope

Version v0.4 covers:

- Multi-symbol scanner using the `Symbols` input.
- Multi-timeframe scanner for `M15`, `M30`, `H1`, `H4`, `D1`, and `W1`.
- Telegram startup connection test preserved from v0.2.
- Timer-driven closed-candle scanning.
- Telegram delivery, one retry for failed signal alerts, and duplicate prevention.
- Signal types:
  - `TNPA TREND ALIGNMENT`
  - `TNPA WEEKLY FILTER`
  - `TNPA KC21 MOMENTUM`
  - `TNPA EMA21 PULLBACK`
  - `TNPA TD PLACEHOLDER`
- Donchian Channel context only. Donchian levels do not create signals.

## 3. Non-goals

The EA must not:

- Call `OrderSend`.
- Use `CTrade`.
- Open positions.
- Modify positions.
- Close positions.
- Build or send trade requests.
- Manage stops, targets, sizing, exposure, or broker orders.
- Store broker credentials.
- Treat Donchian Channel context as a signal.
- Implement TD Sequential in v0.4.

## 4. Inputs

Core inputs:

- `Symbols = "XAUUSD,EURUSD,BTCUSD"`
- `TelegramBotToken`
- `TelegramChatID`
- `EnableTelegramAlert = true`
- `EnablePopupAlert = true`
- `EnablePrintLog = true`
- `SendStartupTestMessage = true`

Timeframe inputs:

- `Enable_M15 = true`
- `Enable_M30 = true`
- `Enable_H1 = true`
- `Enable_H4 = true`
- `Enable_D1 = true`
- `Enable_W1 = true`

Indicator inputs:

- `EMA_Fast = 21`
- `EMA_Mid1 = 34`
- `EMA_Mid2 = 89`
- `EMA_Long = 200`
- `RSI_Period = 14`
- `RSI_SMA_Period = 50`
- `KC_Period = 21`
- `KC_ATR_Period = 21`
- `KC_Multiplier = 1.5`
- `DC_Fast_Period = 20`
- `DC_Slow_Period = 55`
- `EnableDCLevels = true`
- `DC_Near_Percent = 0.15`

Signal toggles:

- `EnableSignal_TrendAlignment = true`
- `EnableSignal_WeeklyFilter = true`
- `EnableSignal_KC21Momentum = true`
- `EnableSignal_EMA21Pullback = true`
- `EnableSignal_TDPlaceholder = false`

## 5. Signal Logic v0.4

All signals use closed candles only. The current forming candle must not be used.

### Signal Type 1: Trend Alignment

BUY:

- EMA21 > EMA34
- EMA34 > EMA89
- EMA89 > EMA200
- RSI14 > RSI_SMA50

SELL:

- EMA21 < EMA34
- EMA34 < EMA89
- EMA89 < EMA200
- RSI14 < RSI_SMA50

Telegram label:

- `TNPA TREND ALIGNMENT`

### Signal Type 2: Weekly Filter

Evaluate only on `W1`.

BULLISH:

- Weekly RSI14 > 50
- Weekly close > Weekly EMA21

BEARISH:

- Weekly RSI14 < 50
- Weekly close < Weekly EMA21

Telegram label:

- `TNPA WEEKLY FILTER`

### Signal Type 3: KC21 Momentum

Keltner Channel:

- KC Mid = EMA21
- KC Upper = EMA21 + ATR21 * KC_Multiplier
- KC Lower = EMA21 - ATR21 * KC_Multiplier

BUY:

- Close > KC Mid
- RSI14 > 50

STRONG BUY:

- Close > KC Upper
- RSI14 > 50

SELL:

- Close < KC Mid
- RSI14 < 50

STRONG SELL:

- Close < KC Lower
- RSI14 < 50

Telegram label:

- `TNPA KC21 MOMENTUM`

### Signal Type 4: EMA21 Pullback

BUY:

- Trend Alignment BUY is true.
- Previous closed candle low touches or dips below EMA21.
- Previous closed candle closes above EMA21.
- RSI14 > 50.

SELL:

- Trend Alignment SELL is true.
- Previous closed candle high touches or rises above EMA21.
- Previous closed candle closes below EMA21.
- RSI14 < 50.

Telegram label:

- `TNPA EMA21 PULLBACK`

### Signal Type 5: TD Placeholder

TD Sequential is not implemented in v0.4.

If enabled:

- Log: `TD Sequential signal is not implemented in v0.4`
- Do not send TD alerts.

## 6. Telegram Alert Format

Signal alert format:

```text
TNPA SIGNAL

Type: <Signal Type>

Strength:
<Normal / Strong>

Direction:
BUY or SELL

Symbol: <Symbol>

Signal Timeframe: <Timeframe>

Trading Style: <Auto Label>

Price: <Closed Candle Close>

EMA21: <Value>

EMA34: <Value>

EMA89: <Value>

EMA200: <Value>

RSI14: <Value>

RSI_SMA50: <Value>

KC21 Mid: <Value>

KC21 Upper: <Value>

KC21 Lower: <Value>

DC20 Upper: <Value>

DC20 Lower: <Value>

DC55 Upper: <Value>

DC55 Lower: <Value>

DC Context: <Near DC20 Swing High etc>

Broker: <Broker>

Account: <Account Number>

Mode:
Demo or Live
```

Startup connection test message:

```text
TNPA Telegram Alert EA Connected

Version: v0.4
Broker: <broker>
Account: <account number>
Mode: Demo or Live
Symbols: <configured symbols>
Timeframe: <configured timeframes>

Connection Test: SUCCESS
```

Startup connection test rules:

- Send only once per EA initialization.
- Send only if `SendStartupTestMessage=true`.
- Send only if `EnableTelegramAlert=true`.
- Send only if `TelegramBotToken` is configured.
- Send only if `TelegramChatID` is configured.
- If send fails, log the exact Telegram/WebRequest failure reason.
- Do not mark any signal alert as delivered because of the startup test.
- Do not create or modify pending failed signal alert state because of the startup test.

## 7. Duplicate Alert Rules

Send alerts only when a signal direction changes from:

- Neutral -> BUY
- Neutral -> SELL
- SELL -> BUY
- BUY -> SELL

Do not repeat every candle while the signal remains in the same direction.

Duplicate prevention key:

- Symbol
- Timeframe
- Signal Type
- Closed-candle bar time

If multiple signal types trigger on the same symbol/timeframe/bar:

- Send separate alerts.
- Prevent duplicates independently per signal type.

Failed Telegram signal alerts:

- Do not mark as successful until Telegram confirms success.
- Create pending failed alert state per signal type.
- Retry once on the next timer cycle only if the same closed candle is still latest.
- Clear the pending retry after success, failure, or candle expiry.

## 8. Safety Rules

The EA must:

- Remain alert-only.
- Use MQL5 indicator handles through `iMA`, `iRSI`, and `iATR`.
- Use `CopyBuffer` safely.
- Release indicator handles on deinitialization.
- Validate symbol availability.
- Validate enough history for EMA200, RSI SMA50, ATR/KC, and DC55.
- Handle `INVALID_HANDLE` safely.
- Handle `CopyBuffer` failure safely.
- Handle missing history safely.
- Keep scanning timer-driven.
- Preserve Telegram startup test and delivery retry behavior.
- Avoid logging Telegram token values.
- Fail safely without trading actions.

The EA must not add trading APIs or account management behavior.

## 9. Testing Checklist

Configuration tests:

- Startup Telegram connection test sends once per initialization.
- Telegram startup test does not affect signal state.
- Missing Telegram token or chat ID is handled safely.
- Missing WebRequest permission logs a Telegram failure reason.
- Disabled alert channels do not mark signal alerts as delivered.
- Symbol suffixes/prefixes require exact user input.

Signal tests:

- All enabled timeframes are scanned.
- Disabled timeframes are not scanned.
- Trend Alignment BUY/SELL signals match EMA and RSI rules.
- Weekly Filter runs only on `W1`.
- KC21 Momentum emits Normal and Strong strength labels correctly.
- EMA21 Pullback requires Trend Alignment and candle touch/close conditions.
- TD Placeholder logs only and sends no alerts.
- Donchian context appears in messages but does not generate alerts.

Duplicate and retry tests:

- No historical signal alert is sent on startup.
- Alerts are sent only on direction changes.
- Duplicate prevention is per symbol, timeframe, signal type, and bar time.
- Multiple signal types can send separate alerts on the same bar.
- Telegram failure creates one pending retry only.
- Retry does not repeat indefinitely.

Safety tests:

- No order placement functions exist.
- No position management functions exist.
- No trade request structures exist.
- EA remains alert-only during all error paths.

## 10. Implementation Approval Gate

The v0.4 implementation is approved for code only within the alert-only boundary.

Manual MT5 testing is required before operational use:

- Confirm Exness MT5 20.3 loads the deployed EX5.
- Confirm `https://api.telegram.org` is allowed in WebRequest settings.
- Confirm startup Telegram test message is received.
- Confirm no trades are placed or modified.
