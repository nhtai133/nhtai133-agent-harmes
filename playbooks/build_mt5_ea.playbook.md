# Build MT5 EA Playbook

## Purpose

Provide an executable orchestration path for routing a user goal to build, improve, specify, test, or review an MT5 Expert Advisor through Agent Harmes.

This playbook operationalizes:

- `docs/orchestration_map.md`
- `workflows/build_ea.md`
- `agents/commander.md`
- `agents/planner.md`
- `agents/researcher.md`
- `agents/coder.md`
- `agents/tester.md`
- `agents/reviewer.md`
- `projects/tnpa-trading-os/project_context.md`
- `projects/tnpa-trading-os/project_rules.md`
- `projects/tnpa-trading-os/project_memory.md`

It defines orchestration only. It does not include EA implementation code.

## Entry Conditions

Use this playbook when the user goal involves:

- Building an MT5 EA.
- Improving an existing EA.
- Creating an EA specification.
- Translating TNPA trading rules into EA-ready requirements.
- Reviewing EA risk, validation, or release readiness.
- Recovering from failed EA planning, testing, or review.

Do not proceed directly to implementation when:

- TNPA trading rules are unresolved.
- Risk limits are missing.
- Live-trading behavior is requested without human approval.
- Broker credentials, account data, or order execution access are involved.

## Context Loading Sequence

1. Load `docs/orchestration_map.md`.
2. Load `workflows/build_ea.md`.
3. Load agent specs:
   - `agents/commander.md`
   - `agents/planner.md`
   - `agents/researcher.md`
   - `agents/coder.md`
   - `agents/tester.md`
   - `agents/reviewer.md`
4. Identify whether the request is for research, specification, implementation, testing, review, recovery, or delivery.
5. Extract user-stated constraints, desired output, non-goals, and approval requirements.

## Project Memory Loading Sequence

1. Load `projects/tnpa-trading-os/project_context.md` for mission, scope, and goals.
2. Load `projects/tnpa-trading-os/project_rules.md` for TNPA trading rules, risk management rules, and coding standards.
3. Load `projects/tnpa-trading-os/project_memory.md` for lessons learned, known issues, and future improvements.
4. Identify memory conflicts with the user request.
5. Identify missing project facts that block EA readiness.
6. Record assumptions that must be carried into Planner and Researcher assignments.

## Workflow Selection Logic

Select `workflows/build_ea.md` when the request is primarily about MT5 EA creation, strategy-to-EA translation, EA validation, or EA release readiness.

Use supporting workflows only when the EA goal includes a secondary deliverable:

- Use `workflows/analyze_market.md` when market evidence is required before EA rule definition.
- Use `workflows/build_dashboard.md` when the EA requires monitoring or reporting surfaces.
- Use `workflows/create_content.md` when the EA work requires public documentation, internal notes, or release communication.

If the user request mixes multiple deliverables, Commander should choose the EA workflow as the primary route and create dependent sub-workflows.

## Agent Invocation Order

1. **Commander:** Clarify objective, load context, select workflow, define decision gates, and assign agents.
2. **Planner:** Decompose the EA goal into workstreams, dependencies, milestones, acceptance criteria, and blockers.
3. **Researcher:** Validate strategy assumptions, market context, MT5 constraints, data needs, and uncertainty.
4. **Commander:** Synthesize Planner and Researcher outputs into an EA brief and determine whether human approval is required.
5. **Coder:** Participate only after approval. If implementation is not approved, provide implementation-readiness notes and blocker analysis.
6. **Tester:** Define or run validation against requirements, risk rules, edge cases, and regression concerns.
7. **Reviewer:** Audit the full package for alignment, completeness, evidence quality, risk, and readiness.
8. **Commander:** Accept, revise, escalate, deliver, and update memory.

## Review Gates

- **Gate 1: Objective readiness.** Commander confirms the EA goal, output type, constraints, and non-goals.
- **Gate 2: Rule readiness.** Planner and Researcher confirm trading rules, assumptions, and open questions are visible.
- **Gate 3: Risk readiness.** Commander confirms position sizing, exposure, drawdown, stop behavior, and live-trading boundaries are defined or escalated.
- **Gate 4: Implementation approval.** Human approval is required before Coder produces implementation artifacts for live-capable EA behavior.
- **Gate 5: Validation readiness.** Tester confirms validation scope, edge cases, and blocked tests.
- **Gate 6: Acceptance review.** Reviewer gives accept, revise, or escalate recommendation.

## Delivery Criteria

Deliver only when:

- The selected workflow stages are completed or intentionally skipped with justification.
- EA objective, scope, assumptions, and non-goals are documented.
- Trading rules and risk rules are either approved or explicitly marked as blockers.
- Testing expectations and residual risks are visible.
- Reviewer has provided an acceptance recommendation.
- Commander has synthesized final status, open decisions, and next actions.

Do not deliver as implementation-ready if strategy rules, risk limits, or approval gates remain unresolved.

## Memory Update Procedure

After delivery, Commander updates TNPA project memory when the workflow produces:

- Approved EA assumptions.
- Approved or rejected trading rules.
- Risk limits or risk exceptions.
- Known EA issues.
- Testing gaps or recurring failures.
- Human approvals.
- Future EA improvements.

Updates should be concise, traceable, and stored in the appropriate project memory file. Do not store credentials, broker secrets, account data, or unsupported claims as confirmed knowledge.

## Escalation Rules

Escalate to the human operator when:

- Trading rules are ambiguous and the assumption would affect EA behavior.
- Risk limits are missing, changed, or exceeded.
- The request involves live trading, broker integration, order placement, or account-specific data.
- Research evidence conflicts with the proposed strategy.
- Tester or Reviewer identifies unresolved material risk.
- The user requests implementation before required approvals are complete.
