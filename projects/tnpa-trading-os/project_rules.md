# TNPA Trading OS Project Rules

## TNPA Trading Rules

- Treat the trading model as rule-based until the Commander approves a change to strategy logic.
- Define market, symbol, timeframe, session, and setup conditions before any EA or analysis task begins.
- Separate entry rules, exit rules, stop rules, take-profit rules, trade filters, and invalidation rules.
- Do not treat a pattern, signal, or indicator as valid unless its assumptions and failure conditions are documented.
- Label every strategy concept as one of: approved rule, working assumption, experimental idea, rejected idea, or unresolved question.
- Preserve the reasoning behind accepted and rejected trading rules so future agents can understand the decision.
- Do not optimize a strategy for a single backtest result without documenting overfitting risk.
- Any rule change that affects entries, exits, position sizing, stop behavior, or drawdown exposure requires Commander review.
- Market analysis used for trading decisions must identify data freshness, source quality, and uncertainty.
- Trading outputs must distinguish analysis, simulation, operational rule, and live-trading decision.

## Risk Management Rules

- Risk limits must be defined before implementation, backtesting, or release preparation.
- Position sizing, maximum exposure, maximum drawdown, stop-loss behavior, and trade frequency limits must be explicit.
- No workflow may silently increase risk to improve performance metrics.
- Backtest and forward-test findings must include residual risk, known weaknesses, and market conditions tested.
- Tester and Reviewer agents must check edge cases involving spread, slippage, missing data, market closure, rapid movement, and execution failure when applicable.
- Strategy changes must be reviewed for downside risk, not only expected return.
- High-impact or irreversible trading decisions require human approval.
- Any use of live capital, broker integration, account-specific data, or automation that can place orders must be escalated to the human operator.
- Do not commit credentials, account identifiers, broker exports, private trade logs, or unsanitized financial records.
- If risk assumptions are unknown, the workflow must pause or mark the output as incomplete rather than invent limits.

## Coding Standards

- No implementation code belongs in project memory files.
- Coder may implement only after receiving an approved, scoped task from the Commander.
- Code changes must follow existing repository conventions and remain narrowly scoped to the approved task.
- Trading logic must be traceable to approved strategy rules and documented assumptions.
- Risk controls must be explicit, testable, and reviewed before acceptance.
- Avoid hidden behavior, magic constants, and undocumented defaults in trading-related work.
- Implementation handoffs must include assumptions, changed behavior, test expectations, and known limitations.
- Tester must validate normal behavior, edge cases, failure paths, and affected regressions before Reviewer acceptance.
- Reviewer must confirm implementation aligns with the approved trading rules and does not introduce unapproved risk.
- Git commits must keep project memory, strategy specs, implementation work, tests, and recovery fixes coherent and reviewable.
