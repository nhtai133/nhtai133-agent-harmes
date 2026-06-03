# TNPA Telegram Alert EA Code Review

## Review Scope

Reviewed implementation:

- `src/TNPA_Telegram_Alert_EA.mq5`

Reference:

- `specs/tnpa_telegram_alert_ea_spec.md`

Review role:

- Tester
- Reviewer

## Pass Items

### 1. Alert-Only Safety

Status: **Pass**

Static scan found no references to trading or position-management APIs:

- `CTrade`
- `OrderSend`
- `OrderModify`
- `OrderClose`
- `PositionOpen`
- `PositionModify`
- `PositionSelect`
- `PositionGet`
- `MqlTradeRequest`
- `TradeRequest`
- `Buy`
- `Sell`
- `HistoryDeal`

The EA remains alert-only. `AccountInfoString` and `AccountInfoInteger` are used only for broker, account number, and account mode text in Telegram messages.

### 2. Startup Telegram Connection Test

Status: **Pass**

The v0.2 startup connection test is preserved and updated to version `v0.4`.

Confirmed behavior:

- `SendStartupTestMessage` input remains available.
- Startup message sends only when Telegram is enabled and token/chat ID are configured.
- Startup message is sent once per EA initialization.
- Startup message does not call `DeliverAlert`.
- Startup message does not update signal duplicate state.
- Startup message does not create pending retry state.
- Telegram failure reasons use forced warning logs.

### 3. Multi-Symbol, Multi-Timeframe Scanner

Status: **Pass**

The implementation creates scanner states per configured symbol and enabled timeframe:

- `M15`
- `M30`
- `H1`
- `H4`
- `D1`
- `W1`

Scanning remains timer-driven through `OnTimer`. `OnTick` intentionally does not evaluate signals.

### 4. Indicator Handles And Closed-Candle Data

Status: **Pass**

The implementation uses MQL5 indicator handles:

- `iMA`
- `iRSI`
- `iATR`

The implementation validates:

- Symbol availability.
- EMA200 history.
- RSI SMA50 history.
- ATR/KC history.
- DC55 history.
- `INVALID_HANDLE`.
- `CopyBuffer` failure.
- Closed candle OHLC availability.

Indicator handles are released in `OnDeinit`.

### 5. TNPA Signal Engine v0.4 Logic

Status: **Pass**

Implemented signal types:

- `TNPA TREND ALIGNMENT`
- `TNPA WEEKLY FILTER`
- `TNPA KC21 MOMENTUM`
- `TNPA EMA21 PULLBACK`
- `TNPA TD PLACEHOLDER`

Weekly Filter is restricted to `W1`.

TD Placeholder logs `TD Sequential signal is not implemented in v0.4` and does not send alerts.

Donchian Channel values are calculated from closed candles only and included as market context, not as a signal.

### 6. Duplicate Prevention And Retry

Status: **Pass**

Duplicate prevention is tracked per scanner state and signal type:

- Symbol
- Timeframe
- Signal type
- Closed-candle bar time

Alerts are sent only when signal direction changes:

- Neutral -> BUY
- Neutral -> SELL
- SELL -> BUY
- BUY -> SELL

Pending failed alerts are tracked per signal type and retried once on the next timer cycle only if the same closed candle remains latest.

### 7. Telegram Message Format

Status: **Pass**

Signal messages include:

- Signal type.
- Strength.
- Direction.
- Symbol.
- Signal timeframe.
- Trading style label.
- Closed candle close.
- EMA21/34/89/200.
- RSI14 and RSI_SMA50.
- KC21 values.
- DC20/DC55 values.
- DC context.
- Broker/account/mode.

## Issues Found

### Issue 1: Broker-Specific Symbol Variants Are Not Auto-Resolved

Severity: **Low**

The scanner validates symbols but does not auto-detect suffixes or prefixes.

Impact:

- If Exness exposes symbols such as `XAUUSDm`, the user must enter that exact symbol in `Symbols`.

### Issue 2: Initially Invalid Symbol/Timeframe States Are Not Re-Added

Severity: **Low**

If a symbol/timeframe lacks enough history during `OnInit`, it is omitted until the EA is reloaded.

Impact:

- The EA fails safely, but the user may need to load history and restart the EA.

### Issue 3: TD Placeholder Can Log Repeatedly If Enabled

Severity: **Low**

When `EnableSignal_TDPlaceholder=true`, the EA logs that TD Sequential is not implemented each newly evaluated candle per scanner state.

Impact:

- No alert is sent and no trading behavior occurs, but logs may be noisy.

## Required Fixes

No code-blocking issues found after compilation.

Manual MT5 terminal testing is still required before operational use:

- Confirm startup Telegram test delivery.
- Confirm WebRequest settings.
- Confirm symbol names.
- Confirm no orders are placed or modified.

## Compile Verification

Compiler:

```text
C:\Program Files\MetaTrader 5 EXNESS 20.3\MetaEditor64.exe
```

Latest verified compile line:

```text
2026.06.03 23:01:16.368 Compile C:\Users\ADMIN\nhtai133-agent-harmes\src\TNPA_Telegram_Alert_EA.mq5 - 0 errors, 0 warnings, 691 ms elapsed, cpu='X64 Regular'
```

Result:

- Errors: `0`
- Warnings: `0`
- Generated EX5 size: `47964` bytes

## Approval Decision

Decision: **Approved For Manual MT5 Testing**

The v0.4 implementation matches the alert-only TNPA Radar Scanner requirements and compiled successfully with Exness MT5 20.3 MetaEditor.
