# Agent Harmes Decision Registry

## Purpose

This registry centralizes existing Commander and review decisions so future agents can query why a route, boundary, approval, or closure happened.

Schema source:

- `memory/decision-log/README.md`

## Query Keys

```text
Decision ID
Date
Task ID
Project ID
Decision Type
Decision Owner
Selected Option
Human Approval Required
Human Approval Status
Linked Artifacts
Memory Update Required
Follow-up Action
```

## Decision Records

| Decision ID | Date | Task ID | Project ID | Decision Type | Decision Owner | Selected Option | Human Approval Required | Human Approval Status | Linked Artifacts | Memory Update Required | Follow-up Action |
| --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- |
| `DEC-TNPA-20260605-001` | 2026-06-05 | `TASK-0001-TNPA-Signal-Factory` | `PROJ-TNPA-TRADING-OS` | workflow_selection | Commander | `workflows/build_ea.md` | No | not_required | `task.md`, `research.md`, `spec.md` | Yes | Use Build EA route for TNPA Signal System validation. |
| `DEC-TNPA-20260605-002` | 2026-06-05 | `TASK-0001-TNPA-Signal-Factory` | `PROJ-TNPA-TRADING-OS` | scope_boundary | Commander | no-code runtime validation | No | not_required | `implementation.md` | Yes | Preserve no production code boundary. |
| `DEC-TNPA-20260605-003` | 2026-06-05 | `TASK-0001-TNPA-Signal-Factory` | `PROJ-TNPA-TRADING-OS` | memory_update | Commander | simulate memory update in retrospective.md | No | not_required | `retrospective.md` | Yes | Create runtime-lite memory registry in Sprint 004. |
| `DEC-HARMES-20260605-001` | 2026-06-05 | `TASK-0002-Runtime-Registry-Audit` | `PROJ-AGENT-HARMES` | architecture_choice | Commander | markdown runtime-lite registries under `memory/registries/`, `projects/`, and `docs/` | No | not_required | Sprint 004 registry files | No | Use registries as query source until runtime code exists. |
| `DEC-HARMES-20260605-002` | 2026-06-05 | `TASK-0002-Runtime-Registry-Audit` | `PROJ-AGENT-HARMES` | scope_boundary | Commander | no production code and no integrations | No | not_required | Sprint 004 registry files | No | Defer Telegram, Discord, Notion, Google Drive, and runtime implementation. |
| `DEC-HARMES-20260605-003` | 2026-06-05 | `TASK-0002-Runtime-Registry-Audit` | `PROJ-AGENT-HARMES` | task_closure | Reviewer | approve Sprint 004 with residual runtime gaps | No | not_required | `reviews/sprint_004_runtime_registry_review.md` | No | Recommend Sprint 005 runtime-lite validation and Planner contract. |
| `DEC-SPRINT-002-001` | 2026-06-04 | `SPRINT-002-EXECUTION-FRAMEWORK` | `PROJ-AGENT-HARMES` | architecture_choice | Commander | execution state before integrations | No | not_required | `reviews/sprint_002_execution_review.md` | No | Build task state, handoff, artifact, decision, and memory contracts first. |
| `DEC-SPRINT-002-002` | 2026-06-04 | `SPRINT-002-EXECUTION-FRAMEWORK` | `PROJ-AGENT-HARMES` | architecture_choice | Commander | markdown contracts before runtime code | No | not_required | `reviews/sprint_002_execution_review.md` | No | Implement stable contracts before runtime. |
| `DEC-SPRINT-002-003` | 2026-06-04 | `SPRINT-002-EXECUTION-FRAMEWORK` | `PROJ-AGENT-HARMES` | scope_boundary | Commander | Commander owns state transitions | No | not_required | `workflows/task-state-machine.md` | No | Keep specialist agents inside assigned scope. |
| `DEC-TNPA-V04-001` | 2026-06-03 | legacy_tnpa_v0_4 | `PROJ-TNPA-TRADING-OS` | scope_boundary | Reviewer | TNPA v0.4 EA remains alert-only | Yes for any change to order execution | not_requested | `specs/tnpa_telegram_alert_ea_spec.md`, `reviews/tnpa_telegram_alert_ea_code_review.md` | Yes | Do not add trading APIs without explicit human approval. |
| `DEC-TNPA-V04-002` | 2026-06-03 | legacy_tnpa_v0_4 | `PROJ-TNPA-TRADING-OS` | deployment_approval | Reviewer | approved for manual MT5 testing after compile and deployment | No for manual demo testing | not_required | `reviews/tnpa_telegram_alert_ea_compile_report.md`, `reviews/exness_mt5_20_3_deployment_report.md` | Yes | Complete manual MT5 signal validation. |

## Human Approval Query

Find decisions that require human approval:

```text
Human Approval Required != No
```

Current material result:

- `DEC-TNPA-V04-001`: any move from alert-only behavior to order execution requires explicit human approval.

## Integration Deferral Query

Find decisions blocking integration work:

```text
Decision Type = scope_boundary
Selected Option contains no integrations
```

Current material result:

- `DEC-HARMES-20260605-002`

## Gaps

- Decision records are centralized here, but not stored as one file per decision.
- No approval registry exists yet.
- No automated conflict detection exists between new task requests and prior decisions.
