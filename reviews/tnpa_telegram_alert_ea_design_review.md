# TNPA Telegram Alert EA Design Review

## Review Scope

Reviewed file:

- `specs/tnpa_telegram_alert_ea_spec.md`

Review role:

- Tester
- Reviewer

Evaluation areas:

1. Missing requirements
2. Ambiguous signal definitions
3. Telegram failure scenarios
4. Duplicate alert risks
5. MT5 platform constraints
6. Future scalability concerns
7. TNPA integration gaps

No MQ5 code was written. The specification was not modified.

## Findings

### 1. Missing Requirements

- The spec does not define whether an alert should fire on every candle where EMA 34 remains above or below EMA 89, or only when the trend state changes.
- The spec does not define whether the signal should be based on EMA crossover, EMA state, slope, distance, or trend continuation.
- The spec does not define startup behavior. If the EA is attached mid-trend, it is unclear whether it should alert on the latest closed candle immediately or wait for the next closed candle.
- The spec does not define what happens when the EA restarts and `lastAlertBarTime` is reset or lost.
- The spec does not define whether alert state must persist across terminal restarts.
- The spec does not define whether alerts should be enabled or disabled per symbol.
- The spec does not define whether symbols should be validated at initialization or skipped dynamically during runtime.
- The spec does not define maximum retry behavior, cooldowns, or failure logging for Telegram delivery.
- The spec does not define whether the Telegram token and chat ID should be masked in all runtime messages and error logs.
- The spec does not define how unavailable history, missing bars, invalid handles, or indicator calculation failures should be handled.

### 2. Ambiguous Signal Definitions

- "EMA 34 is above EMA 89" and "EMA 34 is below EMA 89" define trend state, not alert trigger timing.
- "Neutral condition" is ambiguous because EMA 34 and EMA 89 will usually have a defined above or below state unless equal or unavailable.
- The spec does not define how exact EMA equality should be handled.
- The spec does not define whether alerts should fire only on a fresh trend change from bearish to bullish or bullish to bearish.
- The spec does not define whether alerts should fire repeatedly on every closed candle while the same trend state remains active.
- The spec does not define whether EMA values are calculated from close price, although that is the likely default expectation.
- The spec does not specify required bar indexes for previous and current closed candle evaluation.

### 3. Telegram Failure Scenarios

- The spec says to fail safely if Telegram configuration is missing or invalid, but does not define the expected behavior.
- The spec does not define behavior for MT5 `WebRequest` not being allowed in terminal options.
- The spec does not define behavior for network timeout, invalid bot token, invalid chat ID, Telegram API rejection, rate limiting, or malformed message payload.
- The spec does not define whether `lastAlertBarTime` should update if Telegram delivery fails.
- If `lastAlertBarTime` updates before a failed Telegram send, the alert may be permanently missed.
- If `lastAlertBarTime` does not update after a failed Telegram send, repeated ticks may spam retries.
- The spec does not define whether failed alerts should be retried, skipped, queued, or logged only.

### 4. Duplicate Alert Risks

- `lastAlertBarTime` per symbol and timeframe prevents duplicate alerts for a closed candle, but it may suppress opposite-direction alerts on the same candle if future signal types are added.
- The current duplicate model does not distinguish signal direction.
- The current duplicate model does not define persistence across EA reloads, terminal restarts, timeframe changes, or input changes.
- Multi-symbol and multi-timeframe tracking requires a reliable key structure; the spec defines the concept but not the required uniqueness rule.
- If alerts are evaluated on every tick, timing around new-bar detection must be precise to avoid duplicate sends at candle transition.
- If one Telegram send fails, duplicate prevention behavior could either lose the alert or retry too aggressively unless explicitly defined.

### 5. MT5 Platform Constraints

- MT5 Telegram delivery normally requires `WebRequest` permissions for the Telegram API URL in terminal settings; the spec mentions web requests but not the exact operator-facing requirement.
- MT5 Strategy Tester behavior for external web requests may be limited or unsuitable for full Telegram delivery validation.
- Symbol names may vary by broker, such as suffixes or prefixes on `XAUUSD`, `EURUSD`, or `BTCUSD`.
- BTCUSD market hours and data availability may differ materially across brokers.
- Multi-symbol scanning requires symbol selection and history availability checks.
- Indicator handles and copied buffer data can fail when history is unavailable or not yet synchronized.
- Timeframe constants and user input mapping need clear constraints to avoid invalid timeframe combinations.
- Telegram token and chat ID are sensitive user inputs and should be handled as secrets even though they are not broker credentials.

### 6. Future Scalability Concerns

- The `EnableH4` and `EnableD1` input approach may become hard to scale if more timeframes are added later.
- A comma-separated `Symbols` input is practical for v0.1 but can become fragile without parsing, trimming, validation, and error reporting rules.
- Future TNPA filters may need independent enable flags, configuration, and review gates.
- Future alert types may require a more structured alert identity than symbol, timeframe, and bar time.
- The alert format may need versioning if downstream dashboards, logs, or content systems consume messages later.
- Memory and review updates should record whether v0.1 behavior is "trend-state alert" or "trend-change alert" once clarified.

### 7. TNPA Integration Gaps

- TNPA filters are intentionally deferred, but the spec does not define what "prepared for later extension" means in acceptance terms.
- The current signal is EMA-based only and should not be treated as a complete TNPA signal.
- The spec does not define how future TNPA filters will be approved before changing alert behavior.
- The spec does not define whether EMA 34/89 is an approved TNPA rule, a working assumption, or an experimental alert foundation.
- The spec does not connect the EA output to TNPA memory updates, known issues, or future improvement tracking.

## Risks

### High Risk

- Ambiguous alert trigger behavior could lead to either excessive alerts on every trend-state candle or missed alerts if the implementer assumes crossover-only behavior.
- Telegram delivery failure behavior could cause either permanent missed alerts or repeated retry spam.
- Lack of restart persistence rules could cause duplicate alerts after terminal restart or missed continuity across sessions.

### Medium Risk

- Broker-specific symbol naming could prevent the EA from monitoring expected markets.
- MT5 WebRequest setup could block Telegram delivery if not explicitly surfaced to the user.
- Multi-symbol scanning can fail silently if history or indicator data is unavailable.
- Future TNPA filters could alter behavior without a clear approval boundary.

### Low Risk

- Alert message format is adequate for v0.1 but may need versioning later.
- Optional H4 and D1 support is correctly deferred, but the current boolean approach may not scale well.
- Testing checklist is solid at a high level but needs more failure-mode detail before implementation.

## Recommendations

### Before MQ5 Implementation

- Clarify whether v0.1 alerts are trend-state alerts on every qualifying closed candle or trend-change alerts only.
- Define exact EMA calculation assumptions, including applied price and closed-bar indexes.
- Define startup behavior when the EA is attached mid-trend.
- Define whether alert state must persist across EA reloads or terminal restarts.
- Define Telegram failure behavior:
  - When to update `lastAlertBarTime`.
  - Whether to retry.
  - Retry limit or cooldown.
  - Required logging behavior.
- Define required user setup for MT5 WebRequest permissions.
- Define symbol validation behavior for missing or broker-suffixed symbols.
- Define how unavailable history, failed indicator handles, and failed buffer reads should be reported.

### Testing Recommendations

- Add tests for startup behavior.
- Add tests for terminal restart or EA reload.
- Add tests for Telegram delivery failure before and after duplicate-state update.
- Add tests for missing WebRequest permission.
- Add tests for unavailable symbol or broker-specific symbol suffix.
- Add tests for missing or insufficient candle history.
- Add tests for EMA equality or unavailable EMA values.
- Add tests confirming no order-related functions are present or invoked.

### TNPA Recommendations

- Label EMA 34/89 v0.1 as a signal foundation, not a complete TNPA signal.
- Require a later approved specification before TNPA filters can change alert behavior.
- Record unresolved TNPA integration points in project memory after implementation review.
- Define an approval gate for each future TNPA filter category.

## Approval Decision

Decision: **Needs Revision Before Implementation**

The specification is strong enough as a concept brief, but not yet precise enough for MQ5 implementation. The main blocker is ambiguous signal trigger behavior: the spec must state whether alerts fire on every closed candle while EMA 34/89 remains in trend state, or only on trend change/crossover.

Implementation should remain blocked until the high-risk ambiguities are resolved:

- Alert trigger definition.
- Telegram delivery failure behavior.
- Duplicate-state update timing.
- Startup and restart behavior.
- MT5 WebRequest and symbol/history failure handling.
