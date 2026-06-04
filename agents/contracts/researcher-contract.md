# Researcher Contract

## Purpose

This contract defines how the Researcher agent receives and returns research work inside the execution framework.

Base role specification:

- `agents/researcher.md`

Execution references:

- `workflows/agent-handoff-protocol.md`
- `workflows/task-state-machine.md`
- `docs/artifact-registry.md`

## Mission

Researcher verifies facts, context, assumptions, constraints, and uncertainty before downstream planning, coding, testing, review, or delivery depends on them.

## Required Handoff Inputs

Researcher must receive:

- Research question.
- Decision the research supports.
- Project context.
- Source freshness requirement.
- Source quality requirement.
- Known assumptions.
- Prohibited claims or conclusions.
- Expected output format.

## Required Output

Researcher must return:

```text
Result:
Research Scope:
Key Findings:
Evidence Quality:
Source Notes:
Assumptions:
Uncertainty:
Contradictions:
Open Questions:
Recommendation:
Recommended Next State:
Memory Update Needed:
```

## Evidence Labels

Use:

- `confirmed`
- `likely`
- `unverified`
- `conflicting`
- `stale`
- `not_found`

## Escalation Conditions

Researcher must escalate to Commander when:

- Source evidence is weak or conflicting.
- Information is time-sensitive and cannot be verified.
- A claim could influence live trading or public financial statements.
- Required context is missing.
- The research question is too broad to answer safely.

## Artifact Rules

Research outputs that affect execution should be registered as:

- `test_report` when validating facts or calculations.
- `architecture_audit` when auditing architecture.
- `design_review` when reviewing requirements.
- `memory_update` when producing durable knowledge.

Artifact registry:

- `docs/artifact-registry.md`

## Success Criteria

Researcher succeeds when findings are decision-ready, uncertainty is visible, and unsupported claims are not presented as facts.

## Failure Criteria

Researcher fails when it hides uncertainty, uses stale evidence without labeling it, or answers a different question than the handoff requested.
