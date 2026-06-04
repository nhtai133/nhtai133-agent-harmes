# Agent Harmes Artifact Registry

## Purpose

The Artifact Registry defines how Agent Harmes tracks files and outputs created during execution.

Artifacts are the evidence trail for decisions, reviews, testing, delivery, deployment, and memory updates. A task is not review-ready unless its important artifacts are identifiable.

Related documents:

- `workflows/task-state-machine.md`
- `workflows/agent-handoff-protocol.md`
- `memory/memory-update-rules.md`
- `memory/decision-log/README.md`
- `tasks/TASK_TEMPLATE/README.md`

## Artifact Types

Allowed artifact types:

- `spec`
- `source`
- `compiled_output`
- `test_plan`
- `test_report`
- `design_review`
- `code_review`
- `compile_report`
- `deployment_report`
- `environment_audit`
- `architecture_audit`
- `workflow`
- `playbook`
- `task`
- `agent_contract`
- `memory_update`
- `decision_log`
- `prompt`
- `simulation`
- `runbook`

## Artifact Status

Allowed statuses:

- `draft`
- `ready_for_test`
- `testing`
- `ready_for_review`
- `reviewed`
- `accepted`
- `revision_required`
- `deployed`
- `superseded`
- `archived`

## Required Artifact Record

```text
Artifact ID:
Task ID:
Path:
Type:
Owner Agent:
Status:
Created Date:
Updated Date:
Linked Workflow:
Linked Playbook:
Review Required:
Reviewer:
Validation Required:
Latest Validation Result:
Approval Required:
Memory Update Required:
Notes:
```

## Artifact ID Convention

Use a stable ID:

```text
ART-<PROJECT>-<TYPE>-<YYYYMMDD>-<SEQUENCE>
```

Examples:

- `ART-TNPA-SPEC-20260604-001`
- `ART-HARMES-WORKFLOW-20260604-001`
- `ART-TNPA-COMPILE-20260604-001`

## Required Registration Points

Commander should register or update artifacts when:

- A specification is created.
- Source code is created or modified.
- A compiled output is generated.
- A test plan or test report is created.
- A review is created.
- A deployment report is created.
- A workflow, playbook, task, contract, or prompt changes.
- Memory is updated from a completed task.

## TNPA v0.4 Artifact Examples

Existing TNPA Signal Engine v0.4 artifacts that can be represented by this registry:

| Path | Type | Status |
| --- | --- | --- |
| `specs/tnpa_telegram_alert_ea_spec.md` | `spec` | `accepted` |
| `src/TNPA_Telegram_Alert_EA.mq5` | `source` | `reviewed` |
| `src/TNPA_Telegram_Alert_EA.ex5` | `compiled_output` | `deployed` |
| `reviews/tnpa_telegram_alert_ea_code_review.md` | `code_review` | `accepted` |
| `reviews/tnpa_telegram_alert_ea_compile_report.md` | `compile_report` | `accepted` |
| `reviews/exness_mt5_20_3_deployment_report.md` | `deployment_report` | `accepted` |
| `tests/tnpa_v0_4_signal_validation.md` | `test_plan` | `ready_for_test` |

## Review Rules

Artifacts that affect execution must be reviewed before acceptance:

- Source code.
- Compiled outputs.
- Deployment reports.
- Trading-system specifications.
- Risk-related project memory.
- Public content with market or performance claims.
- Integration specifications.

## Artifact Registry Location

This file defines the registry model only. Actual artifact records may initially live inside task files, review files, or future registry files.

Recommended future folder:

- `registry/artifacts/`

Do not create runtime registry files until the task lifecycle is validated through manual Sprint 003 execution.
