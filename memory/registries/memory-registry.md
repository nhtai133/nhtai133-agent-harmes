# Agent Harmes Memory Registry

## Purpose

This registry indexes durable memory entries and memory candidates from existing repository artifacts.

Schema source:

- `memory/memory-update-rules.md`

The registry does not replace project memory files. It makes memory queryable by project, category, confidence, status, and source task.

## Query Keys

```text
Memory ID
Date
Project ID
Category
Source Task
Source Artifact
Owner
Confidence
Status
Review Cadence
Summary
Next Review
```

## Memory Records

| Memory ID | Date | Project ID | Category | Source Task | Source Artifact | Owner | Confidence | Status | Review Cadence | Summary | Next Review |
| --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- |
| `MEM-TNPA-20260605-001` | 2026-06-05 | `PROJ-TNPA-TRADING-OS` | validation_result | `TASK-0001-TNPA-Signal-Factory` | `simulations/TASK-0001-TNPA-Signal-Factory/retrospective.md` | Commander | reviewed | active | Next execution-framework sprint | Sprint 003 manually validated Sprint 002 framework for a TNPA Signal System lifecycle. | Sprint 004 |
| `MEM-HARMES-20260605-001` | 2026-06-05 | `PROJ-AGENT-HARMES` | future_improvement | `TASK-0002-Runtime-Registry-Audit` | `reviews/sprint_004_runtime_registry_review.md` | Commander | reviewed | active | Sprint planning | Runtime-lite registries now exist, but validation, enforcement, ID reservation, and Planner contract are still missing. | Sprint 005 |
| `MEM-TNPA-V04-20260603-001` | 2026-06-03 | `PROJ-TNPA-TRADING-OS` | deployment_fact | legacy_tnpa_v0_4 | `reviews/exness_mt5_20_3_deployment_report.md` | Tester | confirmed | active | Before operational use | TNPA Telegram Alert EA v0.4 EX5 was deployed to Exness MT5 20.3 Experts folder and matched source EX5 size. | Manual MT5 validation |
| `MEM-TNPA-V04-20260603-002` | 2026-06-03 | `PROJ-TNPA-TRADING-OS` | validation_result | legacy_tnpa_v0_4 | `reviews/tnpa_telegram_alert_ea_compile_report.md` | Tester | confirmed | active | Before source change | TNPA v0.4 compiled with 0 errors and 0 warnings, generated EX5 size 47964 bytes. | Next MQ5 change |
| `MEM-TNPA-V04-20260603-003` | 2026-06-03 | `PROJ-TNPA-TRADING-OS` | risk_boundary | legacy_tnpa_v0_4 | `specs/tnpa_telegram_alert_ea_spec.md` | Reviewer | reviewed | active | Every TNPA EA task | TNPA v0.4 is alert-only and must not place, modify, close, or manage trades. | Next EA implementation request |
| `MEM-TNPA-V04-20260603-004` | 2026-06-03 | `PROJ-TNPA-TRADING-OS` | known_issue | legacy_tnpa_v0_4 | `tests/tnpa_v0_4_signal_validation.md` | Tester | reviewed | pending_review | Before operational use | Manual MT5 signal validation remains pending for startup Telegram, active signal types, duplicate prevention, Donchian context, and alert-only safety. | Manual MT5 validation |
| `MEM-TNPA-SKILL-20260604-001` | 2026-06-04 | `PROJ-TNPA-TRADING-OS` | approved_rule | tnpa_skill_v1 | `skills/trading/tnpa/skill.md` | Commander | reviewed | active | Every TNPA signal task | TNPA Trading Skill v1 defines trend, EMA, RSI, setup, risk, do-not-trade, and output-format rules. | Next TNPA skill revision |
| `MEM-HARMES-AUDIT-20260604-001` | 2026-06-04 | `PROJ-AGENT-HARMES` | known_issue | repository_audit | `reviews/repository_audit.md` | Reviewer | reviewed | active | Sprint planning | Agent Harmes is documentation-led and lacks runtime orchestrator, task registry, validation engine, integrations, dashboard, and API. | Sprint 005 |
| `MEM-HARMES-AUDIT-20260604-002` | 2026-06-04 | `PROJ-AGENT-HARMES` | known_issue | repository_audit | `reviews/repository_audit.md` | Reviewer | reviewed | active | Sprint planning | Empty core files remain in `docs/architecture.md`, `docs/workflows.md`, `memory/context.md`, `memory/lessons_learned.md`, and `workflows/build_project.md`. | Architecture cleanup sprint |

## Existing Memory Sources

| Project ID | Memory Source | Status | Notes |
| --- | --- | --- | --- |
| `PROJ-AGENT-HARMES` | `memory/context.md` | empty | Global context placeholder exists but has no entries. |
| `PROJ-AGENT-HARMES` | `memory/lessons_learned.md` | empty | Global lessons placeholder exists but has no entries. |
| `PROJ-TNPA-TRADING-OS` | `projects/tnpa-trading-os/project_context.md` | active | Mission, scope, and project goals. |
| `PROJ-TNPA-TRADING-OS` | `projects/tnpa-trading-os/project_rules.md` | active | Trading rules, risk rules, and coding standards. |
| `PROJ-TNPA-TRADING-OS` | `projects/tnpa-trading-os/project_memory.md` | active | Lessons learned, known issues, and future improvements. |

## Query Examples

Find active TNPA risk boundaries:

```text
Project ID = PROJ-TNPA-TRADING-OS
Category = risk_boundary
Status = active
```

Find pending manual validation:

```text
Category = known_issue
Status = pending_review
Summary contains Manual MT5 signal validation
```

Find global Agent Harmes runtime gaps:

```text
Project ID = PROJ-AGENT-HARMES
Category = known_issue
Status = active
```

## Gaps

- Memory entries remain markdown records, not enforced structured data.
- Global memory files are still empty.
- Project memory does not yet carry entry-level IDs, confidence labels, or review cadence inline.
- No memory conflict detector exists.
