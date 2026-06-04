# Agent Harmes Task State Machine

## Purpose

The Task State Machine defines how Agent Harmes turns a user goal into controlled execution.

This workflow makes the system executable at the orchestration level. It gives Commander a standard way to know the current state of a task, which agent owns the next step, what artifact is expected, what review gate applies, and when human approval is required.

Related documents:

- `docs/orchestration_map.md`
- `AGENT_HARMES_RUNBOOK.md`
- `workflows/agent-handoff-protocol.md`
- `docs/artifact-registry.md`
- `memory/memory-update-rules.md`
- `memory/decision-log/README.md`
- `agents/contracts/commander-contract.md`
- `tasks/TASK_TEMPLATE/README.md`

## State Model

Every executable task must have exactly one active state.

Allowed states:

| State | Owner | Meaning |
| --- | --- | --- |
| `intake` | Commander | User goal has been received but not classified. |
| `classified` | Commander | Goal has project, workflow, risk, and stage classification. |
| `context_loaded` | Commander | Required project memory, workflows, playbooks, and agent specs are identified or loaded. |
| `planned` | Commander / Planner | Execution path, deliverables, gates, and dependencies are defined. |
| `assigned` | Commander | One or more agent handoffs have been created. |
| `in_progress` | Assigned Agent | Work is actively being produced. |
| `testing` | Tester | Output is being validated against requirements and risks. |
| `review` | Reviewer | Output is being audited for quality, alignment, risk, and readiness. |
| `approval_required` | Commander / Human | Human approval is required before continuing. |
| `revision_required` | Commander | Work must return to a prior agent for correction. |
| `blocked` | Commander | Work cannot continue without missing input, missing context, or external state change. |
| `accepted` | Commander | Output passed review and is accepted for delivery or downstream use. |
| `delivered` | Commander | User-facing delivery is complete. |
| `memory_update_required` | Commander | Lessons, decisions, issues, or validations must be recorded. |
| `memory_updated` | Commander | Required memory updates are complete. |
| `closed` | Commander | Task is complete and no required work remains. |

## Required Task Record

Every task must carry this minimum record:

```text
Task ID:
Goal:
Project:
Workflow:
Playbook:
Current State:
Owner:
Required Context:
Inputs:
Expected Deliverables:
Artifacts:
Decisions:
Approvals:
Review Status:
Memory Update Status:
Next Action:
```

The reusable template lives at:

- `tasks/TASK_TEMPLATE/README.md`

## State Transitions

### Intake To Classified

Commander may move `intake` to `classified` only after defining:

- Project or project candidate.
- Work type.
- Execution stage.
- Risk level.
- Likely workflow.
- Human approval sensitivity.

### Classified To Context Loaded

Commander may move `classified` to `context_loaded` only after identifying:

- Project memory files.
- Relevant workflow files.
- Relevant playbook files.
- Required agent contracts.
- Prior reviews, tests, specs, or implementation artifacts.

### Context Loaded To Planned

Commander may move `context_loaded` to `planned` only after defining:

- Execution sequence.
- Required deliverables.
- Agent assignment order.
- Review gates.
- Approval gates.
- Known risks and assumptions.

### Planned To Assigned

Commander may move `planned` to `assigned` only after creating a handoff using:

- `workflows/agent-handoff-protocol.md`

Each handoff must identify:

- Assigned agent.
- Objective.
- Context.
- Inputs.
- Output contract.
- Constraints.
- Acceptance criteria.

### Assigned To In Progress

An assigned agent may begin work only when:

- The handoff is complete.
- Required context is available.
- Constraints and non-goals are explicit.
- Human approval has been received when required.

### In Progress To Testing

Move to `testing` when an implementation, specification, reviewable artifact, or validation target exists.

Testing is required for:

- Code.
- Trading-system behavior.
- Deployment artifacts.
- Data outputs.
- Public-facing content when factual or formatting checks are needed.

### Testing To Review

Move to `review` when Tester output is available or when Commander explicitly marks testing as not applicable with rationale.

### Review To Accepted

Move to `accepted` only when Reviewer gives:

- Accept, or
- Accept with documented residual risk.

### Review To Revision Required

Move to `revision_required` when Reviewer or Tester finds issues requiring correction.

Commander must route the task back to the correct agent and preserve the review findings as context.

### Any State To Approval Required

Move to `approval_required` when work involves:

- Live trading.
- Broker integration.
- Order execution.
- Risk rule changes.
- Credential handling.
- External integrations.
- Deployment.
- Public trading or performance claims.
- Commit or push when requested by project rules or user instruction.

### Any State To Blocked

Move to `blocked` when work cannot continue because of:

- Missing user input.
- Missing project memory.
- Contradictory requirements.
- Failed environment dependency.
- Unavailable external system.
- Human approval not granted.

### Delivered To Memory Update Required

Move to `memory_update_required` when completed work creates:

- A durable decision.
- A lesson learned.
- A known issue.
- A validation result.
- An approved rule.
- A rejected assumption.
- A future improvement.

Use:

- `memory/memory-update-rules.md`

### Memory Updated To Closed

Move to `closed` only after:

- Required memory updates are complete or explicitly not required.
- Artifacts are registered or linked.
- Final delivery is complete.
- No required review, approval, or recovery work remains.

## Failure Recovery

When a task fails:

1. Commander identifies the failed state.
2. Commander records the reason in the task record.
3. Commander determines whether to revise, block, escalate, or close.
4. Responsible agent receives a new handoff with failure context.
5. Tester revalidates the corrected surface.
6. Reviewer confirms the recovery did not create new material risk.
7. Commander updates memory if the failure creates durable learning.

## TNPA Signal System Rule

Any task that builds, changes, deploys, or validates a TNPA Signal System must pass through:

1. `classified`
2. `context_loaded`
3. `planned`
4. `assigned`
5. `in_progress`
6. `testing`
7. `review`
8. `accepted`
9. `delivered`
10. `memory_update_required`
11. `memory_updated`
12. `closed`

Human approval is mandatory before any change that could move a TNPA system from alert-only behavior into order execution or broker-connected trade management.
