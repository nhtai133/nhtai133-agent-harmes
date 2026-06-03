# Analyze XAUUSD Simulation

## Goal

Validate how Agent Harmes routes a user request to analyze XAUUSD through TNPA Project Memory, the market analysis workflow, agent specs, review, delivery, and memory update.

The simulation tests orchestration behavior only. It does not provide live market advice, trading signals, or implementation code.

## Commander Actions

- Receive the user goal: analyze XAUUSD.
- Load TNPA Project Memory for trading mission, risk rules, known issues, market-analysis needs, and unresolved assumptions.
- Identify that XAUUSD analysis may be time-sensitive and decision-sensitive.
- Select `workflows/analyze_market.md` as the active workflow.
- Clarify the analysis purpose:
  - Strategy context.
  - EA design input.
  - Content support.
  - Trading decision support.
  - General market memo.
- Define escalation conditions for stale data, weak sources, live-trading decisions, or high-risk conclusions.
- Assign Planner to define scope, source criteria, comparison dimensions, and acceptance criteria.
- Assign Researcher to gather and label evidence.
- Assign Tester to validate calculations, tables, citations, and reproducibility when applicable.
- Assign Reviewer to audit evidence quality, reasoning, assumptions, gaps, and readiness.
- Synthesize final analysis only after review and record validated conclusions or open questions in Project Memory.

## Planner Actions

- Define the XAUUSD analysis scope:
  - Time horizon.
  - Market session context.
  - Technical, fundamental, sentiment, or risk focus.
  - Required source freshness.
  - Decision the analysis should support.
- Define research workstreams:
  - Price-action context.
  - Macro and rates context.
  - USD and gold drivers.
  - Volatility and liquidity conditions.
  - TNPA strategy relevance.
- Define milestones:
  - Research plan.
  - Evidence brief.
  - Validation check.
  - Review-ready analysis memo.
- Define acceptance criteria:
  - Source quality is labeled.
  - Facts are separated from assumptions.
  - No unsupported trading recommendation is delivered.
  - Residual uncertainty is visible.

## Researcher Actions

- Check Project Memory for prior XAUUSD assumptions, source standards, known gaps, and relevant TNPA rules.
- Gather evidence appropriate to the requested time horizon.
- Label all findings by freshness and evidence quality.
- Identify conflicting evidence and market uncertainty.
- Separate:
  - Confirmed market facts.
  - Current observations.
  - Interpretations.
  - Trading assumptions.
  - Open questions.
- Produce a market research brief for Commander synthesis.

## Coder Actions

- Do not write implementation code during the simulation.
- Do not build data collection scripts, indicators, dashboards, or EA changes unless separately approved.
- Identify possible technical follow-up only if the analysis later requires:
  - Dashboard integration.
  - EA rule adjustment.
  - Structured data tracking.
  - Calculation automation.
- Return no-code readiness notes to the Commander.

## Tester Actions

- Validate analysis mechanics when applicable:
  - Source links are accessible.
  - Data timestamps match the claimed time horizon.
  - Tables and calculations are internally consistent.
  - Claims match cited evidence.
  - Unsupported conclusions are flagged.
- Mark unavailable live data or unverifiable claims as residual risk.
- Produce a validation note for Reviewer and Commander.

## Reviewer Actions

- Audit whether Project Memory and `workflows/analyze_market.md` were used.
- Check that the analysis purpose and time horizon are explicit.
- Confirm Researcher separated facts, assumptions, uncertainty, and interpretations.
- Confirm Tester validated citations, timestamps, and calculations when applicable.
- Reject or escalate any output that presents XAUUSD conclusions as guaranteed trading signals.
- Recommend accept, revise, or escalate based on evidence quality and decision readiness.

## Final Deliverable

- XAUUSD analysis orchestration validation report.
- Confirmed routing path:
  - Project Memory to `workflows/analyze_market.md`.
  - Planner for scope, source criteria, and acceptance criteria.
  - Researcher for evidence gathering and uncertainty labeling.
  - Coder bypassed unless technical integration is approved.
  - Tester for citation, timestamp, calculation, and consistency checks.
  - Reviewer for evidence quality, reasoning, and decision-readiness audit.
- Open decisions:
  - Required time horizon for XAUUSD analysis.
  - Approved source hierarchy and freshness rules.
  - Whether analysis supports EA design, content, or trading decision support.
  - Human approval requirement for any live-trading implication.
- Recommended next action: define XAUUSD source standards and a reusable market-analysis memo format.

## Lessons Learned

- XAUUSD analysis must be treated as time-sensitive and should not rely on stale assumptions.
- The Commander must clarify whether analysis is for strategy design, content, or trading decision support.
- Researcher findings need explicit freshness and evidence-quality labels.
- Tester validation is useful even without code because timestamps, citations, and calculations affect decision quality.
- Reviewer should block delivery when uncertainty is hidden or market analysis is framed as a guaranteed signal.
- Project Memory should retain validated recurring drivers, source standards, rejected assumptions, and unresolved market questions.
