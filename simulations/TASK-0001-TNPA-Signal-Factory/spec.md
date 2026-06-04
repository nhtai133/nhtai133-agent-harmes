# TASK-0001 Specification

## Objective

Define a no-code TNPA Signal Factory simulation that validates whether Agent Harmes can execute an end-to-end task lifecycle using Sprint 002 framework artifacts.

## Scope

This specification covers:

- Task state tracking.
- Agent handoffs.
- Artifact registration.
- Memory update decision.
- Researcher, Coder, Tester, and Reviewer contract usage.
- TNPA skill context usage.

This specification does not cover:

- Production code.
- MQ5 source changes.
- EX5 compilation.
- Deployment.
- Live trading signals.
- Broker integration.

## Selected Route

```text
Workflow: workflows/build_ea.md
Playbook: playbooks/build_mt5_ea.playbook.md
State Machine: workflows/task-state-machine.md
Handoff Protocol: workflows/agent-handoff-protocol.md
Artifact Registry: docs/artifact-registry.md
Memory Rules: memory/memory-update-rules.md
Decision Log: memory/decision-log/README.md
```

## Execution Sequence

Required sequence:

```text
Commander -> Researcher -> Coder -> Tester -> Reviewer
```

## Commander Decisions

### Decision 1

```text
Decision ID: DEC-TNPA-20260605-001
Decision Type: workflow_selection
Decision Owner: Commander
Selected Option: workflows/build_ea.md
Rationale: TNPA Signal Factory is closest to a TNPA Signal System / EA planning workflow.
Human Approval Required: No
Linked Artifacts: task.md, research.md, spec.md
```

### Decision 2

```text
Decision ID: DEC-TNPA-20260605-002
Decision Type: scope_boundary
Decision Owner: Commander
Selected Option: no-code runtime validation
Rationale: User explicitly requested validation of the framework and no production code.
Human Approval Required: No
Linked Artifacts: implementation.md
```

### Decision 3

```text
Decision ID: DEC-TNPA-20260605-003
Decision Type: memory_update
Decision Owner: Commander
Selected Option: simulate memory update in retrospective.md
Rationale: Sprint 003 should validate memory rules without modifying long-term project memory unless separately requested.
Human Approval Required: No
Linked Artifacts: retrospective.md
```

## Functional Requirements

- The task record must include current state, selected workflow, playbook, required context, artifacts, decisions, review status, memory status, and next action.
- Each specialist artifact must include handoff context or contract-aligned output.
- The implementation artifact must explicitly avoid production code.
- Tester must validate Sprint 002 framework compliance.
- Reviewer must produce an approval decision.
- Retrospective must identify memory update candidates and Sprint 004 recommendation.

## Acceptance Criteria

- All requested files exist under `simulations/TASK-0001-TNPA-Signal-Factory/`.
- Task lifecycle reaches `closed`.
- No application code is written.
- No trading API or live signal is introduced.
- Artifact registry entries are represented.
- Memory update decision is represented.
- Sprint 003 review can produce Pass/Fail.

## Risks

- Manual markdown state can drift without runtime enforcement.
- Artifact records are embedded instead of stored in a registry.
- Decision records are simulated instead of persisted as individual decision files.
- Memory update is simulated, not written to durable project memory.

## Recommended Next State

```text
assigned
```
