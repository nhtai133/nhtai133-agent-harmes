# TNPA Telegram Alert EA Manual MT5 Test Plan

## Goal

Validate `TNPA_Telegram_Alert_EA.ex5` in MetaTrader 5 before operational use.

Compiled EA:

- `src/TNPA_Telegram_Alert_EA.ex5`

Source EA:

- `src/TNPA_Telegram_Alert_EA.mq5`

This is a manual MT5 testing checklist. It does not modify code.

## 1. Installation Steps

- Open MetaTrader 5.
- Open `File > Open Data Folder`.
- Navigate to `MQL5/Experts`.
- Copy `TNPA_Telegram_Alert_EA.ex5` into the `Experts` folder or a suitable subfolder.
- Restart MT5 or right-click `Expert Advisors` in Navigator and select `Refresh`.
- Confirm `TNPA_Telegram_Alert_EA` appears in Navigator.
- Open a demo chart for one configured symbol, such as `XAUUSD`.
- Attach the EA to the chart.
- Enable algorithmic trading only if required for EA event execution, but confirm the EA does not place trades.

Pass/Fail:

- [ ] Pass
- [ ] Fail

Notes:

-

## 2. Telegram Setup

- Create or use an existing Telegram bot.
- Copy the bot token.
- Get the target Telegram chat ID.
- In EA inputs, set:
  - `TelegramBotToken`
  - `TelegramChatID`
  - `EnableTelegramAlert=true`
  - `EnablePopupAlert=true` or `false`, depending on test case.
  - `EnablePrintLog=true` for most tests.
- Do not share, commit, or store the bot token outside MT5 inputs.

Pass/Fail:

- [ ] Pass
- [ ] Fail

Notes:

-

## 3. WebRequest Setup

- In MT5, open `Tools > Options > Expert Advisors`.
- Enable WebRequest for listed URL.
- Add this URL:

```text
https://api.telegram.org
```

- Apply settings.
- Restart the EA after changing WebRequest settings if needed.

Pass/Fail:

- [ ] Pass
- [ ] Fail

Notes:

-

## 4. Symbol Setup

- Open Market Watch.
- Confirm configured symbols are visible and selectable:
  - `XAUUSD`
  - `EURUSD`
  - `BTCUSD`
- If the broker uses suffixes or prefixes, update the EA `Symbols` input with exact broker names.
- Confirm enough H1 history is loaded for each symbol.
- Open H1 charts or scroll history if needed to force data loading.

Pass/Fail:

- [ ] Pass
- [ ] Fail

Notes:

-

## 5. Test Cases

### Test Case 1: EA Startup

Objective:

Confirm the EA initializes safely and does not send historical alerts on startup.

Steps:

1. Attach the EA to a demo MT5 chart.
2. Use default symbols: `XAUUSD,EURUSD,BTCUSD`.
3. Set `SignalTimeframe=H1`.
4. Set valid Telegram inputs or disable Telegram for local-only testing.
5. Keep `EnablePrintLog=true`.
6. Observe Experts log immediately after startup.

Expected Result:

- EA initializes valid symbols.
- EA logs that historical alerts are suppressed through the latest closed candle.
- EA does not send Telegram or popup alerts immediately for historical candles.
- No order is placed, modified, or closed.

Pass/Fail:

- [ ] Pass
- [ ] Fail

Notes:

-

### Test Case 2: EMA BUY Crossover

Objective:

Confirm a BUY alert is sent only when EMA34 crosses above EMA89 on the most recently closed H1 candle.

Steps:

1. Use a demo environment or controlled chart data where an EMA34/EMA89 bullish crossover occurs.
2. Keep EA attached before the crossover candle closes.
3. Wait for the crossover candle to close.
4. Observe Telegram, popup, and Experts log according to enabled channels.

Expected Result:

- One BUY alert is generated after the candle closes.
- Alert basis states EMA 34/89 closed-candle crossover.
- Alert includes symbol, timeframe, signal direction, EMA values, closed candle time, and alert-only mode.
- No alert is sent before candle close.
- No trade action occurs.

Pass/Fail:

- [ ] Pass
- [ ] Fail

Notes:

-

### Test Case 3: EMA SELL Crossover

Objective:

Confirm a SELL alert is sent only when EMA34 crosses below EMA89 on the most recently closed H1 candle.

Steps:

1. Use a demo environment or controlled chart data where an EMA34/EMA89 bearish crossover occurs.
2. Keep EA attached before the crossover candle closes.
3. Wait for the crossover candle to close.
4. Observe Telegram, popup, and Experts log according to enabled channels.

Expected Result:

- One SELL alert is generated after the candle closes.
- Alert basis states EMA 34/89 closed-candle crossover.
- Alert includes symbol, timeframe, signal direction, EMA values, closed candle time, and alert-only mode.
- No alert is sent before candle close.
- No trade action occurs.

Pass/Fail:

- [ ] Pass
- [ ] Fail

Notes:

-

### Test Case 4: Duplicate Prevention

Objective:

Confirm the EA never sends more than one successful alert per closed candle per symbol and timeframe.

Steps:

1. Trigger or observe a valid EMA crossover alert.
2. Keep the EA running during repeated ticks on the same latest closed candle.
3. Observe Telegram, popup, and Experts log until the next candle closes.
4. Repeat for at least two symbols if possible.

Expected Result:

- Only one successful alert is delivered for the crossover candle per symbol and timeframe.
- No repeated alerts occur on additional ticks or timer cycles for the same closed candle.
- A later closed candle may alert only if a new crossover condition occurs.

Pass/Fail:

- [ ] Pass
- [ ] Fail

Notes:

-

### Test Case 5: Telegram Success

Objective:

Confirm Telegram delivery succeeds and marks the alert as successfully delivered.

Steps:

1. Configure valid `TelegramBotToken` and `TelegramChatID`.
2. Enable WebRequest for `https://api.telegram.org`.
3. Set `EnableTelegramAlert=true`.
4. Trigger or observe a valid crossover alert.
5. Check the Telegram chat and Experts log.

Expected Result:

- Telegram message arrives in the configured chat.
- Experts log records successful delivery.
- No duplicate successful alert is sent for the same closed candle.
- Popup and print outputs occur only if enabled.

Pass/Fail:

- [ ] Pass
- [ ] Fail

Notes:

-

### Test Case 6: Telegram Failure

Objective:

Confirm Telegram failure is logged, does not mark delivery as successful, and retries only once on the next timer cycle when valid.

Steps:

1. Set an invalid `TelegramChatID` or temporarily remove WebRequest permission.
2. Set `EnableTelegramAlert=true`.
3. Keep `EnablePrintLog=true`.
4. Trigger or observe a valid crossover alert.
5. Watch the Experts log for the initial failure.
6. Keep the same closed candle as the latest signal through the next timer cycle.
7. Observe the one retry.

Expected Result:

- Initial Telegram failure is logged.
- `lastSuccessfulAlertBarTime` is not updated by a failed send.
- One retry is attempted on the next timer cycle only if the same closed candle remains latest.
- Retry failure is logged.
- Retry does not repeat indefinitely.
- No trade action occurs.

Pass/Fail:

- [ ] Pass
- [ ] Fail

Notes:

-

### Test Case 7: Restart Behavior

Objective:

Confirm the EA does not send historical alerts after restart and starts monitoring from the next newly closed candle.

Steps:

1. Attach the EA and let it initialize.
2. Remove and reattach the EA or restart MT5.
3. Observe Experts log after restart.
4. Wait for the next H1 candle to close.

Expected Result:

- EA logs historical alert suppression through the latest closed candle at startup.
- EA does not backfill alerts from candles closed before restart.
- EA begins evaluating only after a new closed candle appears.
- No trade action occurs.

Pass/Fail:

- [ ] Pass
- [ ] Fail

Notes:

-

### Test Case 8: Missing Symbol

Objective:

Confirm the EA handles unavailable symbols safely.

Steps:

1. Add an invalid symbol to the `Symbols` input, such as `INVALID_SYMBOL`.
2. Keep at least one valid symbol in the list.
3. Start or reload the EA.
4. Observe Experts log.

Expected Result:

- EA logs that the invalid symbol is unavailable or could not be selected.
- EA skips the invalid symbol.
- EA continues monitoring valid symbols where practical.
- No trade action occurs.

Pass/Fail:

- [ ] Pass
- [ ] Fail

Notes:

-

### Test Case 9: Insufficient History

Objective:

Confirm the EA safely handles symbols without enough H1 history for EMA calculation.

Steps:

1. Use a symbol with limited loaded history, or clear/restrict history in a demo setup if possible.
2. Start or reload the EA.
3. Observe Experts log.
4. Load more history and reload the EA.

Expected Result:

- EA logs insufficient history for affected symbols.
- EA does not evaluate EMA signals until enough history is available.
- EA remains safe and idle for affected symbols.
- Reloading after history is available allows normal initialization.
- No trade action occurs.

Pass/Fail:

- [ ] Pass
- [ ] Fail

Notes:

-

### Test Case 10: Disabled Alert Channels

Objective:

Confirm the EA does not mark alerts as delivered when all output channels are disabled.

Steps:

1. Set:
   - `EnableTelegramAlert=false`
   - `EnablePopupAlert=false`
   - `EnablePrintLog=false`
2. Start or reload the EA.
3. Trigger or observe a valid crossover alert.
4. Check Experts log for forced warning output.

Expected Result:

- EA prints a forced warning that all alert channels are disabled.
- EA blocks delivery.
- EA does not update successful alert state.
- No silent successful delivery is recorded.
- No trade action occurs.

Pass/Fail:

- [ ] Pass
- [ ] Fail

Notes:

-

## Final Manual Test Summary

- [ ] All required tests passed.
- [ ] Any failed tests are documented.
- [ ] Telegram delivery was validated in a live MT5 terminal or demo terminal.
- [ ] No order placement occurred.
- [ ] No position modification occurred.
- [ ] WebRequest setup was confirmed.
- [ ] Broker-specific symbol names were confirmed.

Tester:

Date:

Overall Result:

- [ ] Approved for demo monitoring
- [ ] Needs fixes
