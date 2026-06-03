# Analyze Market Playbook

## Purpose

Provide an executable orchestration path for routing market analysis goals through Agent Harmes from question framing to reviewed decision-support output and memory update.

This playbook operationalizes:

- `docs/orchestration_map.md`
- `workflows/analyze_market.md`
- `agents/commander.md`
- `agents/planner.md`
- `agents/researcher.md`
- `agents/coder.md`
- `agents/tester.md`
- `agents/reviewer.md`
- `projects/tnpa-trading-os/project_context.md`
- `projects/tnpa-trading-os/project_rules.md`
- `projects/tnpa-trading-os/project_memory.md`

It defines orchestration only. It does not include data collection scripts, indicators, trading algorithms, or implementation code.

## Entry Conditions

Use this playbook when the user goal involves:

- Market research.
- XAUUSD or other trading-market analysis.
- Competitor, trend, audience, demand, risk, or opportunity analysis.
- Decision support for EA design, dashboard planning, content, or strategy work.
- Revalidation of outdated, contradictory, or unsupported market assumptions.

Do not deliver decision-ready analysis when:

- Time horizon is unclear.
- Data freshness matters and cannot be verified.
- Evidence is weak or contradictory.
- The user expects live-trading instructions without review and approval.
- The analysis depends on proprietary or inaccessible data that cannot be validated.

## Context Loading Sequence

1. Load `docs/orchestration_map.md`.
2. Load `workflows/analyze_market.md`.
3. Load agent specs:
   - `agents/commander.md`
   - `agents/planner.md`
   - `agents/researcher.md`
   - `agents/coder.md`
   - `agents/tester.md`
   - `agents/reviewer.md`
4. Identify the market question, decision context, target market, geography, audience, asset class, competitors, and time horizon.
5. Identify whether the request is exploratory research, decision memo, trading context, content support, EA input, dashboard input, or recovery.

## Project Memory Loading Sequence

1. Load relevant project memory for the market domain.
2. For TNPA trading analysis, load:
   - `projects/tnpa-trading-os/project_context.md`
   - `projects/tnpa-trading-os/project_rules.md`
   - `projects/tnpa-trading-os/project_memory.md`
3. Extract prior assumptions, source standards, known issues, unresolved market questions, and relevant risk rules.
4. Identify existing conclusions that need confirmation, revision, or rejection.
5. Identify memory updates that may be needed after review.

## Workflow Selection Logic

Select `workflows/analyze_market.md` when the primary deliverable is market evidence, analysis, decision support, or validated market assumptions.

Use supporting workflows when needed:

- Use `workflows/build_ea.md` when the analysis directly changes EA rules or trading-system requirements.
- Use `workflows/create_content.md` when the analysis will become public or internal content.
- Use `workflows/build_dashboard.md` when the analysis defines monitoring metrics or dashboard requirements.

If the analysis is time-sensitive, Commander should require fresh source checks and explicit uncertainty labels before delivery.

## Agent Invocation Order

1. **Commander:** Clarify question, decision context, time horizon, required output, and escalation conditions.
2. **Planner:** Define research scope, source criteria, comparison dimensions, milestones, and acceptance criteria.
3. **Researcher:** Gather evidence, validate source quality, identify conflicts, label uncertainty, and summarize findings.
4. **Coder:** Participate only if approved technical integration, dashboard update, or structured artifact work is required.
5. **Tester:** Validate calculations, tables, citations, timestamps, source consistency, and reproducibility when applicable.
6. **Reviewer:** Audit evidence quality, reasoning, assumptions, gaps, risk, and decision readiness.
7. **Commander:** Synthesize implications, recommendations, residual risks, delivery output, and memory updates.

## Review Gates

- **Gate 1: Question readiness.** Commander confirms the decision context, market scope, and time horizon.
- **Gate 2: Source readiness.** Planner and Researcher confirm source criteria, freshness requirements, and evidence limits.
- **Gate 3: Evidence readiness.** Researcher separates facts, estimates, assumptions, interpretations, and open questions.
- **Gate 4: Validation readiness.** Tester confirms citations, timestamps, calculations, and tables where applicable.
- **Gate 5: Acceptance review.** Reviewer gives accept, revise, or escalate recommendation.

## Delivery Criteria

Deliver only when:

- The market question and decision context are explicit.
- Time horizon and source freshness are documented.
- Findings distinguish facts, assumptions, interpretations, and uncertainty.
- Important claims are supported or marked as unresolved.
- Contradictory evidence and limitations are visible.
- Tester has validated applicable mechanics.
- Reviewer has accepted the analysis or documented residual risk.
- Commander has synthesized implications and next actions.

Do not deliver as trading-ready advice or guaranteed market direction.

## Memory Update Procedure

After delivery, Commander updates project memory when the workflow produces:

- Validated market assumptions.
- Rejected market assumptions.
- Source standards or freshness rules.
- Recurring market drivers.
- Known analytical gaps.
- Review lessons.
- Future research needs.

Memory updates should preserve decision value over time while labeling time-sensitive information clearly. Do not store unsupported claims, private market data exports, account information, or paid-source material without approval.

## Escalation Rules

Escalate to the human operator when:

- The analysis could influence live trading, capital allocation, or high-impact strategy decisions.
- Evidence is stale, weak, contradictory, or unavailable.
- The user asks for a direct trading signal or guaranteed outcome.
- The analysis depends on private, paid, proprietary, or inaccessible data.
- Researcher, Tester, or Reviewer identifies unresolved material uncertainty.
- The requested output would be externally published with market or performance claims.
