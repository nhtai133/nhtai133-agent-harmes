# TASK-0001: TNPA Signal Factory Runtime Validation

## Task Record

```text
Task ID: TASK-0001-TNPA-Signal-Factory
Task Title: Validate Execution Framework With TNPA Signal Factory Task
Created Date: 2026-06-05
Project: TNPA Trading OS
Requested By: Human Operator
Commander: Agent Harmes Commander
Current State: closed
Priority: High
Risk Level: Medium
```

## Goal

```text
User Goal:
Validate the Sprint 002 Execution Framework using a real TNPA project task.

Commander Interpretation:
Run a no-code end-to-end simulation showing that Harmes can move a TNPA Signal System task through task state, handoff, artifact, memory, testing, and review contracts.

Expected Outcome:
A complete lifecycle folder with task, research, specification, implementation-readiness, test, review, and retrospective artifacts.

Non-goals:
No production code.
No MT5 EA changes.
No live trading signals.
No broker integration.
No credential handling.
```

## Classification

```text
Work Type: Build EA / TNPA Signal System validation
Execution Stage: Runtime validation simulation
Selected Workflow: workflows/build_ea.md
Selected Playbook: playbooks/build_mt5_ea.playbook.md
Required Agents: Commander, Researcher, Coder, Tester, Reviewer
Human Approval Required: No
Approval Reason: The task creates markdown simulation artifacts only and does not change trading behavior.
```

## Required Context

```text
Project Memory:
projects/tnpa-trading-os/project_context.md
projects/tnpa-trading-os/project_rules.md
projects/tnpa-trading-os/project_memory.md

Workflow Files:
workflows/task-state-machine.md
workflows/agent-handoff-protocol.md
workflows/build_ea.md

Playbook Files:
playbooks/build_mt5_ea.playbook.md

Agent Contracts:
agents/contracts/commander-contract.md
agents/contracts/researcher-contract.md
agents/contracts/coder-contract.md
agents/contracts/tester-contract.md
agents/contracts/reviewer-contract.md

Skill Files:
skills/trading/tnpa/skill.md
skills/trading/tnpa/ema-21-34-89.md
skills/trading/tnpa/rsi-trendline.md
skills/trading/tnpa/trading-range.md
skills/trading/tnpa/risk-management.md

Prior Specs:
specs/tnpa_telegram_alert_ea_spec.md

Prior Reviews:
reviews/tnpa_telegram_alert_ea_code_review.md
reviews/sprint_002_execution_review.md

Prior Tests:
tests/tnpa_v0_4_signal_validation.md
tests/tnpa_telegram_alert_ea_manual_test_plan.md

Prior Deployments:
reviews/exness_mt5_20_3_deployment_report.md
```

## State Transitions

| Step | State | Owner | Artifact |
| --- | --- | --- | --- |
| 1 | `intake` | Commander | `task.md` |
| 2 | `classified` | Commander | `task.md` |
| 3 | `context_loaded` | Commander | `task.md` |
| 4 | `planned` | Commander | `spec.md` |
| 5 | `assigned` | Commander | Handoff records in each artifact |
| 6 | `in_progress` | Researcher | `research.md` |
| 7 | `in_progress` | Coder | `implementation.md` |
| 8 | `testing` | Tester | `test.md` |
| 9 | `review` | Reviewer | `review.md` |
| 10 | `accepted` | Commander | `review.md` |
| 11 | `delivered` | Commander | `retrospective.md` |
| 12 | `memory_update_required` | Commander | `retrospective.md` |
| 13 | `memory_updated` | Commander | Simulated memory record in `retrospective.md` |
| 14 | `closed` | Commander | `retrospective.md` |

## Agent Handoffs

### Handoff 1

```text
Handoff ID: HND-TASK-0001-001
From: Commander
To: Researcher
Current Task State: assigned
Objective: Validate TNPA rules and execution context needed for Signal Factory simulation.
Expected Output: research.md
Status: complete
```

### Handoff 2

```text
Handoff ID: HND-TASK-0001-002
From: Commander
To: Coder
Current Task State: assigned
Objective: Produce implementation-readiness artifact without production code.
Expected Output: implementation.md
Status: complete
```

### Handoff 3

```text
Handoff ID: HND-TASK-0001-003
From: Commander
To: Tester
Current Task State: testing
Objective: Validate that lifecycle artifacts follow Sprint 002 contracts.
Expected Output: test.md
Status: complete
```

### Handoff 4

```text
Handoff ID: HND-TASK-0001-004
From: Commander
To: Reviewer
Current Task State: review
Objective: Audit lifecycle completeness, risks, and readiness.
Expected Output: review.md
Status: complete
```

## Artifact Registry

| Artifact ID | Path | Type | Status | Owner |
| --- | --- | --- | --- | --- |
| ART-TNPA-TASK-20260605-001 | `simulations/TASK-0001-TNPA-Signal-Factory/task.md` | `task` | `accepted` | Commander |
| ART-TNPA-RESEARCH-20260605-001 | `simulations/TASK-0001-TNPA-Signal-Factory/research.md` | `simulation` | `accepted` | Researcher |
| ART-TNPA-SPEC-20260605-001 | `simulations/TASK-0001-TNPA-Signal-Factory/spec.md` | `spec` | `accepted` | Commander |
| ART-TNPA-IMPLEMENTATION-20260605-001 | `simulations/TASK-0001-TNPA-Signal-Factory/implementation.md` | `simulation` | `accepted` | Coder |
| ART-TNPA-TEST-20260605-001 | `simulations/TASK-0001-TNPA-Signal-Factory/test.md` | `test_report` | `accepted` | Tester |
| ART-TNPA-REVIEW-20260605-001 | `simulations/TASK-0001-TNPA-Signal-Factory/review.md` | `architecture_audit` | `accepted` | Reviewer |
| ART-TNPA-RETRO-20260605-001 | `simulations/TASK-0001-TNPA-Signal-Factory/retrospective.md` | `memory_update` | `accepted` | Commander |

## Acceptance Criteria

- Task follows `workflows/task-state-machine.md`.
- Agent handoffs follow `workflows/agent-handoff-protocol.md`.
- Artifacts are listed using `docs/artifact-registry.md`.
- Memory update decision follows `memory/memory-update-rules.md`.
- Researcher, Coder, Tester, and Reviewer outputs follow their contracts.
- No production code is written.
- TNPA skill rules are used without inventing new trading rules.

## Final State

```text
Final State: closed
Delivered: yes
Memory Updated: simulated in retrospective.md
Open Risks: Missing runtime registry and machine-enforced state transitions.
Recommended Next Task: Sprint 004 runtime-lite registry.
Closed Date: 2026-06-05
```
