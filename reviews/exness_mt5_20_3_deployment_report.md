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

The v0.4 compiled EX5 replaced the existing file in the confirmed Exness MT5 20.3 `MQL5\Experts` folder.

## Destination File Existence

Status: **Exists**

Verification result:

```text
Exists=True
```

## Destination File Size

```text
47964 bytes
```

Verification result:

```text
SourceSize=47964
DestinationSize=47964
SizeMatches=True
GreaterThanZero=True
```

## Deployment Target Confirmation

Deployment target is confirmed as Exness MT5 20.3.

Data folder:

```text
C:\Users\ADMIN\AppData\Roaming\MetaQuotes\Terminal\C6DD07FBE3E7CA400B4ED0590FF84E1A
```

Associated terminal:

```text
C:\Program Files\MetaTrader 5 EXNESS 20.3\terminal64.exe
```

Associated MetaEditor:

```text
C:\Program Files\MetaTrader 5 EXNESS 20.3\MetaEditor64.exe
```

## Startup Telegram Test Readiness

Status: **Ready**

The deployed Exness MT5 20.3 EX5 matches the newly compiled v0.4 source EX5 by file size. It is ready for the startup Telegram connection test after MT5 WebRequest is configured and valid Telegram inputs are set.

Expected startup message:

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

## Next Manual MT5 Steps

1. Open or restart Exness MT5 20.3.
2. In Navigator, refresh `Expert Advisors`, or restart the terminal.
3. Confirm `TNPA_Telegram_Alert_EA` appears under Expert Advisors.
4. Open `Tools > Options > Expert Advisors`.
5. Enable WebRequest for listed URL.
6. Add:

```text
https://api.telegram.org
```

7. Attach the EA to a demo chart first.
8. Configure:
   - `Symbols`
   - Enabled timeframe inputs.
   - Telegram inputs.
   - `SendStartupTestMessage=true`
9. Confirm the startup Telegram connection test is received.
10. Confirm no orders are placed and no positions are modified during testing.
