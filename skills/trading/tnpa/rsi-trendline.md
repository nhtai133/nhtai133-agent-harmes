# TNPA RSI Trendline Rules

## Purpose

This file defines the RSI momentum and RSI trendline confirmation component for TNPA Trading Skill v1.

Main skill:

- `skills/trading/tnpa/skill.md`

## RSI Inputs

Use:

- `RSI14`
- `RSI SMA50`

RSI14 must be compared with RSI SMA50 before momentum is accepted.

## Bull Momentum

Bull momentum requires:

- RSI14 > RSI SMA50.

This supports bullish setups only when trend and entry setup are also aligned.

## Bear Momentum

Bear momentum requires:

- RSI14 < RSI SMA50.

This supports bearish setups only when trend and entry setup are also aligned.

## RSI Trendline Breakout

RSI trendline breakout confirms momentum shift.

Usage:

- A bullish RSI trendline breakout can confirm a bullish momentum shift.
- A bearish RSI trendline breakout can confirm a bearish momentum shift.

Restriction:

- RSI trendline breakout is confirmation only.
- It is not a standalone entry.
- It does not override invalid EMA structure.
- It does not override H4 trend.
- It does not validate a setup without one of the approved entry setups.

## Invalid RSI Context

Do not validate a setup when:

- RSI14 does not support the proposed direction versus RSI SMA50.
- RSI trendline breakout is the only reason for entry.
- RSI confirms momentum but EMA trend is invalid.
- RSI confirms momentum but price setup is not one of the approved setups.

## Agent Checklist

Before accepting RSI confirmation, an AI agent should ask:

1. Is RSI14 above or below RSI SMA50?
2. Does RSI momentum match the proposed direction?
3. Is there an RSI trendline breakout confirming momentum shift?
4. Is RSI being used only as confirmation, not as the entry itself?
5. Are trend and setup also aligned?

If RSI momentum conflicts with trend or setup, the trade idea is not valid under TNPA Trading Skill v1.
