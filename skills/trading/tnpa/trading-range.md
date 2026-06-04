# TNPA Trading Range And Breakout Rules

## Purpose

This file defines the approved TNPA entry setup component for price trendline breakouts and Trading Range / Rectangle breakouts.

Main skill:

- `skills/trading/tnpa/skill.md`

## Approved Entry Setups

TNPA Trading Skill v1 allows only two main entry setups:

1. Price trendline breakout.
2. Trading Range / Rectangle breakout.

No other entry setup is approved by this skill.

## Price Trendline Breakout

A price trendline breakout may be valid only when:

- Higher-timeframe trend supports the breakout direction.
- EMA21/EMA34/EMA89 structure supports the breakout direction.
- RSI14 confirms momentum versus RSI SMA50.
- The breakout is not against H4 trend.
- Risk-reward is at least 1:2.

Preferred confirmation:

- Breakout volume is greater than Volume MA20.
- Dry-up volume appears before breakout.

Warning:

- Volume climax near wave ending is a warning.

## Trading Range / Rectangle Breakout

A Trading Range / Rectangle breakout may be valid only when:

- Price breaks out of a defined range or rectangle.
- Breakout direction aligns with higher-timeframe trend.
- EMA structure supports breakout direction.
- RSI momentum supports breakout direction.
- Breakout is not into nearby Supply Demand or Support Resistance obstruction.
- Risk-reward is at least 1:2.

Preferred confirmation:

- Breakout volume is greater than Volume MA20.
- Dry-up volume appears before breakout.

## Volume Rules

Preferred:

- Breakout with volume greater than Volume MA20.
- Dry-up volume before breakout.

Warning:

- Volume climax near wave ending is a warning.

Volume should support the setup, but this skill does not define volume as a standalone entry.

## Supply Demand And Support Resistance Rules

Supply Demand and Support Resistance zones are used to avoid bad entries.

An AI agent should check whether the proposed breakout runs directly into:

- Supply zone.
- Demand zone.
- Support zone.
- Resistance zone.

If the breakout has poor room to move because of these zones, the setup should not be accepted without further human review.

## TD Sequential Rule

TD Sequential Setup 9 or Countdown 13 is confirmation only.

It is not a standalone entry.

Do not validate a trade idea only because TD Sequential confirms exhaustion or timing.

## Agent Checklist

Before accepting a breakout setup, an AI agent should ask:

1. Is the setup a price trendline breakout or Trading Range / Rectangle breakout?
2. Does the breakout align with H4 trend?
3. Does EMA structure support the direction?
4. Does RSI momentum support the direction?
5. Is breakout volume greater than Volume MA20?
6. Was there dry-up volume before breakout?
7. Is there volume climax near wave ending?
8. Is the breakout into Supply Demand or Support Resistance?
9. Is minimum RR at least 1:2?

If the setup is not one of the two approved entry setups, do not validate it under TNPA Trading Skill v1.
