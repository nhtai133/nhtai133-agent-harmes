# TNPA Skill Created Report

## Purpose

Document the first TNPA trading skill package created for Agent Harmes.

This report covers markdown skill documents only. No application code was created.

## Files Created

- `skills/trading/tnpa/skill.md`
- `skills/trading/tnpa/ema-21-34-89.md`
- `skills/trading/tnpa/rsi-trendline.md`
- `skills/trading/tnpa/trading-range.md`
- `skills/trading/tnpa/risk-management.md`
- `docs/tnpa-skill-created-report.md`

## Purpose Of Each File

### `skills/trading/tnpa/skill.md`

Main entry point for TNPA Trading Skill v1.

Defines:

- When to use the skill.
- Core TNPA trading principle.
- Timeframe rules.
- Trend rules.
- EMA rules.
- RSI rules.
- Entry setup rules.
- Trading Range rules.
- Risk management rules.
- Do-not-trade rules.
- Agent usage sequence.
- Safety boundary.

### `skills/trading/tnpa/ema-21-34-89.md`

Defines the EMA trend-structure component.

Covers:

- EMA21, EMA34, EMA89 structure.
- Bull trend conditions.
- Bear trend conditions.
- H4 trend rule.
- M15 signal-detection boundary.
- Invalid EMA contexts.

### `skills/trading/tnpa/rsi-trendline.md`

Defines the RSI momentum and RSI trendline confirmation component.

Covers:

- RSI14 versus RSI SMA50.
- Bull momentum.
- Bear momentum.
- RSI trendline breakout as momentum shift confirmation.
- RSI trendline breakout as confirmation only, not standalone entry.

### `skills/trading/tnpa/trading-range.md`

Defines the approved breakout setup component.

Covers:

- Price trendline breakout.
- Trading Range / Rectangle breakout.
- Volume greater than Volume MA20 preference.
- Dry-up volume preference.
- Volume climax warning.
- Supply Demand and Support Resistance avoidance.
- TD Sequential confirmation-only rule.

### `skills/trading/tnpa/risk-management.md`

Defines TNPA risk management and invalidation boundaries.

Covers:

- Minimum RR of 1:2.
- Required alignment between trend, momentum, setup, and risk.
- Avoidance zones.
- Do-not-trade conditions.
- Safety boundary against trade execution.

## How Agent Harmes Should Load These Files

When a user request involves TNPA trading, TNPA Signal Systems, EA logic, market setup validation, or TNPA review, Commander should load:

1. `skills/trading/tnpa/skill.md`
2. `skills/trading/tnpa/ema-21-34-89.md`
3. `skills/trading/tnpa/rsi-trendline.md`
4. `skills/trading/tnpa/trading-range.md`
5. `skills/trading/tnpa/risk-management.md`

Recommended load order:

1. Load `skill.md` first to establish scope and safety boundaries.
2. Load `ema-21-34-89.md` to determine trend context.
3. Load `rsi-trendline.md` to determine momentum confirmation.
4. Load `trading-range.md` to validate approved entry setups.
5. Load `risk-management.md` to confirm RR, avoidance zones, and do-not-trade rules.

Commander should also load TNPA project memory when the task belongs to TNPA Trading OS:

- `projects/tnpa-trading-os/project_context.md`
- `projects/tnpa-trading-os/project_rules.md`
- `projects/tnpa-trading-os/project_memory.md`

## Next Recommended Improvement

Create structured examples for each TNPA rule category.

Recommended next files:

- `skills/trading/tnpa/examples/bull-trend-valid.md`
- `skills/trading/tnpa/examples/bear-trend-valid.md`
- `skills/trading/tnpa/examples/do-not-trade-price-between-ema21-ema34.md`
- `skills/trading/tnpa/examples/trading-range-breakout-valid.md`
- `skills/trading/tnpa/examples/trading-range-breakout-invalid.md`

Each example should include:

- Market context.
- Timeframe.
- EMA structure.
- RSI state.
- Setup type.
- Volume condition.
- Nearby Supply Demand or Support Resistance.
- RR check.
- Verdict.
- Reason.

This would make the skill easier for an AI agent to apply consistently without inventing missing rules.

## Status

TNPA Trading Skill v1 has been created as a markdown-only skill package.

No implementation code was created.
