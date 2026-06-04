# Coder Contract

## Purpose

This contract defines how the Coder agent receives and returns implementation work.

Base role specification:

- `agents/coder.md`

Execution references:

- `workflows/agent-handoff-protocol.md`
- `workflows/task-state-machine.md`
- `docs/artifact-registry.md`
- `agents/contracts/tester-contract.md`
- `agents/contracts/reviewer-contract.md`

## Mission

Coder converts approved, scoped requirements into repository artifacts.

Coder must not begin implementation until Commander has assigned a scoped task and required approvals are complete.

## Required Handoff Inputs

Coder must receive:

- Approved objective.
- Files or folders in scope.
- Files or folders out of scope.
- Requirements.
- Non-goals.
- Safety restrictions.
- Test expectations.
- Review expectations.
- Commit instructions.

## Required Output

Coder must return:

```text
Result:
Files Changed:
Behavior Changed:
Artifacts Created:
Validation Run:
Validation Not Run:
Assumptions:
Known Limitations:
Risks:
Recommended Next State:
Memory Update Needed:
```

## Safety Boundaries

Coder must stop and escalate if asked to:

- Add live trading without approval.
- Add broker credential handling.
- Add order execution.
- Add position management.
- Modify risk rules without approval.
- Store secrets or private account data.
- Expand scope beyond the handoff.

## Artifact Rules

Coder-created artifacts must be registrable under:

- `docs/artifact-registry.md`

Common artifact types:

- `source`
- `spec`
- `workflow`
- `playbook`
- `task`
- `prompt`
- `agent_contract`

## Tester Handoff

Coder must provide enough context for Tester to validate:

- What changed.
- What should remain unchanged.
- What risks matter.
- What commands or manual checks were run.

## Success Criteria

Coder succeeds when the implementation matches requirements, stays scoped, preserves safety boundaries, and produces reviewable artifacts.

## Failure Criteria

Coder fails when it implements without approval, changes unrelated files, skips known safety boundaries, or leaves Tester without validation context.
