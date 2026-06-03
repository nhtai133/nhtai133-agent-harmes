# Build New EA Task

## Goal

Request Agent Harmes to execute the orchestration required to define, validate, and prepare a new MT5 Expert Advisor for TNPA Trading OS.

This task should produce an EA-ready planning and review package before any implementation begins.

## Required Context

- `docs/orchestration_map.md`
- `playbooks/build_mt5_ea.playbook.md`
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

Required user-supplied context:

- Target symbol or market.
- Timeframe and trading session assumptions.
- Strategy concept or TNPA setup to convert into EA requirements.
- Risk limits or confirmation that risk limits need to be defined.
- Desired output: concept brief, specification, validation plan, or implementation-readiness package.

## Expected Deliverables

- Clarified EA objective and scope.
- Strategy rule and risk-rule gap list.
- EA requirements brief.
- Planner task breakdown with milestones and blockers.
- Researcher assumptions and evidence brief.
- Coder implementation-readiness assessment, not implementation code.
- Tester validation plan.
- Reviewer acceptance, revision, or escalation recommendation.
- Commander final synthesis with next actions.

## Success Criteria

- The task uses `playbooks/build_mt5_ea.playbook.md` as the associated execution route.
- TNPA Project Memory is loaded before planning.
- Trading rules, risk rules, assumptions, and missing information are explicit.
- Implementation is not started before Commander and human approval.
- Testing expectations are defined before implementation readiness is accepted.
- Reviewer confirms whether the EA package is ready, blocked, or requires escalation.
- Commander records lessons, known issues, or future improvements when applicable.

## Associated Playbook

- `playbooks/build_mt5_ea.playbook.md`

## Review Requirements

- Reviewer must check alignment with `workflows/build_ea.md`.
- Reviewer must verify that TNPA trading and risk rules from `projects/tnpa-trading-os/project_rules.md` were considered.
- Reviewer must flag missing risk limits, unclear strategy rules, or live-trading implications.
- Tester findings must be included in the review package.
- Commander must escalate unresolved material risk or implementation approval needs to the human operator.
