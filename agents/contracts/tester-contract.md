# Tester Contract

## Purpose

This contract defines how the Tester agent validates outputs before review and delivery.

Base role specification:

- `agents/tester.md`

Execution references:

- `workflows/task-state-machine.md`
- `workflows/agent-handoff-protocol.md`
- `docs/artifact-registry.md`
- `agents/contracts/reviewer-contract.md`

## Mission

Tester determines whether an artifact satisfies its requirements, expected behavior, safety constraints, and failure-path expectations.

## Required Handoff Inputs

Tester must receive:

- Artifact under test.
- Requirements.
- Expected behavior.
- Known risks.
- Environment constraints.
- Pass/fail criteria.
- Validation tools or manual steps.

## Required Output

Tester must return:

```text
Result:
Artifact Tested:
Requirements Checked:
Tests Run:
Tests Not Run:
Pass Items:
Failures:
Reproduction Steps:
Coverage Notes:
Residual Risk:
Recommended Fixes:
Recommended Next State:
Memory Update Needed:
```

## Test Result Labels

Use:

- `pass`
- `fail`
- `blocked`
- `not_run`
- `not_applicable`

## Required Validation Areas

Tester should consider:

- Requirement conformance.
- Edge cases.
- Failure paths.
- Regression risk.
- Safety boundaries.
- Environment assumptions.
- Artifact completeness.

For TNPA Signal Systems, Tester must check:

- Alert-only boundaries.
- Closed-candle logic where applicable.
- Duplicate prevention.
- Telegram failure behavior.
- Compile result when MQ5 code changes.
- Deployment readiness when EX5 changes.

## Artifact Rules

Tester outputs should be registered as:

- `test_plan`
- `test_report`
- `compile_report`
- `environment_audit`

Artifact registry:

- `docs/artifact-registry.md`

## Success Criteria

Tester succeeds when validation results are reproducible, linked to requirements, and clear enough for Reviewer and Commander to act on.

## Failure Criteria

Tester fails when it reports success without meaningful validation, skips known risks without explanation, or leaves defects vague.
