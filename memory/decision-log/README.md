# Agent Harmes Decision Log

## Purpose

The Decision Log records durable Commander and human decisions that affect execution.

Decisions are different from memory:

- A decision explains what was chosen and why.
- Memory preserves reusable knowledge for future execution.

Related documents:

- `memory/memory-update-rules.md`
- `workflows/task-state-machine.md`
- `docs/artifact-registry.md`
- `agents/contracts/commander-contract.md`
- `tasks/TASK_TEMPLATE/README.md`

## Decision Types

Allowed decision types:

- `workflow_selection`
- `playbook_selection`
- `agent_assignment`
- `scope_boundary`
- `architecture_choice`
- `implementation_approval`
- `deployment_approval`
- `risk_exception`
- `human_escalation`
- `memory_update`
- `task_closure`

## Required Decision Record

```text
Decision ID:
Date:
Task ID:
Decision Type:
Decision Owner:
Commander Summary:
Context:
Options Considered:
Selected Option:
Rationale:
Risks:
Human Approval Required:
Human Approval Status:
Linked Artifacts:
Memory Update Required:
Follow-up Action:
```

## Decision ID Convention

Use:

```text
DEC-<PROJECT>-<YYYYMMDD>-<SEQUENCE>
```

Examples:

- `DEC-HARMES-20260604-001`
- `DEC-TNPA-20260604-001`

## Commander Decisions

Commander may decide:

- Which workflow to use.
- Which playbook to use.
- Which agent receives a handoff.
- Whether a task is blocked.
- Whether an artifact is ready for test or review.
- Whether memory update is required.
- Whether delivery is complete.

## Human Approval Decisions

Human approval is required for:

- Live trading.
- Order execution.
- Broker integration.
- Credential handling.
- Risk rule changes.
- Deployment to operational environments when requested by policy.
- Public trading or performance claims.
- Commit and push when explicitly requested or governed by task rules.

## Storage Rule

This folder is the decision-log home.

For Sprint 002, this `README.md` defines the decision model. Future sprints may add decision records as separate markdown files in this folder.

Do not store secrets, credentials, private account exports, or unsanitized logs in decision records.
