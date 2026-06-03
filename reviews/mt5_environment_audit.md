# MT5 Environment Audit

## MetaEditor Path

MetaEditor used for compilation:

```text
C:\Program Files\MetaTrader 5\MetaEditor64.exe
```

Detection basis:

- This path was used in the successful compile command.
- The directory contains `MetaEditor64.exe`, `terminal64.exe`, and `metatester64.exe`.

## Terminal Path

Associated MT5 terminal executable:

```text
C:\Program Files\MetaTrader 5\terminal64.exe
```

Detection basis:

- `terminal64.exe` is located in the same installation directory as the MetaEditor used for compilation.

## Data Folder Path

Associated MT5 data folder:

```text
C:\Users\ADMIN\AppData\Roaming\MetaQuotes\Terminal\D0E8209F77C8CF37AD8BF550E51FF075
```

Detection basis:

- The folder contains `origin.txt`.
- `origin.txt` content:

```text
C:\Program Files\MetaTrader 5
```

This matches the installation directory used for compilation.

## Experts Folder Path

Experts folder for the detected MT5 data folder:

```text
C:\Users\ADMIN\AppData\Roaming\MetaQuotes\Terminal\D0E8209F77C8CF37AD8BF550E51FF075\MQL5\Experts
```

## Source MQ5 Path

Source file compiled:

```text
C:\Users\ADMIN\nhtai133-agent-harmes\src\TNPA_Telegram_Alert_EA.mq5
```

## Generated EX5 Path

Generated compiled file:

```text
C:\Users\ADMIN\nhtai133-agent-harmes\src\TNPA_Telegram_Alert_EA.ex5
```

Generated file size:

```text
27842 bytes
```

## Generated File Location Classification

The compiled EX5 was generated in:

```text
C:\Users\ADMIN\nhtai133-agent-harmes\src
```

Classification:

- `MQL5/Experts`: **No**
- `MQL5/Projects`: **No**
- Another folder: **Yes, repository source folder**

The matched MT5 data folder was checked for:

```text
TNPA_Telegram_Alert_EA.*
```

No matching file was found under:

```text
C:\Users\ADMIN\AppData\Roaming\MetaQuotes\Terminal\D0E8209F77C8CF37AD8BF550E51FF075\MQL5
```

## Active MT5 Installation Detected

Detected active installation associated with the MetaEditor compile:

```text
C:\Program Files\MetaTrader 5
```

Associated files:

```text
C:\Program Files\MetaTrader 5\MetaEditor64.exe
C:\Program Files\MetaTrader 5\terminal64.exe
```

Associated data folder:

```text
C:\Users\ADMIN\AppData\Roaming\MetaQuotes\Terminal\D0E8209F77C8CF37AD8BF550E51FF075
```

## Recommendations For Deployment

1. Copy the compiled EX5 from:

```text
C:\Users\ADMIN\nhtai133-agent-harmes\src\TNPA_Telegram_Alert_EA.ex5
```

to:

```text
C:\Users\ADMIN\AppData\Roaming\MetaQuotes\Terminal\D0E8209F77C8CF37AD8BF550E51FF075\MQL5\Experts\TNPA_Telegram_Alert_EA.ex5
```

2. Restart MT5 or refresh Expert Advisors in Navigator.

3. Confirm the EA appears under Expert Advisors.

4. Before Telegram testing, configure MT5 WebRequest:

```text
Tools > Options > Expert Advisors > Allow WebRequest for listed URL
https://api.telegram.org
```

5. Attach the EA to a demo chart first.

6. Use exact broker symbol names in the `Symbols` input. If the broker uses suffixes or prefixes, update the input accordingly.

7. Follow the manual test plan:

```text
tests/tnpa_telegram_alert_ea_manual_test_plan.md
```

8. Keep the repository copy as the source of record. Treat the MT5 `MQL5/Experts` copy as a deployment artifact.
