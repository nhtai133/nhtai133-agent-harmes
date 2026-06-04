# TNPA Risk Management Rules

## Purpose

This file defines the risk management component for TNPA Trading Skill v1.

Main skill:

- `skills/trading/tnpa/skill.md`

## Minimum Risk-Reward

Minimum RR:

- `1:2`

A setup should not be accepted if expected reward is less than two times the expected risk.

## Alignment Requirement

Do not trade if trend, momentum, and setup are not aligned.

Required alignment:

- Higher-timeframe trend supports direction.
- EMA21/EMA34/EMA89 structure supports direction.
- RSI14 versus RSI SMA50 supports direction.
- Entry setup is one of the approved setup types.
- Risk-reward is at least 1:2.

## Avoidance Zones

Supply Demand and Support Resistance zones are used to avoid bad entries.

Risk quality is weaker when:

- Long setup breaks into nearby resistance or supply.
- Short setup breaks into nearby support or demand.
- The nearest obstacle prevents at least 1:2 RR.

## Do-Not-Trade Conditions

Do not trade when:

- The idea trades against H4 trend.
- Price is trapped between EMA21 and EMA34.
- Trend structure is unclear.
- RSI14 does not confirm direction against RSI SMA50.
- The setup is not a price trendline breakout or Trading Range / Rectangle breakout.
- Minimum RR is below 1:2.
- The setup runs into Supply Demand or Support Resistance obstruction.
- TD Sequential Setup 9 or Countdown 13 is the only signal.
- Volume climax near wave ending warns against continuation.
- The AI would need to invent rules to justify the trade.

## Agent Checklist

Before accepting a setup, an AI agent should ask:

1. Is the proposed trade aligned with H4 trend?
2. Is EMA structure valid?
3. Is RSI momentum valid?
4. Is the entry setup approved?
5. Is there enough room to achieve at least 1:2 RR?
6. Are nearby zones blocking the trade?
7. Is the signal relying on TD Sequential alone?
8. Is any rule being invented?

If the answer reveals missing alignment, insufficient RR, or invented logic, reject the setup.

## Safety Boundary

These risk rules define analysis and validation boundaries only.

They do not authorize:

- Order placement.
- Position sizing automation.
- Stop-loss execution.
- Take-profit execution.
- Broker credential handling.
- Live trade management.

Execution requires explicit human approval and a separate implementation specification.
