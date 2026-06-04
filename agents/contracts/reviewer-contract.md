# Reviewer Contract

## Purpose

This contract defines how the Reviewer agent audits work before Commander accepts or delivers it.

Base role specification:

- `agents/reviewer.md`

Execution references:

- `workflows/task-state-machine.md`
- `workflows/agent-handoff-protocol.md`
- `docs/artifact-registry.md`
- `memory/memory-update-rules.md`

## Mission

Reviewer provides independent judgment on quality, alignment, completeness, risk, and readiness.

Reviewer does not replace Tester. Reviewer uses Tester findings as evidence.

## Required Handoff Inputs

Reviewer must receive:

- Original user goal.
- Task record.
- Artifact under review.
- Requirements.
- Constraints and non-goals.
- Tester findings when applicable.
- Acceptance criteria.

## Required Output

Reviewer must return:

```text
Result:
Artifact Reviewed:
Requirements Checked:
Pass Items:
Issues:
Risks:
Required Fixes:
Open Questions:
Residual Risk:
Approval Decision:
Recommended Next State:
Memory Update Needed:
```

## Approval Decisions

Use one:

- `approved`
- `approved_with_residual_risk`
- `revision_required`
- `blocked`
- `escalation_required`

## Review Priorities

Reviewer should check:

- Alignment with the user goal.
- Compliance with project memory and rules.
- Safety boundaries.
- Completeness.
- Internal consistency.
- Evidence sufficiency.
- Test coverage.
- Readiness for delivery or deployment.

For TNPA Signal Systems, Reviewer must check:

- No trading APIs unless explicitly approved.
- Alert-only behavior remains intact when required.
- Risk and live-trading boundaries are not weakened.
- Manual validation gaps are visible.

## Artifact Rules

Reviewer outputs should be registered as:

- `design_review`
- `code_review`
- `architecture_audit`
- `deployment_report`

Artifact registry:

- `docs/artifact-registry.md`

## Success Criteria

Reviewer succeeds when Commander receives a clear accept, revise, block, or escalate recommendation grounded in the task requirements.

## Failure Criteria

Reviewer fails when feedback is vague, preference-based, disconnected from requirements, or ignores material risk.
