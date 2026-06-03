# TNPA Telegram Alert EA Code Review

## Review Scope

Reviewed implementation:

- `src/TNPA_Telegram_Alert_EA.mq5`

Reference documents:

- `specs/tnpa_telegram_alert_ea_spec.md`
- `reviews/tnpa_telegram_alert_ea_design_review_v2.md`

Review role:

- Tester
- Reviewer

No MQ5 code was written or modified during this review.

## Pass Items

### 1. No Trading Functions Are Used

Status: **Pass**

Static scan found no references to common trade/order APIs such as:

- `CTrade`
- `OrderSend`
- `OrderModify`
- `OrderClose`
- `PositionSelect`
- `PositionGet`
- `Buy`
- `Sell`
- `AccountInfo`
- `HistoryDeal`

The implementation is alert-only and does not place, modify, or close trades.

### 2. Closed Candle EMA34/EMA89 Crossover Logic

Status: **Pass**

The implementation evaluates only closed candles:

- `iTime(symbol, SignalTimeframe, 1)` is used for the latest closed candle.
- `CopyBuffer(..., 1, 2, ...)` is used to read the latest closed candle and the prior closed candle.
- BUY condition is implemented as previous EMA34 <= EMA89 and current EMA34 > EMA89.
- SELL condition is implemented as previous EMA34 >= EMA89 and current EMA34 < EMA89.
- The code does not alert on every candle during the same trend state.

This matches the approved crossover-only v0.1 behavior.

### 3. Startup Historical Alert Prevention

Status: **Pass**

Startup behavior matches the spec:

- During initialization, each symbol records the latest closed candle as `initializedBarTime`.
- `lastEvaluatedBarTime` is set to the same latest closed candle.
- Evaluation only proceeds when a later closed candle appears.

This prevents historical alerts on startup and restart.

### 4. Duplicate Prevention

Status: **Pass**

The implementation tracks:

- `lastSuccessfulAlertBarTime` per symbol state.
- Pending failed alert state per symbol.
- Pending alert symbol context through the containing `SymbolState`.
- Pending alert timeframe through the global configured `SignalTimeframe`.
- Pending alert candle time, direction, message, and retry status.

The EA only updates `lastSuccessfulAlertBarTime` after successful delivery.

### 5. Telegram Failure Retry Behavior

Status: **Pass**

Telegram failure behavior is safe:

- Failed Telegram sends are logged.
- Failed sends do not update `lastSuccessfulAlertBarTime`.
- One pending retry is created.
- Retry occurs only through `OnTimer`, not every tick.
- Retry only proceeds if the failed candle remains the latest closed candle.
- Failed retry is cleared and does not repeat indefinitely.

This satisfies the no-spam retry requirement.

### 6. WebRequest Usage

Status: **Pass With Note**

The implementation uses `WebRequest` for Telegram delivery and logs a clear setup reminder:

- User must allow `https://api.telegram.org` in MT5 WebRequest settings.
- HTTP 200 plus Telegram response containing `"ok":true` is treated as success.
- `WebRequest` errors are logged with the MT5 error code.

The implementation does not log the Telegram token separately. However, the full request URL includes the token internally as required by the Telegram API.

### 7. Indicator Handles And Buffers

Status: **Pass**

The implementation handles platform failures safely:

- Validates symbol selection.
- Validates available bar count before initialization and evaluation.
- Checks invalid EMA indicator handles.
- Releases valid indicator handles on deinitialization.
- Checks `CopyBuffer` return counts.
- Logs `CopyBuffer` failures and does not alert when EMA data is unavailable.

### 8. Popup/Print Behavior When Telegram Is Disabled

Status: **Pass With Note**

When `EnableTelegramAlert` is false:

- `SendTelegramMessage` returns success.
- Popup alert can fire if `EnablePopupAlert` is true.
- Print log can fire if `EnablePrintLog` is true.
- Successful alert state is updated after local delivery behavior.

This is acceptable for non-Telegram alert mode.

## Issues Found

### Issue 1: All Alert Channels Can Be Disabled

Severity: **Medium**

Status: **Fixed**

The implementation now checks whether at least one alert channel is enabled before delivery can succeed.

If `EnableTelegramAlert`, `EnablePopupAlert`, and `EnablePrintLog` are all false:

- `DeliverAlert` returns failure.
- The EA does not update `lastSuccessfulAlertBarTime`.
- A forced warning is printed even though normal print logging is disabled.
- `OnInit` warns that signals will not be marked as delivered until at least one channel is enabled.

Impact:

- The previous silent missed-alert risk is resolved.

### Issue 2: Compile Confidence Needs Real MetaEditor Verification

Severity: **Medium**

The code is likely to compile in MT5 based on static review, but it has not been compiled in MetaEditor.

Areas that should be confirmed by actual compilation:

- `CharToString(c)` with `uchar` input.
- `StringToCharArray` into a `uchar` array with `CP_UTF8`.
- The selected `WebRequest` overload.
- `CharArrayToString(result, 0, -1, CP_UTF8)`.

Impact:

- Static review cannot fully guarantee MT5 compiler compatibility.

### Issue 3: Broker-Specific Symbol Variants Are Not Auto-Resolved

Severity: **Low**

The implementation validates configured symbols, but does not auto-detect broker suffixes or prefixes.

Impact:

- If the broker uses names such as `XAUUSDm`, the user must provide those exact symbols in the `Symbols` input.
- This matches v0.1 expectations but should be documented for users.

### Issue 4: History Sync Is Not Retried For Initially Invalid Symbols

Severity: **Low**

If a symbol lacks enough history during `OnInit`, it is omitted from `g_states` and is not re-added later if history becomes available.

Impact:

- The EA fails safely, but a user may need to reload the EA after history sync completes.
- This is acceptable for v0.1 but should be noted.

## Required Fixes

Before approval for live terminal use:

- Compile in MetaEditor and resolve any compiler errors or warnings.

Recommended but not blocking for v0.1:

- Document that broker-specific symbol names must be entered exactly.
- Document that users may need to reload the EA after symbol history becomes available.
- Consider adding an input for timer interval in a later version.

## Approval Decision

Decision: **Approved For MetaEditor Compile Validation**

The implementation matches the approved spec in the critical areas:

- Alert-only safety.
- Closed-candle EMA34/EMA89 crossover behavior.
- Startup historical alert prevention.
- Duplicate prevention.
- Telegram failure retry safety.
- MT5 symbol, history, handle, and buffer checks.

The required channel-disabled fix has been applied. Final live-terminal approval should still wait until:

1. The file is compiled in MetaEditor.
2. Any compiler errors or warnings are resolved.

No trading-safety blocker was found.
