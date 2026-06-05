# Agent Harmes Task Registry

## Purpose

This registry makes Agent Harmes tasks queryable without adding runtime code.

It indexes known task records, reusable task templates, and simulation task folders so Commander can answer:

- What tasks exist?
- Which project owns a task?
- What state is each task in?
- Which workflow and playbook apply?
- Which artifacts, decisions, and memory records are linked?
- What is the next executable action?

Schema source:

- `workflows/task-state-machine.md`
- `tasks/TASK_TEMPLATE/README.md`

## Query Keys

Use these stable fields when searching or filtering:

```text
Task ID
Task Kind
Project ID
Current State
Workflow
Playbook
Owner
Risk Level
Review Status
Memory Update Status
Source Path
Next Action
```

## Task Records

| Task ID | Task Kind | Project ID | Current State | Workflow | Playbook | Owner | Risk Level | Review Status | Memory Update Status | Source Path | Next Action |
| --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- |
| `TASK-0001-TNPA-Signal-Factory` | simulation_execution | `PROJ-TNPA-TRADING-OS` | `closed` | `workflows/build_ea.md` | `playbooks/build_mt5_ea.playbook.md` | Commander | Medium | approved_with_residual_risk | simulated_only | `simulations/TASK-0001-TNPA-Signal-Factory/task.md` | Represented in runtime-lite registries by Sprint 004. |
| `TASK-0002-Runtime-Registry-Audit` | registry_validation | `PROJ-AGENT-HARMES` | `closed` | `workflows/task-state-machine.md` | none | Commander | Low | approved_with_residual_risk | not_required | `simulations/TASK-0002-Runtime-Registry-Audit/task.md` | Use findings to plan Sprint 005. |
| `TASK-TEMPLATE-BUILD-NEW-EA` | reusable_task_template | `PROJ-TNPA-TRADING-OS` | template | `workflows/build_ea.md` | `playbooks/build_mt5_ea.playbook.md` | Commander | Medium | requires_runtime_instance | required_when_executed | `tasks/build_new_ea.task.md` | Instantiate with symbol, timeframe, strategy concept, risk limits, and output type. |
| `TASK-TEMPLATE-ANALYZE-XAUUSD` | reusable_task_template | `PROJ-TNPA-TRADING-OS` | template | `workflows/analyze_market.md` | `playbooks/analyze_market.playbook.md` | Commander | Medium | requires_runtime_instance | required_when_executed | `tasks/analyze_xauusd.task.md` | Instantiate with analysis purpose, time horizon, freshness standard, and decision context. |
| `TASK-TEMPLATE-CREATE-TIKTOK-SERIES` | reusable_task_template | `PROJ-TNPA-TRADING-OS` | template | `workflows/create_content.md` | `playbooks/create_content.playbook.md` | Commander | Medium | requires_runtime_instance | required_when_executed | `tasks/create_tiktok_series.task.md` | Instantiate with audience, objective, cadence, topic boundaries, and approval owner. |
| `SPRINT-002-EXECUTION-FRAMEWORK` | sprint_definition | `PROJ-AGENT-HARMES` | accepted | none | none | Commander | Low | accepted | completed_by_framework_docs | `tasks/sprint_002_execution_framework.md` | Superseded by Sprint 002 review and Sprint 003 validation. |

## TASK-0001 Runtime Record

```text
Task ID: TASK-0001-TNPA-Signal-Factory
Task Title: Validate Execution Framework With TNPA Signal Factory Task
Created Date: 2026-06-05
Project ID: PROJ-TNPA-TRADING-OS
Project Name: TNPA Trading OS
Requested By: Human Operator
Commander: Agent Harmes Commander
Current State: closed
Priority: High
Risk Level: Medium
Workflow: workflows/build_ea.md
Playbook: playbooks/build_mt5_ea.playbook.md
Required Agents: Commander, Researcher, Coder, Tester, Reviewer
Final Review: approved_with_residual_risk
Memory Update Status: simulated_only
Source Folder: simulations/TASK-0001-TNPA-Signal-Factory/
Linked Decisions: DEC-TNPA-20260605-001, DEC-TNPA-20260605-002, DEC-TNPA-20260605-003
Linked Memory: MEM-TNPA-20260605-001
Linked Review: reviews/sprint_003_runtime_validation.md
Non-goals: no production code, no MT5 changes, no live trading signals, no broker integration, no credential handling
Closure: closed on 2026-06-05
```

## State Coverage Query

To answer "which tasks are active?", filter records where `Current State` is not:

```text
closed
template
accepted
archived
```

Current result:

```text
No active executable tasks are open after Sprint 004 registry creation.
```

## Workflow Query

To answer "which tasks use build EA?", filter:

```text
Workflow = workflows/build_ea.md
```

Current result:

- `TASK-0001-TNPA-Signal-Factory`
- `TASK-TEMPLATE-BUILD-NEW-EA`

## Project Query

To answer "which tasks belong to TNPA Trading OS?", filter:

```text
Project ID = PROJ-TNPA-TRADING-OS
```

Current result:

- `TASK-0001-TNPA-Signal-Factory`
- `TASK-TEMPLATE-BUILD-NEW-EA`
- `TASK-TEMPLATE-ANALYZE-XAUUSD`
- `TASK-TEMPLATE-CREATE-TIKTOK-SERIES`

## Gaps

- No automated required-field validation.
- No enforced state transition validator.
- No unique task ID reservation mechanism.
- No execution log registry was requested in Sprint 004.
- Planner still has no execution contract.
