# TNPA Skill Read Test Report

## Purpose

Run the TNPA skill read-test after improving TNPA Trading Skill v1 with a formal AI Agent Output Format and worked examples.

Important constraint:

- This report only uses information from the TNPA skill files under `skills/trading/tnpa/`.
- No TNPA rules are invented.
- No application code was reviewed or modified for this report.

## Files Found

Repository search found one file named `skill.md`:

```text
skills/trading/tnpa/skill.md
```

## Files Read

The following TNPA skill files were read:

- `skills/trading/tnpa/skill.md`
- `skills/trading/tnpa/ema-21-34-89.md`
- `skills/trading/tnpa/rsi-trendline.md`
- `skills/trading/tnpa/trading-range.md`
- `skills/trading/tnpa/risk-management.md`

## TNPA Rules Extracted

### Trend Rules

- Main context timeframes are `H4`, `H1`, and above.
- `M15` is only for signal detection when aligned with the higher-timeframe trend.
- Do not trade against the `H4` trend.
- A valid TNPA trade idea or alert requires alignment between higher-timeframe trend, EMA structure, RSI momentum, approved entry setup, risk management, and avoidance zones.
- If trend, momentum, and setup are not aligned, do not mark the setup as valid.

### EMA Rules

- Trend structure uses `EMA21`, `EMA34`, and `EMA89`.
- Bull trend requires EMA21 > EMA34 > EMA89.
- Bull trend also requires price to close above the EMA structure.
- Bear trend requires EMA21 < EMA34 < EMA89.
- Bear trend also requires price to close below the EMA structure.
- Do not validate a trade setup when price is trapped between EMA21 and EMA34.
- Do not validate a setup when EMA21, EMA34, and EMA89 are mixed or not clearly stacked.
- Do not validate a setup when price closes inside the EMA structure.
- Do not validate a lower-timeframe signal that conflicts with H1, H4, or higher timeframe trend.
- Do not validate a setup when the proposed direction trades against H4 trend.

### RSI Rules

- Use `RSI14`.
- Use `RSI SMA50`.
- RSI14 must be compared with RSI SMA50 before momentum is accepted.
- Bull momentum requires RSI14 > RSI SMA50.
- Bear momentum requires RSI14 < RSI SMA50.
- RSI momentum supports a setup only when trend and entry setup are also aligned.
- Do not validate a setup when RSI14 does not support the proposed direction versus RSI SMA50.
- Do not validate a setup when RSI confirms momentum but EMA trend is invalid.
- Do not validate a setup when RSI confirms momentum but price setup is not one of the approved setups.

### RSI Trendline Rules

- RSI trendline breakout confirms momentum shift.
- A bullish RSI trendline breakout can confirm a bullish momentum shift.
- A bearish RSI trendline breakout can confirm a bearish momentum shift.
- RSI trendline breakout is confirmation only.
- RSI trendline breakout is not a standalone entry.
- RSI trendline breakout does not override invalid EMA structure.
- RSI trendline breakout does not override H4 trend.
- RSI trendline breakout does not validate a setup without one of the approved entry setups.

### Trading Range Rules

- Trading Range / Rectangle breakout is one of the two approved TNPA entry setups.
- A Trading Range / Rectangle breakout may be valid only when price breaks out of a defined range or rectangle.
- Breakout direction must align with higher-timeframe trend.
- EMA structure must support the breakout direction.
- RSI momentum must support the breakout direction.
- Breakout must not be into nearby Supply Demand or Support Resistance obstruction.
- Risk-reward must be at least 1:2.
- Breakout volume greater than Volume MA20 is preferred.
- Dry-up volume before breakout is preferred.
- Do not treat a rectangle breakout as valid when trend, RSI momentum, and risk are not aligned.

### Entry Setup Rules

- TNPA Trading Skill v1 allows only two main entry setups:
  - Price trendline breakout.
  - Trading Range / Rectangle breakout.
- No other entry setup is approved by this skill.
- Both approved setups require trend and momentum alignment.
- Price trendline breakout may be valid only when higher-timeframe trend, EMA structure, RSI momentum, H4 direction, and minimum RR align.
- Breakout volume greater than Volume MA20 is preferred.
- Dry-up volume before breakout is preferred.
- Volume climax near wave ending is a warning.
- Supply Demand and Support Resistance zones are used to avoid bad entries.
- TD Sequential Setup 9 or Countdown 13 is confirmation only.
- TD Sequential Setup 9 or Countdown 13 is not a standalone entry.

### Risk Management Rules

- Minimum risk-reward ratio is `1:2`.
- A setup should not be accepted if expected reward is less than two times expected risk.
- Risk validation must happen before a setup is treated as actionable.
- Required alignment includes:
  - Higher-timeframe trend supports direction.
  - EMA21/EMA34/EMA89 structure supports direction.
  - RSI14 versus RSI SMA50 supports direction.
  - Entry setup is one of the approved setup types.
  - Risk-reward is at least 1:2.
- Risk quality is weaker when:
  - Long setup breaks into nearby resistance or supply.
  - Short setup breaks into nearby support or demand.
  - The nearest obstacle prevents at least 1:2 RR.

### Do-Not-Trade Rules

Do not trade when:

- The setup trades against H4 trend.
- Price is trapped between EMA21 and EMA34.
- Trend, momentum, and setup are not aligned.
- EMA structure is unclear, mixed, or not clearly stacked.
- Price closes inside the EMA structure.
- RSI14 does not confirm direction against RSI SMA50.
- The setup is not a price trendline breakout or Trading Range / Rectangle breakout.
- The breakout is into nearby Supply Demand or Support Resistance obstruction.
- Risk-reward is less than 1:2.
- TD Sequential Setup 9 or Countdown 13 is the only signal.
- Volume climax near wave ending warns against continuation.
- The trade idea requires invented rules not defined in the skill.
- Lower-timeframe signal conflicts with higher-timeframe trend.

### AI Agent Output Format

The TNPA main skill now defines a formal markdown output template with these fields:

- Signal Type
- Symbol
- Timeframe
- Trading Style
- Market Context
- H4 Trend
- H1 Trend
- Signal Timeframe Trend
- EMA Alignment
- RSI14 vs RSI SMA50
- RSI Trendline Status
- Trading Range Status
- Price Trendline Status
- Volume Confirmation
- Supply Demand / Support Resistance Risk
- TD Sequential Confirmation
- Setup Type
- Direction
- Entry Condition
- Invalid Condition
- Risk Reward Requirement
- Final Verdict
- Reasoning Summary
- Do-Not-Trade Warning

Allowed `Final Verdict` values:

- `VALID SETUP`
- `WATCHLIST`
- `NO TRADE`

Allowed `Direction` values:

- `BUY`
- `SELL`
- `NEUTRAL`

Allowed `Setup Type` values:

- `PRICE_TRENDLINE_BREAKOUT`
- `TRADING_RANGE_BREAKOUT`
- `NONE`

The main skill also includes worked examples that follow the exact output format.

## Improvement Made

Updated:

- `skills/trading/tnpa/skill.md`

Improvement:

- Added formal `## AI Agent Output Format`.
- Added allowed values for `Final Verdict`, `Direction`, and `Setup Type`.
- Added three worked examples:
  - Valid BUY Trading Range breakout.
  - Valid SELL price trendline breakout.
  - NO TRADE mixed-context rejection.

The examples are hypothetical rule-application examples and are not live trading signals.

## Files Updated

- `skills/trading/tnpa/skill.md`
- `docs/tnpa-skill-read-test-report.md`

## Clarity For Agent Harmes, Codex, And Claude Code

### Agent Harmes

Status: **Clear enough for routing, rule checking, and standardized TNPA setup output**

Agent Harmes can load `skills/trading/tnpa/skill.md` first, then load the four supporting files. The skill gives enough structure to classify TNPA trading tasks, check setup validity, enforce do-not-trade boundaries, and output a consistent TNPA setup assessment.

### Codex

Status: **Clear enough for markdown, specifications, reviews, and implementation planning**

Codex can use the skill files to write specifications, validation plans, reviews, and implementation-ready behavior descriptions. The skill now provides a standard output format and examples. Code conversion would still require a separate approved implementation specification.

### Claude Code

Status: **Clear enough for reasoning, documentation, and consistent structured output**

Claude Code can use the rules for analysis and document generation. The formal template and worked examples reduce ambiguity for consistent autonomous reasoning.

## Missing Or Unclear Parts

### Missing

- No exact definition of how to draw a price trendline.
- No exact definition of how to draw an RSI trendline.
- No exact definition of a Trading Range / Rectangle.
- No exact definition of Supply Demand zones.
- No exact definition of Support Resistance zones.
- No exact definition of Volume MA20 calculation source.
- No rule for what to do when H4 and H1 disagree except the hard rule not to trade against H4 trend.
- No rule for stop placement.
- No rule for target placement.
- No rule for position sizing.
- No rule for session filters.
- No rule for news filters.

### Unclear

- Whether volume greater than Volume MA20 is required or only preferred.
- Whether dry-up volume is required or only preferred.
- How close price can be to Supply Demand or Support Resistance before the setup is invalid.
- Whether TD Sequential confirmation changes confidence level or only acts as supporting context.
- Whether M15 signal detection can trigger alerts without H1 confirmation when H4 is aligned.

### Duplicated

The do-not-trade rules are repeated across:

- `skills/trading/tnpa/skill.md`
- `skills/trading/tnpa/ema-21-34-89.md`
- `skills/trading/tnpa/rsi-trendline.md`
- `skills/trading/tnpa/risk-management.md`

This duplication is useful for readability, but future edits could drift unless `skill.md` remains the source of truth.

### Conflicting

No direct conflicts were found inside the TNPA skill files.

## Recommendation For Improvement

Recommended next improvement:

Create deeper worked examples and drawing rules for the discretionary chart components.

Suggested files:

```text
skills/trading/tnpa/examples/valid-buy-trading-range-breakout.md
skills/trading/tnpa/examples/valid-sell-price-trendline-breakout.md
skills/trading/tnpa/examples/no-trade-between-ema21-ema34.md
skills/trading/tnpa/price-trendline-definition.md
skills/trading/tnpa/rsi-trendline-definition.md
skills/trading/tnpa/supply-demand-support-resistance.md
```

Recommended next improvements:

- Define how to draw price trendlines.
- Define how to draw RSI trendlines.
- Define Trading Range / Rectangle identification criteria.
- Define Supply Demand and Support Resistance zone identification criteria.
- Define when `WATCHLIST` should be used instead of `NO TRADE`.
- Define how close price can be to an obstacle before the setup fails.

## Final Verdict

**PASS**

Reason:

- The TNPA skill files are now discoverable and readable.
- The core TNPA rules are clear enough for Agent Harmes, Codex, and Claude Code to use for analysis, specifications, reviews, and validation planning.
- The main skill now includes a formal AI Agent Output Format.
- The main skill now includes worked examples that follow the requested output format.
- Remaining gaps are refinement items for chart-drawing definitions and deeper examples, not blockers for skill usage.
