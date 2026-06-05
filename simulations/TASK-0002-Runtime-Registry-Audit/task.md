# TASK-0002: Runtime Registry Audit

## Task Record

```text
Task ID: TASK-0002-Runtime-Registry-Audit
Task Title: Validate Sprint 004 Runtime-Lite Registry
Created Date: 2026-06-05
Project: Agent Harmes Core
Project ID: PROJ-AGENT-HARMES
Requested By: Human Operator
Commander: Agent Harmes Commander
Current State: closed
Priority: High
Risk Level: Low
```

## Goal

```text
User Goal:
Make Agent Harmes machine-queryable by creating runtime-lite registries and a query catalog.

Commander Interpretation:
Create markdown registries for tasks, artifacts, decisions, memory, and projects, then validate that existing repository artifacts are represented and query patterns are defined for future autonomous execution.

Expected Outcome:
Registry files, query catalog, TASK-0002 validation artifacts, and Sprint 004 review exist.

Non-goals:
No production code.
No integrations.
No Telegram, Discord, Notion, or Google Drive work.
No runtime executor.
```

## Classification

```text
Work Type: Architecture / Runtime-lite registry
Execution Stage: Registry creation and validation
Selected Workflow: workflows/task-state-machine.md
Selected Playbook: none
Required Agents: Commander, Researcher, Tester, Reviewer
Human Approval Required: No
Approval Reason: Markdown-only registry and validation artifacts; no external systems or production behavior.
```

## Required Context

```text
Repository Reviews:
reviews/sprint_003_runtime_validation.md
reviews/sprint_002_execution_review.md
reviews/repository_audit.md

Execution Framework:
workflows/task-state-machine.md
workflows/agent-handoff-protocol.md
docs/artifact-registry.md
memory/memory-update-rules.md
memory/decision-log/README.md
tasks/TASK_TEMPLATE/README.md

Existing Project Records:
projects/tnpa-trading-os/project_context.md
projects/tnpa-trading-os/project_rules.md
projects/tnpa-trading-os/project_memory.md

Existing Task Evidence:
tasks/build_new_ea.task.md
tasks/analyze_xauusd.task.md
tasks/create_tiktok_series.task.md
tasks/sprint_002_execution_framework.md
simulations/TASK-0001-TNPA-Signal-Factory/

Existing TNPA Evidence:
specs/tnpa_telegram_alert_ea_spec.md
src/TNPA_Telegram_Alert_EA.mq5
src/TNPA_Telegram_Alert_EA.ex5
reviews/tnpa_telegram_alert_ea_code_review.md
reviews/tnpa_telegram_alert_ea_compile_report.md
reviews/exness_mt5_20_3_deployment_report.md
tests/tnpa_v0_4_signal_validation.md
tests/tnpa_telegram_alert_ea_manual_test_plan.md
```

## State Transitions

| Step | State | Owner | Artifact |
| --- | --- | --- | --- |
| 1 | `intake` | Commander | `task.md` |
| 2 | `classified` | Commander | `task.md` |
| 3 | `context_loaded` | Commander | `research.md` |
| 4 | `planned` | Commander | `task.md` |
| 5 | `in_progress` | Commander | registry files |
| 6 | `testing` | Tester | `validation.md` |
| 7 | `review` | Reviewer | `review.md` |
| 8 | `accepted` | Commander | `review.md` |
| 9 | `delivered` | Commander | `reviews/sprint_004_runtime_registry_review.md` |
| 10 | `memory_update_required` | Commander | `memory/registries/memory-registry.md` |
| 11 | `memory_updated` | Commander | `memory/registries/memory-registry.md` |
| 12 | `closed` | Commander | `reviews/sprint_004_runtime_registry_review.md` |

## Registry Deliverables

| Path | Purpose |
| --- | --- |
| `memory/registries/task-registry.md` | Queryable task index. |
| `memory/registries/artifact-registry.md` | Queryable artifact index. |
| `memory/registries/decision-registry.md` | Queryable decision index. |
| `memory/registries/memory-registry.md` | Queryable memory index. |
| `projects/project-registry.md` | Queryable project index. |
| `docs/runtime-query-catalog.md` | Query patterns for future autonomous execution. |

## Acceptance Criteria

- Required registry files exist.
- Registries are populated from existing repository artifacts.
- TASK-0001 records are represented.
- Existing project records are represented.
- Query patterns are defined.
- No production code is created.
- No integrations are created.
- Missing runtime capabilities are documented.

## Closure

```text
Final State: closed
Delivered: yes
Memory Updated: memory registry contains MEM-HARMES-20260605-001
Open Risks: no automated validation, no enforced state transitions, no ID reservation, no Planner contract
Recommended Next Task: Sprint 005 runtime-lite validation and Planner contract
Closed Date: 2026-06-05
```
