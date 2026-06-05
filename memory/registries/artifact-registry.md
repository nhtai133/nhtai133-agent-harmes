# Agent Harmes Artifact Runtime Registry

## Purpose

This registry indexes current Agent Harmes artifacts as queryable records.

Schema source:

- `docs/artifact-registry.md`

This file is a runtime-lite index only. It does not replace the artifact model.

## Query Keys

```text
Artifact ID
Task ID
Project ID
Path
Type
Owner Agent
Status
Review Required
Validation Required
Latest Validation Result
Approval Required
Memory Update Required
```

## TASK-0001 Artifacts

| Artifact ID | Task ID | Project ID | Path | Type | Owner Agent | Status | Review Required | Validation Required | Latest Validation Result | Memory Update Required |
| --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- |
| `ART-TNPA-TASK-20260605-001` | `TASK-0001-TNPA-Signal-Factory` | `PROJ-TNPA-TRADING-OS` | `simulations/TASK-0001-TNPA-Signal-Factory/task.md` | task | Commander | accepted | yes | yes | pass | yes |
| `ART-TNPA-RESEARCH-20260605-001` | `TASK-0001-TNPA-Signal-Factory` | `PROJ-TNPA-TRADING-OS` | `simulations/TASK-0001-TNPA-Signal-Factory/research.md` | simulation | Researcher | accepted | yes | yes | pass | yes |
| `ART-TNPA-SPEC-20260605-001` | `TASK-0001-TNPA-Signal-Factory` | `PROJ-TNPA-TRADING-OS` | `simulations/TASK-0001-TNPA-Signal-Factory/spec.md` | spec | Commander | accepted | yes | yes | pass | yes |
| `ART-TNPA-IMPLEMENTATION-20260605-001` | `TASK-0001-TNPA-Signal-Factory` | `PROJ-TNPA-TRADING-OS` | `simulations/TASK-0001-TNPA-Signal-Factory/implementation.md` | simulation | Coder | accepted | yes | yes | pass | yes |
| `ART-TNPA-TEST-20260605-001` | `TASK-0001-TNPA-Signal-Factory` | `PROJ-TNPA-TRADING-OS` | `simulations/TASK-0001-TNPA-Signal-Factory/test.md` | test_report | Tester | accepted | yes | yes | pass | yes |
| `ART-TNPA-REVIEW-20260605-001` | `TASK-0001-TNPA-Signal-Factory` | `PROJ-TNPA-TRADING-OS` | `simulations/TASK-0001-TNPA-Signal-Factory/review.md` | architecture_audit | Reviewer | accepted | no | yes | approved_with_residual_risk | yes |
| `ART-TNPA-RETRO-20260605-001` | `TASK-0001-TNPA-Signal-Factory` | `PROJ-TNPA-TRADING-OS` | `simulations/TASK-0001-TNPA-Signal-Factory/retrospective.md` | memory_update | Commander | accepted | yes | yes | simulated_memory_update | yes |

## Sprint 004 Artifacts

| Artifact ID | Task ID | Project ID | Path | Type | Owner Agent | Status | Review Required | Validation Required | Latest Validation Result | Memory Update Required |
| --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- |
| `ART-HARMES-REGISTRY-TASK-20260605-001` | `TASK-0002-Runtime-Registry-Audit` | `PROJ-AGENT-HARMES` | `memory/registries/task-registry.md` | decision_log | Commander | accepted | yes | yes | pass | no |
| `ART-HARMES-REGISTRY-ARTIFACT-20260605-001` | `TASK-0002-Runtime-Registry-Audit` | `PROJ-AGENT-HARMES` | `memory/registries/artifact-registry.md` | decision_log | Commander | accepted | yes | yes | pass | no |
| `ART-HARMES-REGISTRY-DECISION-20260605-001` | `TASK-0002-Runtime-Registry-Audit` | `PROJ-AGENT-HARMES` | `memory/registries/decision-registry.md` | decision_log | Commander | accepted | yes | yes | pass | no |
| `ART-HARMES-REGISTRY-MEMORY-20260605-001` | `TASK-0002-Runtime-Registry-Audit` | `PROJ-AGENT-HARMES` | `memory/registries/memory-registry.md` | memory_update | Commander | accepted | yes | yes | pass | no |
| `ART-HARMES-PROJECT-REGISTRY-20260605-001` | `TASK-0002-Runtime-Registry-Audit` | `PROJ-AGENT-HARMES` | `projects/project-registry.md` | architecture_audit | Commander | accepted | yes | yes | pass | no |
| `ART-HARMES-QUERY-CATALOG-20260605-001` | `TASK-0002-Runtime-Registry-Audit` | `PROJ-AGENT-HARMES` | `docs/runtime-query-catalog.md` | architecture_audit | Commander | accepted | yes | yes | pass | no |
| `ART-HARMES-TASK-0002-20260605-001` | `TASK-0002-Runtime-Registry-Audit` | `PROJ-AGENT-HARMES` | `simulations/TASK-0002-Runtime-Registry-Audit/task.md` | task | Commander | accepted | yes | yes | pass | no |
| `ART-HARMES-RESEARCH-0002-20260605-001` | `TASK-0002-Runtime-Registry-Audit` | `PROJ-AGENT-HARMES` | `simulations/TASK-0002-Runtime-Registry-Audit/research.md` | architecture_audit | Researcher | accepted | yes | yes | pass | no |
| `ART-HARMES-VALIDATION-0002-20260605-001` | `TASK-0002-Runtime-Registry-Audit` | `PROJ-AGENT-HARMES` | `simulations/TASK-0002-Runtime-Registry-Audit/validation.md` | test_report | Tester | accepted | yes | yes | pass | no |
| `ART-HARMES-REVIEW-0002-20260605-001` | `TASK-0002-Runtime-Registry-Audit` | `PROJ-AGENT-HARMES` | `simulations/TASK-0002-Runtime-Registry-Audit/review.md` | architecture_audit | Reviewer | accepted | no | yes | approved_with_residual_risk | no |
| `ART-HARMES-SPRINT-004-REVIEW-20260605-001` | `TASK-0002-Runtime-Registry-Audit` | `PROJ-AGENT-HARMES` | `reviews/sprint_004_runtime_registry_review.md` | architecture_audit | Reviewer | accepted | no | yes | pass | no |

## Existing TNPA v0.4 Artifacts

| Artifact ID | Task ID | Project ID | Path | Type | Owner Agent | Status | Review Required | Validation Required | Latest Validation Result | Memory Update Required |
| --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- |
| `ART-TNPA-SPEC-20260603-001` | legacy_tnpa_v0_4 | `PROJ-TNPA-TRADING-OS` | `specs/tnpa_telegram_alert_ea_spec.md` | spec | Commander | accepted | yes | yes | reviewed | yes |
| `ART-TNPA-SOURCE-20260603-001` | legacy_tnpa_v0_4 | `PROJ-TNPA-TRADING-OS` | `src/TNPA_Telegram_Alert_EA.mq5` | source | Coder | reviewed | yes | yes | compile_pass_0_errors_0_warnings | yes |
| `ART-TNPA-COMPILED-20260603-001` | legacy_tnpa_v0_4 | `PROJ-TNPA-TRADING-OS` | `src/TNPA_Telegram_Alert_EA.ex5` | compiled_output | Coder | deployed | yes | yes | size_47964_bytes | yes |
| `ART-TNPA-CODE-REVIEW-20260603-001` | legacy_tnpa_v0_4 | `PROJ-TNPA-TRADING-OS` | `reviews/tnpa_telegram_alert_ea_code_review.md` | code_review | Reviewer | accepted | no | yes | approved_for_manual_mt5_testing | yes |
| `ART-TNPA-COMPILE-20260603-001` | legacy_tnpa_v0_4 | `PROJ-TNPA-TRADING-OS` | `reviews/tnpa_telegram_alert_ea_compile_report.md` | compile_report | Tester | accepted | no | yes | compile_pass_0_errors_0_warnings | yes |
| `ART-TNPA-DEPLOY-20260603-001` | legacy_tnpa_v0_4 | `PROJ-TNPA-TRADING-OS` | `reviews/exness_mt5_20_3_deployment_report.md` | deployment_report | Tester | accepted | yes | yes | deployment_success | yes |
| `ART-TNPA-TESTPLAN-20260603-001` | legacy_tnpa_v0_4 | `PROJ-TNPA-TRADING-OS` | `tests/tnpa_v0_4_signal_validation.md` | test_plan | Tester | ready_for_test | yes | yes | pending_manual_mt5_validation | yes |
| `ART-TNPA-MANUAL-TESTPLAN-20260603-001` | legacy_tnpa_v0_4 | `PROJ-TNPA-TRADING-OS` | `tests/tnpa_telegram_alert_ea_manual_test_plan.md` | test_plan | Tester | ready_for_test | yes | yes | pending_manual_mt5_validation | yes |

## Framework Artifacts

| Artifact ID | Task ID | Project ID | Path | Type | Owner Agent | Status | Review Required | Validation Required | Latest Validation Result | Memory Update Required |
| --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- |
| `ART-HARMES-STATE-MACHINE-20260604-001` | `SPRINT-002-EXECUTION-FRAMEWORK` | `PROJ-AGENT-HARMES` | `workflows/task-state-machine.md` | workflow | Commander | accepted | yes | yes | validated_by_TASK_0001 | no |
| `ART-HARMES-HANDOFF-20260604-001` | `SPRINT-002-EXECUTION-FRAMEWORK` | `PROJ-AGENT-HARMES` | `workflows/agent-handoff-protocol.md` | workflow | Commander | accepted | yes | yes | validated_by_TASK_0001 | no |
| `ART-HARMES-ARTIFACT-MODEL-20260604-001` | `SPRINT-002-EXECUTION-FRAMEWORK` | `PROJ-AGENT-HARMES` | `docs/artifact-registry.md` | workflow | Commander | accepted | yes | yes | validated_by_TASK_0001 | no |
| `ART-HARMES-MEMORY-RULES-20260604-001` | `SPRINT-002-EXECUTION-FRAMEWORK` | `PROJ-AGENT-HARMES` | `memory/memory-update-rules.md` | workflow | Commander | accepted | yes | yes | validated_by_TASK_0001 | no |
| `ART-HARMES-DECISION-MODEL-20260604-001` | `SPRINT-002-EXECUTION-FRAMEWORK` | `PROJ-AGENT-HARMES` | `memory/decision-log/README.md` | decision_log | Commander | accepted | yes | yes | validated_by_TASK_0001 | no |

## Artifact Query Examples

Find artifacts needing manual MT5 validation:

```text
Project ID = PROJ-TNPA-TRADING-OS
Latest Validation Result = pending_manual_mt5_validation
```

Find accepted TASK-0001 evidence:

```text
Task ID = TASK-0001-TNPA-Signal-Factory
Status = accepted
```

Find deployed artifacts:

```text
Status = deployed
```

## Gaps

- Artifact IDs are manually assigned.
- Binary artifact metadata is limited to repository file path and known review reports.
- No runtime prevents duplicate artifact IDs.
- No checksum registry exists yet.
