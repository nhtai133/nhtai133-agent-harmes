# Build MT5 EA Simulation

## Goal

Validate how Agent Harmes routes a user request to build an MT5 Expert Advisor for TNPA Trading OS through Project Memory, the EA workflow, agent specs, review, delivery, and memory update.

The simulation tests orchestration behavior only. It does not define EA implementation code.

## Commander Actions

- Receive the user goal: build an MT5 EA for TNPA trading.
- Load TNPA Project Memory:
  - `projects/tnpa-trading-os/project_context.md`
  - `projects/tnpa-trading-os/project_rules.md`
  - `projects/tnpa-trading-os/project_memory.md`
- Identify known constraints: TNPA rules are not fully formalized, risk limits are not fully defined, and live-trading boundaries require approval.
- Select `workflows/build_ea.md` as the active workflow.
- Frame the objective as a specification and validation workflow unless the human operator explicitly approves implementation.
- Define required decision gates for strategy rules, risk limits, and live-trading behavior.
- Assign scoped work to Planner, Researcher, Coder, Tester, and Reviewer according to workflow stage.
- Escalate unresolved trading rules, risk limits, or broker-connected automation decisions to the human operator.
- Synthesize the final deliverable and record lessons, known issues, and future improvements in project memory.

## Planner Actions

- Convert the EA goal into workstreams:
  - Strategy rule clarification.
  - Risk model definition.
  - MT5 platform constraint review.
  - Technical specification preparation.
  - Test and review planning.
- Identify dependencies:
  - Approved symbols, timeframes, sessions, and setup rules.
  - Position sizing, drawdown, stop-loss, and trade frequency limits.
  - Data quality and backtest requirements.
- Define milestones:
  - Complete EA objective brief.
  - Complete strategy and risk rule brief.
  - Complete implementation-readiness brief.
  - Complete validation and review package.
- Define acceptance criteria for each stage.
- Mark implementation as blocked until Commander and human approval are obtained.

## Researcher Actions

- Review TNPA memory for known assumptions, issues, and future improvements.
- Gather or request evidence for:
  - Market behavior relevant to the target symbol and timeframe.
  - MT5 execution constraints and common EA failure modes.
  - Backtest data quality expectations.
  - Strategy risks, overfitting risks, and market-condition limitations.
- Label findings as verified facts, working assumptions, unresolved questions, or rejected ideas.
- Identify evidence gaps that block implementation readiness.
- Produce a decision-ready research brief for Commander synthesis.

## Coder Actions

- Do not write implementation code during the simulation.
- Confirm what implementation artifacts would be required only after approval:
  - EA technical specification.
  - Input parameter map.
  - Risk-control behavior specification.
  - Handoff notes for future implementation.
- Identify implementation blockers:
  - Missing finalized TNPA trading rules.
  - Missing default risk limits.
  - Missing live-trading approval boundary.
- Return a readiness assessment to the Commander instead of producing code.

## Tester Actions

- Define validation checks for a future EA workflow:
  - Entry and exit rule conformance.
  - Stop-loss, take-profit, and invalidation behavior.
  - Position sizing and exposure limits.
  - Spread, slippage, missing data, market closure, and rapid-movement cases.
  - Backtest, forward-test, and regression expectations.
- Identify which tests cannot run until strategy rules and implementation artifacts exist.
- Produce a test-readiness report with blocked items and residual risk.

## Reviewer Actions

- Audit whether the Commander used Project Memory before selecting the workflow.
- Confirm `workflows/build_ea.md` was the correct workflow.
- Check that Coder was not asked to implement before strategy and risk approval.
- Review Planner and Researcher outputs for completeness, consistency, and decision readiness.
- Confirm human escalation is required for unresolved risk limits and live-trading behavior.
- Recommend accept, revise, or escalate.

## Final Deliverable

- EA orchestration validation report.
- Confirmed routing path:
  - Project Memory to `workflows/build_ea.md`.
  - Planner for scope and dependencies.
  - Researcher for strategy and market assumptions.
  - Coder for implementation-readiness assessment only.
  - Tester for validation planning.
  - Reviewer for readiness and risk audit.
- Open decisions:
  - Formal TNPA rulebook.
  - Approved symbols, timeframes, and sessions.
  - Default risk limits.
  - Live-trading approval boundary.
- Recommended next action: formalize TNPA strategy and risk rules before EA implementation.

## Lessons Learned

- EA work must begin with Project Memory because unresolved TNPA rules and risk limits directly affect implementation readiness.
- The Commander should route MT5 EA requests through specification, research, and risk gates before implementation.
- Coder participation is valid before implementation only as a readiness assessment, not as code production.
- Tester and Reviewer should surface blocked validation early to prevent false readiness.
- Project Memory should be updated whenever strategy rules, risk limits, or rejected EA assumptions become clearer.
