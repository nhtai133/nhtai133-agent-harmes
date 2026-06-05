# Agent Harmes Project Registry

## Purpose

This registry indexes projects and project-like verticals so Commander can route tasks by project ID instead of relying on folder discovery alone.

## Query Keys

```text
Project ID
Project Name
Status
Primary Folder
Project Type
Owner
Core Memory
Workflows
Playbooks
Known Tasks
Known Artifacts
Risk Level
Next Action
```

## Project Records

| Project ID | Project Name | Status | Primary Folder | Project Type | Owner | Core Memory | Workflows | Playbooks | Known Tasks | Known Artifacts | Risk Level | Next Action |
| --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- |
| `PROJ-AGENT-HARMES` | Agent Harmes Core | active_architecture | repository root | multi_agent_operating_system | Commander | `README.md`, `AGENT_HARMES_RUNBOOK.md`, `docs/vision.md`, `docs/orchestration_map.md`, `memory/memory-update-rules.md` | `workflows/task-state-machine.md`, `workflows/agent-handoff-protocol.md`, `workflows/build_ea.md`, `workflows/build_dashboard.md`, `workflows/create_content.md`, `workflows/analyze_market.md` | none dedicated | `SPRINT-002-EXECUTION-FRAMEWORK`, `TASK-0002-Runtime-Registry-Audit` | framework docs, reviews, runtime-lite registries | Medium | Sprint 005 should add validation/enforcement specs and Planner contract. |
| `PROJ-TNPA-TRADING-OS` | TNPA Trading OS | active_vertical | `projects/tnpa-trading-os/` | trading_signal_system | Commander | `project_context.md`, `project_rules.md`, `project_memory.md` | `workflows/build_ea.md`, `workflows/analyze_market.md`, `workflows/build_dashboard.md`, `workflows/create_content.md` | `playbooks/build_mt5_ea.playbook.md`, `playbooks/analyze_market.playbook.md`, `playbooks/create_content.playbook.md` | `TASK-0001-TNPA-Signal-Factory`, `TASK-TEMPLATE-BUILD-NEW-EA`, `TASK-TEMPLATE-ANALYZE-XAUUSD`, `TASK-TEMPLATE-CREATE-TIKTOK-SERIES` | TNPA skill files, v0.4 EA spec, MQ5, EX5, compile report, deployment report, validation plans | High | Complete manual MT5 validation before operational reliance; preserve alert-only boundary. |

## Project Candidates From Roadmap

These are named in `reviews/repository_audit.md` but do not have project folders yet.

| Project ID | Project Name | Status | Primary Folder | Project Type | Owner | Next Action |
| --- | --- | --- | --- | --- | --- | --- |
| `PROJ-HARMES-OS` | Harmes OS | missing | none | future_vertical | Commander | Create project context before execution. |
| `PROJ-TNPA-INVESTMENT-OS` | TNPA Investment OS | missing | none | future_vertical | Commander | Create project context before execution. |
| `PROJ-CONTENT-ENGINE` | Content Engine | missing | none | future_vertical | Commander | Create project context before execution. |
| `PROJ-ENGLISH-LEARNING-ENGINE` | English Learning Engine | missing | none | future_vertical | Commander | Create project context before execution. |
| `PROJ-IB-CRM` | IB CRM | missing | none | future_vertical | Commander | Create project context before execution. |

## Routing Rules

### TNPA Trading OS

If a task mentions TNPA trading, TNPA Signal System, MT5 EA, XAUUSD, Telegram Alert EA, trading dashboard, or TNPA content, load:

```text
projects/tnpa-trading-os/project_context.md
projects/tnpa-trading-os/project_rules.md
projects/tnpa-trading-os/project_memory.md
skills/trading/tnpa/skill.md
```

Then select one primary workflow:

- `workflows/build_ea.md` for EA and signal-system work.
- `workflows/analyze_market.md` for market analysis.
- `workflows/create_content.md` for content.
- `workflows/build_dashboard.md` for dashboard work.

### Agent Harmes Core

If a task mentions runtime, registry, architecture, agents, workflows, decisions, memory, reviews, or orchestration, load:

```text
README.md
AGENT_HARMES_RUNBOOK.md
docs/orchestration_map.md
workflows/task-state-machine.md
workflows/agent-handoff-protocol.md
memory/registries/task-registry.md
memory/registries/artifact-registry.md
memory/registries/decision-registry.md
memory/registries/memory-registry.md
```

## Project Query Examples

Find active projects:

```text
Status starts with active
```

Find projects safe for execution:

```text
Status = active_vertical or active_architecture
AND Core Memory is not empty
```

Find missing roadmap projects:

```text
Status = missing
```

## Gaps

- Only one domain vertical has real project memory: TNPA Trading OS.
- Roadmap projects are indexed as candidates, not executable projects.
- No project onboarding template exists yet.
