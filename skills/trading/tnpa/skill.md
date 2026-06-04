# TNPA Trading Skill v1

## Purpose

TNPA Trading Skill v1 defines the core trading rules Agent Harmes should use when reasoning about TNPA-style trading systems, alerts, specifications, reviews, and validation plans.

This skill is for structured trading analysis and signal-system design. It is not permission to place trades, execute orders, manage positions, or handle broker credentials.

## When To Use

Use this skill when the user asks Agent Harmes to:

- Build or review a TNPA Signal System.
- Define TNPA alert logic.
- Analyze whether a TNPA setup is valid.
- Review an EA or dashboard against TNPA trading rules.
- Create a TNPA trading specification, test plan, or review.

Related supporting files:

- `skills/trading/tnpa/ema-21-34-89.md`
- `skills/trading/tnpa/rsi-trendline.md`
- `skills/trading/tnpa/trading-range.md`
- `skills/trading/tnpa/risk-management.md`

## Core Principle

Do not invent trades or signals.

A valid TNPA trade idea or alert requires alignment between:

- Higher-timeframe trend.
- EMA structure.
- RSI momentum.
- Approved entry setup.
- Risk management.
- Avoidance zones and do-not-trade conditions.

If trend, momentum, and setup are not aligned, do not mark the setup as valid.

## Timeframe Rules

- Main context timeframes are `H4`, `H1`, and above.
- `M15` is only for signal detection when aligned with the higher-timeframe trend.
- Do not trade against the `H4` trend.

## Trend Rules

Trend structure uses:

- `EMA21`
- `EMA34`
- `EMA89`

Bull trend:

- EMA21 > EMA34 > EMA89.
- Price closes above the EMA structure.

Bear trend:

- EMA21 < EMA34 < EMA89.
- Price closes below the EMA structure.

Do not trade when:

- Price is trapped between EMA21 and EMA34.
- The setup would trade against the H4 trend.
- EMA structure and price close do not agree.

See:

- `skills/trading/tnpa/ema-21-34-89.md`

## EMA Rules

Use EMA21, EMA34, and EMA89 to define trend structure and trend quality.

Valid bullish context requires:

- EMA21 above EMA34.
- EMA34 above EMA89.
- Price closing above the EMA structure.

Valid bearish context requires:

- EMA21 below EMA34.
- EMA34 below EMA89.
- Price closing below the EMA structure.

Invalid or low-quality context:

- Price trapped between EMA21 and EMA34.
- EMA stack mixed or compressed.
- Price closing inside the EMA structure.
- Lower-timeframe signal not aligned with higher-timeframe trend.

## RSI Rules

Use RSI14 compared with RSI SMA50.

Bull momentum:

- RSI14 > RSI SMA50.

Bear momentum:

- RSI14 < RSI SMA50.

RSI trendline breakout confirms momentum shift.

RSI trendline breakout is confirmation. It should not override invalid trend, invalid setup, or missing risk alignment.

See:

- `skills/trading/tnpa/rsi-trendline.md`

## Entry Setup Rules

TNPA Trading Skill v1 allows only two main entry setups:

1. Price trendline breakout.
2. Trading Range / Rectangle breakout.

Both setups require trend and momentum alignment.

Preferred breakout conditions:

- Breakout volume is greater than Volume MA20.
- Dry-up volume appears before breakout.

Warnings:

- Volume climax near wave ending is a warning.
- Supply Demand and Support Resistance zones must be checked to avoid bad entries.

TD Sequential Setup 9 or Countdown 13:

- Confirmation only.
- Not a standalone entry.

See:

- `skills/trading/tnpa/trading-range.md`

## Trading Range Rules

Trading Range / Rectangle breakout is a valid setup only when:

- Higher-timeframe trend supports the breakout direction.
- RSI momentum supports the breakout direction.
- Breakout direction is not into a nearby Supply Demand or Support Resistance obstacle.
- Breakout volume is preferably greater than Volume MA20.
- Dry-up volume before breakout is preferred.

Do not treat a rectangle breakout as valid when trend, RSI momentum, and risk are not aligned.

## Risk Management Rules

Minimum risk-reward ratio:

- `1:2`

Do not accept a setup if the expected reward is less than two times the risk.

Risk validation must happen before a setup is treated as actionable.

See:

- `skills/trading/tnpa/risk-management.md`

## Do-Not-Trade Rules

Do not trade when:

- The setup trades against H4 trend.
- Price is trapped between EMA21 and EMA34.
- Trend, momentum, and setup are not aligned.
- EMA structure is unclear or mixed.
- RSI14 does not confirm direction against RSI SMA50.
- The breakout is into nearby Supply Demand or Support Resistance obstruction.
- Risk-reward is less than 1:2.
- The signal is based only on TD Sequential Setup 9 or Countdown 13.
- Volume climax near wave ending warns against continuation.
- The trade idea requires invented rules not defined in this skill.

## Agent Usage Rules

When using this skill, Agent Harmes should:

1. Load this `skill.md`.
2. Load all supporting TNPA component files.
3. Identify the target timeframe and higher-timeframe context.
4. Check H4 trend before lower-timeframe signals.
5. Check EMA structure.
6. Check RSI momentum and RSI trendline confirmation.
7. Check whether the setup is one of the two approved entry setups.
8. Check volume and avoidance zones.
9. Check minimum RR.
10. Reject the setup if required alignment is missing.

## AI Agent Output Format

Use this markdown template when reporting TNPA setup analysis.

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

Template:

```text
Signal Type:

Symbol:

Timeframe:

Trading Style:

Market Context:

H4 Trend:

H1 Trend:

Signal Timeframe Trend:

EMA Alignment:

RSI14 vs RSI SMA50:

RSI Trendline Status:

Trading Range Status:

Price Trendline Status:

Volume Confirmation:

Supply Demand / Support Resistance Risk:

TD Sequential Confirmation:

Setup Type:

Direction:

Entry Condition:

Invalid Condition:

Risk Reward Requirement:

Final Verdict:

Reasoning Summary:

Do-Not-Trade Warning:
```

Field guidance:

- `Signal Type`: Use a descriptive TNPA analysis label, not a live trading instruction.
- `Symbol`: Use the requested symbol or `Not specified`.
- `Timeframe`: Use the signal timeframe being analyzed.
- `Trading Style`: Describe context such as higher-timeframe analysis or M15 signal detection when aligned.
- `Market Context`: Summarize higher-timeframe trend and setup environment.
- `H4 Trend`: Must be checked before accepting lower-timeframe signals.
- `H1 Trend`: Supports context but must not override H4.
- `Signal Timeframe Trend`: Describe the trend on the timeframe being analyzed.
- `EMA Alignment`: State whether EMA21/EMA34/EMA89 are bullish, bearish, mixed, or price is trapped.
- `RSI14 vs RSI SMA50`: State bull momentum, bear momentum, or not aligned.
- `RSI Trendline Status`: State whether RSI trendline breakout confirms momentum shift or is not confirmed.
- `Trading Range Status`: State whether a Trading Range / Rectangle breakout exists.
- `Price Trendline Status`: State whether a price trendline breakout exists.
- `Volume Confirmation`: State whether breakout volume is greater than Volume MA20, dry-up volume appears before breakout, or volume is not confirmed.
- `Supply Demand / Support Resistance Risk`: State whether nearby zones create entry risk.
- `TD Sequential Confirmation`: Confirmation only; never standalone entry.
- `Setup Type`: Must be one of the allowed values.
- `Direction`: Must be one of the allowed values.
- `Entry Condition`: Describe the approved setup condition.
- `Invalid Condition`: Describe what would invalidate the setup.
- `Risk Reward Requirement`: Must reference minimum `1:2`.
- `Final Verdict`: Must be one of the allowed values.
- `Reasoning Summary`: Explain the verdict using only this skill's rules.
- `Do-Not-Trade Warning`: State any do-not-trade issue, or `None found under TNPA Trading Skill v1`.

## Worked Examples

These examples are hypothetical rule-application examples. They are not live trading signals.

### Example 1: Valid BUY Trading Range Breakout

```text
Signal Type:
TNPA setup analysis

Symbol:
Example symbol

Timeframe:
M15

Trading Style:
M15 signal detection aligned with higher-timeframe trend

Market Context:
H4 and H1 support bullish context, and the M15 breakout is aligned with the higher-timeframe trend.

H4 Trend:
Bull trend

H1 Trend:
Bull trend

Signal Timeframe Trend:
Bull trend

EMA Alignment:
EMA21 > EMA34 > EMA89, and price closes above the EMA structure.

RSI14 vs RSI SMA50:
RSI14 > RSI SMA50.

RSI Trendline Status:
Bullish RSI trendline breakout confirms momentum shift.

Trading Range Status:
Trading Range / Rectangle breakout confirmed.

Price Trendline Status:
No price trendline breakout used for this setup.

Volume Confirmation:
Breakout volume is greater than Volume MA20, with dry-up volume before breakout.

Supply Demand / Support Resistance Risk:
No nearby Supply Demand or Support Resistance obstruction identified in this example.

TD Sequential Confirmation:
Not used.

Setup Type:
TRADING_RANGE_BREAKOUT

Direction:
BUY

Entry Condition:
Trading Range / Rectangle breakout aligned with H4 trend, EMA bull structure, RSI bull momentum, RSI trendline breakout, and volume confirmation.

Invalid Condition:
Invalid if price returns between EMA21 and EMA34, RSI14 falls below RSI SMA50, breakout fails, or nearby Supply Demand / Support Resistance blocks minimum RR.

Risk Reward Requirement:
RR >= 1:2.

Final Verdict:
VALID SETUP

Reasoning Summary:
Trend, EMA alignment, RSI momentum, RSI trendline confirmation, approved Trading Range breakout setup, volume confirmation, and minimum RR are aligned.

Do-Not-Trade Warning:
None found under TNPA Trading Skill v1.
```

### Example 2: Valid SELL Price Trendline Breakout

```text
Signal Type:
TNPA setup analysis

Symbol:
Example symbol

Timeframe:
H1

Trading Style:
H1 signal aligned with H4 trend

Market Context:
H4 and H1 support bearish context, and the price trendline breakout is aligned with the higher-timeframe trend.

H4 Trend:
Bear trend

H1 Trend:
Bear trend

Signal Timeframe Trend:
Bear trend

EMA Alignment:
EMA21 < EMA34 < EMA89, and price closes below the EMA structure.

RSI14 vs RSI SMA50:
RSI14 < RSI SMA50.

RSI Trendline Status:
RSI trendline status supports bearish momentum shift.

Trading Range Status:
No Trading Range / Rectangle breakout used for this setup.

Price Trendline Status:
Price trendline breakout confirmed.

Volume Confirmation:
Breakout volume is greater than Volume MA20, with dry-up volume before breakout.

Supply Demand / Support Resistance Risk:
No nearby Supply Demand or Support Resistance obstruction identified in this example.

TD Sequential Confirmation:
Confirmation only if present; not required as standalone entry.

Setup Type:
PRICE_TRENDLINE_BREAKOUT

Direction:
SELL

Entry Condition:
Price trendline breakout aligned with H4 trend, EMA bear structure, RSI bear momentum, and volume confirmation.

Invalid Condition:
Invalid if price closes back inside the EMA structure, RSI14 rises above RSI SMA50, trendline breakout fails, or nearby Support / Demand blocks minimum RR.

Risk Reward Requirement:
RR >= 1:2.

Final Verdict:
VALID SETUP

Reasoning Summary:
Trend, EMA alignment, RSI momentum, approved price trendline breakout setup, volume confirmation, and minimum RR are aligned.

Do-Not-Trade Warning:
None found under TNPA Trading Skill v1.
```

### Example 3: NO TRADE Mixed Context

```text
Signal Type:
TNPA setup analysis

Symbol:
Example symbol

Timeframe:
M15

Trading Style:
M15 signal detection requires higher-timeframe alignment

Market Context:
The setup is not valid because price is trapped between EMA21 and EMA34 and the lower-timeframe idea conflicts with required alignment.

H4 Trend:
Conflicts with proposed direction

H1 Trend:
Not aligned

Signal Timeframe Trend:
Unclear

EMA Alignment:
Price is trapped between EMA21 and EMA34, and EMA structure is not valid for the proposed direction.

RSI14 vs RSI SMA50:
Momentum is not aligned with trend and setup.

RSI Trendline Status:
No valid RSI trendline confirmation for an aligned setup.

Trading Range Status:
No valid Trading Range / Rectangle breakout.

Price Trendline Status:
No valid price trendline breakout.

Volume Confirmation:
Not confirmed.

Supply Demand / Support Resistance Risk:
Unclear or unresolved.

TD Sequential Confirmation:
Not sufficient for entry; TD Sequential is confirmation only.

Setup Type:
NONE

Direction:
NEUTRAL

Entry Condition:
No approved entry condition is present.

Invalid Condition:
Price is trapped between EMA21 and EMA34, trend/momentum/setup are not aligned, and H4 trend conflicts with the proposed direction.

Risk Reward Requirement:
Minimum RR >= 1:2 is not enough to override invalid trend, momentum, or setup alignment.

Final Verdict:
NO TRADE

Reasoning Summary:
The setup fails TNPA alignment rules. Price is trapped between EMA21 and EMA34, trend and momentum are not aligned, and no approved entry setup is confirmed.

Do-Not-Trade Warning:
Do not trade when price is trapped between EMA21 and EMA34, trend/momentum/setup are not aligned, or the setup trades against H4 trend.
```

## Safety Boundary

This skill does not authorize:

- Order placement.
- Position modification.
- Broker credential handling.
- Live-trading automation.
- Financial advice.

Any move from alerting or analysis into trade execution requires explicit human approval and a separate specification.
