# TNPA Telegram Alert EA Design Review v2

## Review Scope

Reviewed file:

- `specs/tnpa_telegram_alert_ea_spec.md`

Review role:

- Tester
- Reviewer

This review checks whether the previous design blockers were resolved:

1. Signal trigger ambiguity
2. Telegram failure behavior
3. Duplicate alert rules
4. Startup/restart behavior
5. MT5 WebRequest, symbol, history, and indicator constraints

No MQ5 code was written. The specification was not modified.

## Resolved Items

### 1. Signal Trigger Ambiguity

Status: **Resolved**

The revised spec now defines v0.1 as a crossover or trend-change alert only:

- BUY alert: EMA 34 crosses above EMA 89 on the most recently closed candle.
- SELL alert: EMA 34 crosses below EMA 89 on the most recently closed candle.
- The prior closed candle is used to confirm the previous EMA relationship.
- The most recently closed candle is used as the current signal candle.
- Alerts are based on closed candles only.
- Alerts must not fire on every candle during the same trend state.
- EMA equality on the most recently closed candle produces no alert.
- Close price is specified as the EMA applied price unless later changed by approved specification.

This is clear enough for implementation planning and testing.

### 2. Telegram Failure Behavior

Status: **Resolved**

The revised spec now defines Telegram failure behavior:

- Telegram success must be confirmed before marking an alert as sent.
- Failed sends are logged.
- Failed sends create or update a pending failed alert record.
- Retry spam is prohibited.
- One retry is allowed on the next timer cycle only if the same closed candle is still the latest signal.
- Failed retries expire or clear so they do not repeat indefinitely.
- Older failed alerts are not retried if a newer candle appears.

This resolves the prior risk of permanent missed alerts from premature success marking and repeated retry spam.

### 3. Duplicate Alert Rules

Status: **Resolved**

The revised spec replaces `lastAlertBarTime` with `lastSuccessfulAlertBarTime` and separates failed alert tracking:

- `lastSuccessfulAlertBarTime` is tracked per symbol and timeframe.
- Pending failed alerts are tracked separately.
- Pending failed alert tracking includes symbol, timeframe, closed-candle time, signal direction, and retry status.
- The EA must never send more than one successful alert per closed candle per symbol per timeframe.
- Failed Telegram sends do not update `lastSuccessfulAlertBarTime`.

This is sufficient for v0.1 duplicate prevention.

### 4. Startup/Restart Behavior

Status: **Resolved**

The revised spec now states:

- Do not send historical alerts on EA startup.
- Initialize monitoring state from the latest available closed candle.
- Start evaluating alerts from the next newly closed candle after initialization.
- Do not backfill historical alerts after restart.

This resolves the prior ambiguity around attach-time and restart-time historical signals.

### 5. MT5 WebRequest, Symbol, History, And Indicator Constraints

Status: **Resolved**

The revised spec now requires:

- Telegram API URL allowed in MT5 WebRequest settings.
- Symbol availability validation before monitoring each symbol.
- Enough historical data for EMA 34/89 calculation.
- Safe handling for invalid indicator handles.
- Safe handling for unavailable indicator buffer data.
- Safe failure without order placement or trading behavior.

The testing checklist now includes WebRequest permission, unavailable symbols, insufficient history, invalid handles, and missing buffer data.

## Remaining Risks

### 1. Broker-Specific Symbol Names

The spec requires symbol availability validation, but broker suffixes or prefixes may still require user adjustment. This is acceptable for v0.1 if unavailable symbols are reported clearly.

### 2. Telegram Success Criteria

The spec requires Telegram confirmation before marking success, but implementation must define exactly what response counts as success. This is an implementation detail, not a design blocker.

### 3. Timer Cycle Definition

The spec refers to "next timer cycle" for one retry. Implementation must define the timer interval and ensure retry behavior does not occur on every tick. This should be handled in implementation notes and tests.

### 4. State Persistence

The spec intentionally avoids historical backfill on startup and restart. It does not require persistent alert state across restarts. This is acceptable for v0.1 but should remain visible as a future enhancement if users expect continuity.

### 5. TNPA Filters

TNPA filters remain deferred. The spec correctly says they must not change v0.1 alert behavior without later approved specification. This remains a future integration gap, not a blocker for the EMA crossover alert EA.

### 6. Strategy Tester Limits

Telegram delivery may not be fully testable in MT5 Strategy Tester due to WebRequest limitations. Manual or live-terminal demo validation may be required for Telegram delivery behavior.

## Implementation Readiness

Status: **Ready For Scoped MQ5 Implementation After Human Approval**

The revised specification is now implementation-ready for v0.1 under the following boundaries:

- Alert-only EA.
- No order placement.
- No position modification.
- No broker credential handling.
- Symbols: `XAUUSD`, `EURUSD`, `BTCUSD`.
- Primary timeframe: `H1`.
- Signal trigger: EMA 34/89 closed-candle crossover only.
- Startup behavior: no historical alerts.
- Telegram failure behavior: log, one retry on next timer cycle, no retry spam.
- Duplicate prevention: `lastSuccessfulAlertBarTime` plus pending failed alert tracking.
- MT5 safety: validate WebRequest setup, symbol availability, sufficient history, indicator handles, and buffers.

Tester readiness:

- The testing checklist is now specific enough to guide implementation validation.
- Additional implementation-level tests should define exact Telegram success response handling and timer interval behavior.

Reviewer readiness:

- The prior blockers are resolved.
- Remaining risks are implementation details or future v0.2+ concerns.
- The spec still correctly blocks trading behavior and TNPA filter behavior until later approval.

## Approval Decision

Decision: **Approved For Implementation Planning**

The specification is approved to move from design review into scoped MQ5 implementation planning, subject to explicit human approval before code is written.

Implementation should remain limited to the v0.1 scope. Any request to add order placement, position modification, broker integration, account-specific behavior, TNPA filters, or additional signal logic requires a separate approval gate and specification update.
