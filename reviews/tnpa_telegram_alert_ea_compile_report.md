# TNPA Telegram Alert EA Compile Report

## Compiler Path Used

`C:\Program Files\MetaTrader 5 EXNESS 20.3\MetaEditor64.exe`

## Compile Command Used

```text
C:\Program Files\MetaTrader 5 EXNESS 20.3\MetaEditor64.exe /compile:"C:\Users\ADMIN\nhtai133-agent-harmes\src\TNPA_Telegram_Alert_EA.mq5" /log:"C:\Users\ADMIN\nhtai133-agent-harmes\reviews\tnpa_telegram_alert_ea_metaeditor.log"
```

## Errors Count

`0`

## Warnings Count

`0`

## Compiler Messages

Compiler log file:

- `C:\Users\ADMIN\AppData\Roaming\MetaQuotes\Terminal\C6DD07FBE3E7CA400B4ED0590FF84E1A\logs\metaeditor.log`

Captured compiler output:

```text
0 2026.06.03 23:01:16.368 Compile C:\Users\ADMIN\nhtai133-agent-harmes\src\TNPA_Telegram_Alert_EA.mq5 - 0 errors, 0 warnings, 691 ms elapsed, cpu='X64 Regular'
```

## EX5 Generation

Confirmed generated file:

- `C:\Users\ADMIN\nhtai133-agent-harmes\src\TNPA_Telegram_Alert_EA.ex5`

Generated file size:

- `47964` bytes

## Static Safety Scan

No references found for:

- `CTrade`
- `OrderSend`
- `OrderModify`
- `OrderClose`
- `PositionOpen`
- `PositionModify`
- `PositionSelect`
- `PositionGet`
- `MqlTradeRequest`
- `TradeRequest`
- `Buy(`
- `Sell(`
- `HistoryDeal`

## Approval Decision

Decision: **Approved For MT5 Testing**

The v0.4 TNPA Radar Scanner compiled successfully with Exness MT5 20.3 MetaEditor with `0 errors` and `0 warnings`. The `.ex5` file was generated successfully and remains alert-only by static scan.
