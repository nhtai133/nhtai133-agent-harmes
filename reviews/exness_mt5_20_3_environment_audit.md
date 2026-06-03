# Exness MT5 20.3 Environment Audit

## Exness Terminal Path

```text
C:\Program Files\MetaTrader 5 EXNESS 20.3\terminal64.exe
```

## Exness MetaEditor Path

```text
C:\Program Files\MetaTrader 5 EXNESS 20.3\MetaEditor64.exe
```

## Exness Data Folder Path

```text
C:\Users\ADMIN\AppData\Roaming\MetaQuotes\Terminal\C6DD07FBE3E7CA400B4ED0590FF84E1A
```

## Exness MQL5 Experts Folder

```text
C:\Users\ADMIN\AppData\Roaming\MetaQuotes\Terminal\C6DD07FBE3E7CA400B4ED0590FF84E1A\MQL5\Experts
```

## How It Was Identified As Exness MT5 20.3

Installation directory found:

```text
C:\Program Files\MetaTrader 5 EXNESS 20.3
```

Executables found inside that installation:

```text
C:\Program Files\MetaTrader 5 EXNESS 20.3\terminal64.exe
C:\Program Files\MetaTrader 5 EXNESS 20.3\MetaEditor64.exe
```

Associated MetaQuotes data folder was identified by matching `origin.txt`.

Data folder:

```text
C:\Users\ADMIN\AppData\Roaming\MetaQuotes\Terminal\C6DD07FBE3E7CA400B4ED0590FF84E1A
```

`origin.txt` content:

```text
C:\Program Files\MetaTrader 5 EXNESS 20.3
```

This confirms the data folder belongs to the regular Exness MT5 20.3 installation.

Important distinction:

- `C:\Program Files\MetaTrader 5 EXNESS 20.3` is the selected target.
- `C:\Program Files\MetaTrader 5 EXNESS Gold 20.3` was also found, but is a separate installation and is not the selected deployment target.
- `C:\Program Files\MetaTrader 5` is not the selected deployment target.

## Should `src/TNPA_Telegram_Alert_EA.ex5` Be Copied There?

Recommendation: **Yes, but not yet copied.**

Compiled source artifact:

```text
C:\Users\ADMIN\nhtai133-agent-harmes\src\TNPA_Telegram_Alert_EA.ex5
```

Recommended deployment destination:

```text
C:\Users\ADMIN\AppData\Roaming\MetaQuotes\Terminal\C6DD07FBE3E7CA400B4ED0590FF84E1A\MQL5\Experts\TNPA_Telegram_Alert_EA.ex5
```

Current check:

- No existing `TNPA_Telegram_Alert_EA.*` file was found under the Exness MT5 20.3 `MQL5` folder.
- No files were copied during this audit.

## Deployment Recommendation

Deploy only to the Exness MT5 20.3 data folder:

```text
C:\Users\ADMIN\AppData\Roaming\MetaQuotes\Terminal\C6DD07FBE3E7CA400B4ED0590FF84E1A\MQL5\Experts
```

Do not deploy to:

```text
C:\Program Files\MetaTrader 5
```

That default MetaTrader 5 installation is separate and should not be used for Exness MT5 20.3 deployment.

Recommended next deployment step, when approved:

```text
Copy src\TNPA_Telegram_Alert_EA.ex5 to C:\Users\ADMIN\AppData\Roaming\MetaQuotes\Terminal\C6DD07FBE3E7CA400B4ED0590FF84E1A\MQL5\Experts\TNPA_Telegram_Alert_EA.ex5
```

After copying:

- Open or restart Exness MT5 20.3.
- Refresh Expert Advisors in Navigator.
- Confirm `TNPA_Telegram_Alert_EA` appears.
- Configure WebRequest for:

```text
https://api.telegram.org
```

- Run the manual test plan before operational use.
