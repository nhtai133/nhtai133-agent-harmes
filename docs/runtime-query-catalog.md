# Runtime Query Catalog

## Purpose

This catalog defines repeatable query patterns for future autonomous execution using the runtime-lite registries.

Primary registries:

- `memory/registries/task-registry.md`
- `memory/registries/artifact-registry.md`
- `memory/registries/decision-registry.md`
- `memory/registries/memory-registry.md`
- `projects/project-registry.md`

Supporting models:

- `workflows/task-state-machine.md`
- `workflows/agent-handoff-protocol.md`
- `docs/artifact-registry.md`
- `memory/decision-log/README.md`
- `memory/memory-update-rules.md`

## Query Pattern Format

Use this structure for runtime-lite queries:

```text
Query:
Registry:
Filter:
Return:
Purpose:
```

## Task Queries

### Active Task Query

```text
Query: List active executable tasks.
Registry: memory/registries/task-registry.md
Filter: Current State not in closed, template, accepted, archived
Return: Task ID, Project ID, Current State, Owner, Next Action
Purpose: Commander determines what work needs attention.
```

### Task By Project Query

```text
Query: List all tasks for a project.
Registry: memory/registries/task-registry.md
Filter: Project ID = <project_id>
Return: Task ID, Task Kind, Current State, Workflow, Review Status
Purpose: Commander loads project execution history before planning.
```

### Task Route Query

```text
Query: Find task route.
Registry: memory/registries/task-registry.md
Filter: Task ID = <task_id>
Return: Workflow, Playbook, Required Agents, Source Path
Purpose: Commander resumes or audits a task using the selected route.
```

### TASK-0001 Query

```text
Query: Fetch TASK-0001 runtime evidence.
Registry: memory/registries/task-registry.md
Filter: Task ID = TASK-0001-TNPA-Signal-Factory
Return: state, workflow, playbook, linked decisions, linked memory, source folder
Purpose: Prove Sprint 003 validation is represented outside the simulation folder.
```

## Artifact Queries

### Artifacts By Task Query

```text
Query: List artifacts for a task.
Registry: memory/registries/artifact-registry.md
Filter: Task ID = <task_id>
Return: Artifact ID, Path, Type, Owner Agent, Status, Latest Validation Result
Purpose: Reviewer checks whether required evidence exists.
```

### Artifacts Needing Validation Query

```text
Query: List artifacts needing validation.
Registry: memory/registries/artifact-registry.md
Filter: Validation Required = yes AND Latest Validation Result contains pending
Return: Artifact ID, Project ID, Path, Type, Latest Validation Result
Purpose: Tester identifies validation backlog.
```

### Deployed Artifact Query

```text
Query: List deployed artifacts.
Registry: memory/registries/artifact-registry.md
Filter: Status = deployed
Return: Artifact ID, Project ID, Path, Latest Validation Result
Purpose: Commander audits deployment state and follow-up testing.
```

### Artifact Type Query

```text
Query: List artifacts by type.
Registry: memory/registries/artifact-registry.md
Filter: Type = <artifact_type>
Return: Artifact ID, Task ID, Project ID, Path, Status
Purpose: Commander finds specs, reviews, tests, or deployment reports quickly.
```

## Decision Queries

### Human Approval Query

```text
Query: Find decisions requiring human approval.
Registry: memory/registries/decision-registry.md
Filter: Human Approval Required != No
Return: Decision ID, Task ID, Project ID, Selected Option, Human Approval Status, Follow-up Action
Purpose: Commander prevents unsafe progression.
```

### Scope Boundary Query

```text
Query: Find active scope boundaries.
Registry: memory/registries/decision-registry.md
Filter: Decision Type = scope_boundary
Return: Decision ID, Project ID, Selected Option, Follow-up Action
Purpose: Coder and Reviewer avoid crossing prior constraints.
```

### Integration Deferral Query

```text
Query: Confirm whether integration work is allowed.
Registry: memory/registries/decision-registry.md
Filter: Selected Option contains no integrations OR Follow-up Action contains Defer
Return: Decision ID, Selected Option, Follow-up Action
Purpose: Commander blocks premature Telegram, Discord, Notion, or Google Drive work.
```

## Memory Queries

### Project Memory Query

```text
Query: List memory for a project.
Registry: memory/registries/memory-registry.md
Filter: Project ID = <project_id> AND Status = active
Return: Memory ID, Category, Confidence, Summary, Next Review
Purpose: Commander loads durable context before planning.
```

### Risk Boundary Query

```text
Query: Find risk boundaries for a project.
Registry: memory/registries/memory-registry.md
Filter: Project ID = <project_id> AND Category = risk_boundary AND Status = active
Return: Memory ID, Summary, Source Artifact, Next Review
Purpose: Commander and Reviewer enforce safety constraints.
```

### Pending Review Memory Query

```text
Query: Find memory needing review.
Registry: memory/registries/memory-registry.md
Filter: Status = pending_review
Return: Memory ID, Project ID, Category, Summary, Next Review
Purpose: Commander plans validation and cleanup work.
```

## Project Queries

### Active Project Query

```text
Query: List active projects.
Registry: projects/project-registry.md
Filter: Status starts with active
Return: Project ID, Project Name, Primary Folder, Core Memory, Risk Level, Next Action
Purpose: Commander discovers executable project contexts.
```

### Missing Project Query

```text
Query: List roadmap projects that are not executable yet.
Registry: projects/project-registry.md
Filter: Status = missing
Return: Project ID, Project Name, Next Action
Purpose: Commander avoids treating roadmap names as ready projects.
```

### Routing Query

```text
Query: Select routing context for a project.
Registry: projects/project-registry.md
Filter: Project ID = <project_id>
Return: Core Memory, Workflows, Playbooks, Risk Level
Purpose: Commander loads the correct route before task classification.
```

## Autonomous Execution Query Sequence

Future Commander runtime should use this order:

1. Query project by user goal.
2. Query active tasks for that project.
3. Query memory for project risk boundaries and known issues.
4. Query workflow and playbook from task or project registry.
5. Query decisions for scope boundaries and human approvals.
6. Query artifacts required for the current state.
7. Query artifacts needing validation.
8. Query memory update requirements before closure.

## Runtime-Lite Limitations

- These are markdown queries, not executable database queries.
- Tables are queryable by search and future parsers, but not machine-enforced.
- Required fields are not validated automatically.
- State transitions are not enforced.
- Artifact and decision IDs are not reserved automatically.

## Sprint 005 Query Capability Target

Sprint 005 should add:

- Planner execution contract.
- Required-field validation checklist or schema.
- State-transition validation checklist.
- Artifact ID reservation rule.
- Decision and approval conflict check.
- Execution-log registry or task-event log.
