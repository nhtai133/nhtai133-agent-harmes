# Agent Harmes Architecture Audit v0.1

## Audit Scope

This audit reviews the current Agent Harmes documentation architecture across:

- `agents/`
- `workflows/`
- `playbooks/`
- `tasks/`
- `projects/`
- `simulations/`
- `docs/`

The audit evaluates the existing architecture only. It does not create a new architecture.

## Executive Summary

Agent Harmes has a coherent orchestration direction: user goals route through Project Memory, Workflow Library, Agent Specs, Review, Delivery, and Memory Update. The current documentation is strong as a conceptual operating model and is beginning to form execution layers through playbooks and tasks.

The system is not yet ready for real execution without human interpretation. The main blockers are missing runtime state definitions, unstructured memory management, empty placeholder docs, duplicated orchestration logic across layers, and unclear boundaries between some agent responsibilities.

## Priority Ranking

| Priority | Finding | Impact |
| --- | --- | --- |
| P0 | No task state, execution state, or decision register exists | Blocks reliable real execution |
| P0 | Memory is freeform and lacks schema, ownership, timestamps, and confidence labels | High risk of stale or conflicting long-term knowledge |
| P1 | Empty placeholder docs exist in core architecture locations | Creates ambiguity and broken documentation expectations |
| P1 | Playbooks duplicate workflow and orchestration-map logic | Increases drift risk as the system scales |
| P1 | Agent responsibility boundaries overlap in review, planning, and synthesis | Can cause duplicated work or unclear authority |
| P1 | Workflows describe ideal paths but lack concrete execution status transitions | Limits automation readiness |
| P2 | TNPA project memory is hardcoded into several playbooks and tasks | Reduces multi-project scalability |
| P2 | Simulations validate happy-path orchestration but do not test failure scenarios deeply | Weakens confidence in recovery behavior |
| P2 | Dashboard workflow exists without matching playbook or task | Leaves a partial vertical slice |

## Findings

### 1. Missing Layers

The architecture has conceptual layers but lacks several execution-control layers needed for real operations:

- No task registry or task state model.
- No decision register for Commander and human approvals.
- No artifact registry for outputs, briefs, reports, or reviewed deliverables.
- No memory update log with timestamp, owner, source, and confidence fields.
- No dependency graph between tasks, playbooks, workflows, and project memory.
- No execution transcript or audit trail format.
- No project onboarding standard for adding new projects beyond TNPA Trading OS.

Existing empty placeholders reinforce this gap:

- `docs/architecture.md` is empty.
- `docs/workflows.md` is empty.
- `workflows/build_project.md` is empty.

### 2. Redundant Documents

There is useful layering, but content is repeated across:

- `docs/orchestration_map.md`
- `workflows/*.md`
- `playbooks/*.playbook.md`
- `tasks/*.task.md`
- `simulations/*.md`

Common repeated material includes:

- Context loading.
- Agent invocation order.
- Escalation rules.
- Memory update rules.
- Review expectations.

The duplication is not yet harmful at small scale, but it creates drift risk. If one layer changes its routing rules or review gates, related playbooks, tasks, and simulations can become inconsistent.

### 3. Circular Dependencies

No direct file-level circular dependency is currently present.

The dominant direction is:

1. `tasks/` reference `playbooks/`, `workflows/`, `agents/`, `projects/`, and `docs/orchestration_map.md`.
2. `playbooks/` reference `docs/orchestration_map.md`, `workflows/`, `agents/`, and `projects/`.
3. `docs/orchestration_map.md` references `workflows/` and `projects/`.
4. `workflows/` reference agent roles conceptually but do not link back to playbooks or tasks.

There is a conceptual loop around memory updates:

- Project Memory informs workflows.
- Workflows generate memory updates.
- Updated memory informs future workflows.

That loop is expected, but it lacks versioning and conflict-handling rules.

### 4. Scalability Risks

The architecture is currently optimized for a small number of documents and one active project.

Scalability risks:

- TNPA Trading OS is referenced directly in all current playbooks and tasks, even when the playbook is otherwise generic.
- Every playbook loads the full agent set, which will become inefficient if more agents are added.
- There is no index or registry for discovering which playbook applies to which task.
- Workflows are markdown-only and do not expose machine-readable metadata.
- Simulations are scenario narratives, not repeatable test cases with pass/fail criteria.
- There is no namespacing convention for future projects, markets, products, or agent variants.

### 5. Memory Management Risks

Project memory is directionally strong but operationally fragile.

Current risks:

- `project_memory.md` combines lessons, known issues, and future improvements without dates, source references, or status.
- Known issues can become stale without an owner or review cadence.
- Future improvements can accumulate indefinitely without prioritization.
- Project rules do not distinguish global rules from TNPA-specific rules in a machine-checkable way.
- Time-sensitive market knowledge has no expiry or freshness requirement in memory storage.
- There is no conflict-resolution rule when memory disagrees with a new user request.
- Memory update procedures exist in orchestration docs, but no concrete update format exists.

### 6. Workflow Gaps

The main workflows are useful and consistent, but gaps remain:

- `workflows/build_project.md` is empty.
- `workflows/build_dashboard.md` has no matching playbook, task, or simulation in the current Task and Playbook layers.
- Workflows describe sequences but not status states such as pending, blocked, in review, accepted, failed, or escalated.
- Failure recovery processes are high level and do not specify required recovery artifacts.
- Git commit rules are present inside workflows, but there is no repo-level commit policy connecting tasks, reviews, and memory updates.
- There is no explicit workflow for maintaining memory itself.
- There is no workflow for architecture changes, even though the repository is currently architecture-first.

### 7. Agent Responsibility Overlaps

The agent specs are clear at a high level, but responsibility overlaps exist:

- Commander and Planner both define execution plans and workstreams.
- Commander and Reviewer both review output alignment and quality.
- Tester and Reviewer both evaluate readiness and risk.
- Researcher and Reviewer both evaluate evidence sufficiency.
- Coder can produce implementation notes, but playbooks also ask Coder for no-code readiness assessments, which is useful but not reflected clearly in the base Coder spec.

These overlaps are manageable while Commander remains the final authority, but real execution would need sharper handoff boundaries.

### 8. Readiness For Real Execution

Current readiness: **conceptual execution ready, operational execution not ready**.

Ready:

- Commander-led routing model.
- Specialist agent role definitions.
- Workflow templates for EA, dashboard, content, and market analysis.
- Playbooks for MT5 EA, content, and market analysis.
- Task templates for new EA, XAUUSD analysis, and TikTok series.
- TNPA project memory foundation.
- Simulations for orchestration validation.

Not ready:

- No live task registry.
- No persistent execution state.
- No standardized review report format.
- No memory write schema.
- No approval record format.
- No artifact lifecycle.
- No automated validation of references or required sections.
- No conflict-resolution mechanism for stale or contradictory memory.

## Risks

### High Risk

- Real execution could become inconsistent because tasks, playbooks, workflows, and simulations repeat similar routing rules.
- Project memory could become unreliable over time because it lacks dates, owners, confidence levels, and source links.
- Commander decisions may be hard to audit because there is no decision register or execution log.
- Empty architecture placeholders may mislead future agents into assuming important specs exist.

### Medium Risk

- Agent overlap may create duplicated work or unclear accountability during review and recovery.
- Dashboard work is underspecified at the playbook and task layers despite having a workflow.
- Failure recovery may be inconsistently applied because recovery artifacts are not standardized.
- TNPA-specific references inside generic playbooks may make future projects harder to add.

### Low Risk

- Current simulations are useful but mostly validate expected routing, not adversarial or failure-heavy cases.
- Git commit rules are distributed across workflows and may drift.
- Markdown-only structure is easy to read but harder to validate automatically.

## Recommendations

### P0 Recommendations

- Define a task state model before attempting real execution.
- Define a decision and approval record format for Commander and human approvals.
- Define a memory entry format with date, source, owner, status, confidence, and review cadence.
- Add a minimal execution log format for objective intake, assignments, outputs, review, delivery, and memory updates.

### P1 Recommendations

- Fill or remove empty placeholder files: `docs/architecture.md`, `docs/workflows.md`, and `workflows/build_project.md`.
- Establish one source of truth for shared orchestration rules, then let playbooks and tasks reference it instead of repeating it.
- Clarify handoff boundaries between Commander, Planner, Tester, and Reviewer.
- Add concrete recovery artifacts to workflows, such as correction brief, retest note, review disposition, and memory update note.
- Add a dashboard playbook and dashboard task if dashboard work remains in scope.

### P2 Recommendations

- Add a lightweight registry or index for workflows, playbooks, tasks, simulations, and projects.
- Add validation checks for required headings and broken references.
- Add negative simulations for missing risk limits, conflicting memory, failed review, stale market data, and unsupported public claims.
- Separate generic playbook logic from TNPA-specific project memory loading where future multi-project use is expected.
- Add periodic memory review guidance so known issues and future improvements do not become stale backlog.

## Final Assessment

Agent Harmes v0.1 has a strong orchestration concept and a useful documentation stack. The current architecture is suitable for planning, simulation, and human-guided execution.

It is not yet ready for reliable real execution because execution state, memory governance, decision records, and artifact lifecycle are not defined. The next highest-value work is not more workflow expansion; it is tightening the control surfaces that make existing workflows auditable, repeatable, and safe to run over time.
