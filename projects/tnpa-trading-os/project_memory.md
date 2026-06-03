# TNPA Trading OS Project Memory

## Lessons Learned

- Project memory should be checked before starting TNPA trading work so agents do not repeat old assumptions or ignore prior decisions.
- Trading work requires clear separation between confirmed rules, working assumptions, experimental ideas, rejected ideas, and open questions.
- Risk rules must be defined early because they shape strategy design, EA requirements, testing, and review.
- Market analysis must preserve uncertainty and source quality instead of compressing all findings into a single confident recommendation.
- Backtest results are not sufficient by themselves; future workflows should retain context about market conditions, data quality, and failure modes.
- Commander approval is required before moving from research or specification into implementation.
- Tester and Reviewer outputs should be converted into durable memory when they reveal recurring defects, weak assumptions, or useful constraints.

## Known Issues

- The TNPA rule set is not yet fully formalized in this repository.
- Approved symbols, timeframes, trading sessions, and market conditions have not yet been recorded.
- Default risk limits, maximum drawdown thresholds, and position sizing rules are not yet defined.
- No canonical EA acceptance checklist exists yet for TNPA trading work.
- No source-of-truth format exists yet for recording strategy experiments and rejected ideas.
- Dashboard requirements for monitoring TNPA trading operations are not yet specified.
- Market data source standards and freshness requirements are not yet fully defined.
- Live-trading approval boundaries need to be made explicit before any broker-connected automation work.

## Future Improvements

- Create a canonical TNPA strategy rulebook with approved setups, invalidation rules, and examples.
- Define a standard risk profile template for each strategy or EA.
- Add a reusable EA acceptance checklist covering requirements, risk, testing, review, and release readiness.
- Create a structured experiment log for hypotheses, test conditions, outcomes, rejected ideas, and lessons.
- Define market data standards, source hierarchy, and freshness requirements for analysis workflows.
- Establish dashboard memory for key trading metrics, operational alerts, agent activity, and review status.
- Add a decision register for major Commander approvals, human approvals, rejected changes, and risk exceptions.
- Create a recovery log for failed tests, review rejections, market-analysis corrections, and production incidents.
- Formalize handoff templates between Planner, Researcher, Coder, Tester, Reviewer, and Commander for TNPA work.
- Review this memory after each completed TNPA workflow and update lessons, issues, and future improvements.
