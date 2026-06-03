# Exness MT5 20.3 Deployment Report

## Source Path

```text
C:\Users\ADMIN\nhtai133-agent-harmes\src\TNPA_Telegram_Alert_EA.ex5
```

## Destination Path

```text
C:\Users\ADMIN\AppData\Roaming\MetaQuotes\Terminal\C6DD07FBE3E7CA400B4ED0590FF84E1A\MQL5\Experts\TNPA_Telegram_Alert_EA.ex5
```

## Copy Result

Status: **Success**

The compiled EX5 file was copied to the confirmed Exness MT5 20.3 `MQL5\Experts` folder.

## Destination File Existence

Status: **Exists**

Verification result:

```text
Exists=True
```

## Destination File Size

```text
27842 bytes
```

Verification result:

```text
GreaterThanZero=True
```

## Deployment Target Confirmation

Deployment target is confirmed as Exness MT5 20.3.

Data folder:

```text
C:\Users\ADMIN\AppData\Roaming\MetaQuotes\Terminal\C6DD07FBE3E7CA400B4ED0590FF84E1A
```

`origin.txt` content:

```text
C:\Program Files\MetaTrader 5 EXNESS 20.3
```

Associated terminal:

```text
C:\Program Files\MetaTrader 5 EXNESS 20.3\terminal64.exe
```

Associated MetaEditor:

```text
C:\Program Files\MetaTrader 5 EXNESS 20.3\MetaEditor64.exe
```

## Next Manual MT5 Steps

1. Open or restart Exness MT5 20.3.
2. In Navigator, right-click `Expert Advisors` and select `Refresh`, or restart the terminal.
3. Confirm `TNPA_Telegram_Alert_EA` appears under Expert Advisors.
4. Open `Tools > Options > Expert Advisors`.
5. Enable WebRequest for listed URL.
6. Add:

```text
https://api.telegram.org
```

7. Attach the EA to a demo chart first.
8. Configure inputs:
   - `Symbols`
   - `SignalTimeframe`
   - `TelegramBotToken`
   - `TelegramChatID`
   - `EnableTelegramAlert`
   - `EnablePopupAlert`
   - `EnablePrintLog`
9. Run the manual test plan:

```text
tests\tnpa_telegram_alert_ea_manual_test_plan.md
```

10. Confirm no orders are placed and no positions are modified during testing.
