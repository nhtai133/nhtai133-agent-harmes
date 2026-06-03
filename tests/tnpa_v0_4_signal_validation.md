# TNPA v0.4 Signal Validation

## Goal

Validate all active TNPA Signal Engine v0.4 alerts in live MT5 conditions.

Scope:

- Trend Alignment
- Weekly Filter
- KC21 Momentum
- EMA21 Pullback
- Multi-timeframe scanning
- Donchian context
- Startup Telegram connection test

This plan validates alert behavior only. The EA must not place, modify, or close trades.

## Prerequisites

- Exness MT5 20.3 is running.
- `TNPA_Telegram_Alert_EA.ex5` is loaded from the confirmed Exness `MQL5\Experts` folder.
- `https://api.telegram.org` is allowed in MT5 WebRequest settings.
- `TelegramBotToken` and `TelegramChatID` are configured.
- `EnableTelegramAlert=true`.
- `SendStartupTestMessage=true`.
- Required symbols exist in Market Watch.
- Historical data is loaded for all enabled timeframes, especially `D1` and `W1`.

## Startup Telegram Test Validation

Definition:

- EA sends one connection test message after successful initialization when Telegram is enabled and credentials are configured.

Required condition:

- Attach EA with valid Telegram settings and `SendStartupTestMessage=true`.

Expected Telegram output:

```text
TNPA Telegram Alert EA Connected

Version: v0.4
Broker: <broker>
Account: <account number>
Mode: Demo or Live
Symbols: <configured symbols>
Timeframe: <configured timeframes>

Connection Test: SUCCESS
```

Validation steps:

1. Attach the EA to a demo chart.
2. Confirm Telegram inputs are configured.
3. Confirm `SendStartupTestMessage=true`.
4. Watch Telegram and the MT5 Experts log.

Pass/Fail criteria:

- Pass: exactly one startup connection message is received per EA initialization.
- Fail: no message is received with valid setup, repeated startup messages are sent during the same initialization, or signal duplicate state is affected.

## Signal 1: Trend Alignment

Definition:

- BUY when EMA21 > EMA34, EMA34 > EMA89, EMA89 > EMA200, and RSI14 > RSI_SMA50.
- SELL when EMA21 < EMA34, EMA34 < EMA89, EMA89 < EMA200, and RSI14 < RSI_SMA50.

Required market condition:

- A closed candle changes the Trend Alignment state from Neutral to BUY/SELL or from the opposite direction to BUY/SELL.

Example BUY scenario:

- EMA21 is above EMA34.
- EMA34 is above EMA89.
- EMA89 is above EMA200.
- RSI14 closes above RSI_SMA50.

Example SELL scenario:

- EMA21 is below EMA34.
- EMA34 is below EMA89.
- EMA89 is below EMA200.
- RSI14 closes below RSI_SMA50.

Telegram expected output:

```text
TNPA SIGNAL

Type: TNPA TREND ALIGNMENT

Strength:
Normal

Direction:
BUY or SELL
```

Validation steps:

1. Enable `EnableSignal_TrendAlignment=true`.
2. Use a symbol/timeframe with enough history.
3. Compare the closed-candle EMA21/34/89/200 and RSI values against MT5 chart indicators.
4. Wait for a direction change on a newly closed candle.
5. Confirm the Telegram alert values match the closed candle.

Pass/Fail criteria:

- Pass: alert fires only on valid direction change and includes correct indicator values.
- Fail: alert fires on the forming candle, repeats every candle without direction change, or fires when EMA/RSI alignment is invalid.

## Signal 2: Weekly Filter

Definition:

- BULLISH when Weekly RSI14 > 50 and Weekly Close > Weekly EMA21.
- BEARISH when Weekly RSI14 < 50 and Weekly Close < Weekly EMA21.
- Evaluated only on `W1`.

Required market condition:

- A newly closed weekly candle changes Weekly Filter state from Neutral to BUY/SELL or from the opposite direction to BUY/SELL.

Example BUY scenario:

- W1 candle closes above EMA21.
- W1 RSI14 is above 50.

Example SELL scenario:

- W1 candle closes below EMA21.
- W1 RSI14 is below 50.

Telegram expected output:

```text
TNPA SIGNAL

Type: TNPA WEEKLY FILTER

Strength:
Normal

Direction:
BUY or SELL

Signal Timeframe: W1
```

Validation steps:

1. Enable `EnableSignal_WeeklyFilter=true`.
2. Keep `Enable_W1=true`.
3. Confirm W1 history is loaded.
4. Compare W1 close, EMA21, and RSI14 against MT5 chart indicators.
5. Confirm no Weekly Filter alerts are sent on M15, M30, H1, H4, or D1.

Pass/Fail criteria:

- Pass: Weekly Filter alerts only on W1 and only on valid direction changes.
- Fail: Weekly Filter alerts on non-W1 timeframes or fires without the weekly close/RSI condition.

## Signal 3: KC21 Momentum

Definition:

- KC Mid = EMA21.
- KC Upper = EMA21 + ATR21 * KC_Multiplier.
- KC Lower = EMA21 - ATR21 * KC_Multiplier.
- BUY when Close > KC Mid and RSI14 > 50.
- STRONG BUY when Close > KC Upper and RSI14 > 50.
- SELL when Close < KC Mid and RSI14 < 50.
- STRONG SELL when Close < KC Lower and RSI14 < 50.

Required market condition:

- A closed candle changes KC21 Momentum state from Neutral to BUY/SELL or from the opposite direction to BUY/SELL.

Example BUY scenario:

- Closed candle close is above KC Mid.
- RSI14 is above 50.
- Strength is `Strong` if close is above KC Upper.

Example SELL scenario:

- Closed candle close is below KC Mid.
- RSI14 is below 50.
- Strength is `Strong` if close is below KC Lower.

Telegram expected output:

```text
TNPA SIGNAL

Type: TNPA KC21 MOMENTUM

Strength:
Normal or Strong

Direction:
BUY or SELL

KC21 Mid: <Value>
KC21 Upper: <Value>
KC21 Lower: <Value>
```

Validation steps:

1. Enable `EnableSignal_KC21Momentum=true`.
2. Confirm EMA21 and ATR21 are available for the symbol/timeframe.
3. Manually calculate KC Upper and KC Lower from closed-candle EMA21 and ATR21.
4. Compare calculated values to Telegram output.
5. Confirm strength changes to `Strong` only beyond KC Upper/Lower.

Pass/Fail criteria:

- Pass: alert direction and strength match closed-candle KC/RSI conditions.
- Fail: alert uses current forming candle, wrong KC level, wrong strength, or repeats without direction change.

## Signal 4: EMA21 Pullback

Definition:

- BUY when Trend Alignment BUY is true, previous closed candle low touches or dips below EMA21, previous closed candle closes above EMA21, and RSI14 > 50.
- SELL when Trend Alignment SELL is true, previous closed candle high touches or rises above EMA21, previous closed candle closes below EMA21, and RSI14 < 50.

Required market condition:

- A closed pullback candle satisfies the EMA21 touch-and-close rule while Trend Alignment remains valid.

Example BUY scenario:

- EMA21 > EMA34 > EMA89 > EMA200.
- RSI14 > RSI_SMA50 and RSI14 > 50.
- Closed candle low is at or below EMA21.
- Closed candle close is above EMA21.

Example SELL scenario:

- EMA21 < EMA34 < EMA89 < EMA200.
- RSI14 < RSI_SMA50 and RSI14 < 50.
- Closed candle high is at or above EMA21.
- Closed candle close is below EMA21.

Telegram expected output:

```text
TNPA SIGNAL

Type: TNPA EMA21 PULLBACK

Strength:
Normal

Direction:
BUY or SELL
```

Validation steps:

1. Enable `EnableSignal_EMA21Pullback=true`.
2. Confirm Trend Alignment is valid in the same direction.
3. Inspect the most recently closed candle.
4. Confirm low/high touched EMA21 and close finished on the required side.
5. Confirm Telegram alert is sent only on a direction change.

Pass/Fail criteria:

- Pass: alert fires only when Trend Alignment and EMA21 pullback rules are both true.
- Fail: alert fires without Trend Alignment, without EMA21 touch, on forming candle data, or repeats without direction change.

## Multi-Timeframe Validation

Validate each enabled timeframe independently:

- `M15`
- `M30`
- `H1`
- `H4`
- `D1`
- `W1`

Validation steps:

1. Enable all timeframe inputs.
2. Confirm each timeframe has enough loaded history.
3. Confirm Telegram alerts show the correct `Signal Timeframe`.
4. Disable one timeframe and restart the EA.
5. Confirm disabled timeframe no longer produces alerts.

Pass/Fail criteria:

- Pass: each enabled timeframe scans independently and disabled timeframes do not alert.
- Fail: alerts show the wrong timeframe, disabled timeframes still alert, or one timeframe blocks another valid timeframe.

## Donchian Context Validation

Definition:

- DC20 Upper = highest high of previous 20 closed candles.
- DC20 Lower = lowest low of previous 20 closed candles.
- DC55 Upper = highest high of previous 55 closed candles.
- DC55 Lower = lowest low of previous 55 closed candles.
- Donchian Channel is context only, not a signal.

Context labels:

- Near DC20 Swing High
- Near DC20 Swing Low
- Near DC55 Major Swing High
- Near DC55 Major Swing Low

Validation steps:

1. Enable `EnableDCLevels=true`.
2. Confirm at least 55 closed candles exist on the tested timeframe.
3. Manually compare DC20/DC55 values against chart highs/lows.
4. Confirm Telegram message includes DC20/DC55 values.
5. Confirm DC context label appears only when close is within `DC_Near_Percent` of the relevant level.
6. Confirm Donchian proximity alone does not send an alert.

Pass/Fail criteria:

- Pass: DC values match closed-candle highs/lows and appear only as context.
- Fail: DC uses current forming candle, incorrect lookback, or generates alerts by itself.

## Final Validation Result

Record results:

```text
Startup Telegram Test: PASS / FAIL
Trend Alignment: PASS / FAIL
Weekly Filter: PASS / FAIL
KC21 Momentum: PASS / FAIL
EMA21 Pullback: PASS / FAIL
Multi-Timeframe Scan: PASS / FAIL
Donchian Context: PASS / FAIL
Alert-Only Safety: PASS / FAIL
Tester:
Date:
Notes:
```
