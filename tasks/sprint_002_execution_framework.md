# Sprint 002: Execution Framework

## Commander Decision

The single highest-leverage next sprint is to define the execution framework that turns Agent Harmes from a documentation-led orchestration system into a system that can reliably run work toward autonomous execution.

This sprint should not optimize for completeness. It should optimize for future autonomous execution of TNPA Signal Systems.

## 1. Biggest Bottleneck

The biggest bottleneck preventing Harmes from becoming an executable agent system is the absence of an execution-control layer.

Agent Harmes currently has:

- Agent roles.
- Workflows.
- Playbooks.
- Task templates.
- Project memory.
- Reviews.
- TNPA Trading OS implementation artifacts.

But it does not yet have:

- A task lifecycle.
- Task state transitions.
- Assignment records.
- Decision records.
- Approval records.
- Artifact records.
- Memory update records.
- Commander execution log.
- A contract for Codex and ChatGPT handoffs.

Because of this, Harmes can guide a human-assisted workflow, but it cannot independently manage execution. The system has instructions, but not operational state.

For the end goal, "Agent Harmes can independently build TNPA Signal Systems," this is the blocking issue. Harmes must be able to know:

- What task is active.
- Why the task exists.
- Which workflow is selected.
- Which agent owns the current step.
- What artifacts are expected.
- What decisions have been made.
- What approvals are required.
- Whether Tester and Reviewer gates passed.
- What memory should be updated.
- Whether the system can proceed, pause, recover, or escalate.

Without this layer, integrations only create more places to send unstructured work.

## 2. Single Sprint To Execute Next

Execute **Sprint 002: Execution Framework**.

Sprint 002 should create the minimal operating contracts required for Commander to run future TNPA Signal System builds in a controlled, repeatable, reviewable way.

The sprint should produce markdown specifications only. It should not implement runtime code yet.

## 3. Why This Sprint Beats Integrations And More Documentation

### Telegram Integration

Telegram integration is not the bottleneck.

The repository already has Telegram delivery inside the TNPA MT5 EA. Adding Telegram notifications for Agent Harmes would improve communication, but it would not tell Commander what task is active, what state it is in, what approval is missing, or whether a review gate passed.

Telegram before execution state would only broadcast ambiguity faster.

### Discord Integration

Discord integration is also not the bottleneck.

Discord would be useful for team-facing notifications, approval prompts, and execution summaries. But without a task lifecycle and decision model, Discord messages would be informal updates rather than reliable execution events.

The system needs event meaning before it needs more channels.

### Notion Integration

Notion integration is premature.

Notion can store tasks, decisions, and memory, but Harmes has not yet defined the records that should be stored. Connecting Notion before defining the schema would lock weak structure into an external workspace.

The correct order is:

1. Define task, decision, approval, artifact, and memory schemas.
2. Validate them in markdown.
3. Then map them to Notion if useful.

### Additional Documentation

More general documentation is lower leverage than execution-control documentation.

The repository already has enough conceptual documentation to understand Agent Harmes. The next documentation must be operational: records, states, gates, and handoffs that future automation can execute.

Sprint 002 is documentation, but it is not "more docs" for completeness. It is the missing execution contract.

## 4. Sprint Goal

Define the minimum execution framework required for Agent Harmes to independently coordinate future TNPA Signal System builds from user goal to reviewed delivery.

The framework must allow Commander to:

- Create a task record.
- Classify the task.
- Select a workflow or playbook.
- Assign work to specialist agents.
- Track task state.
- Record decisions.
- Record approvals.
- Register artifacts.
- Enforce Tester and Reviewer gates.
- Update memory after delivery.
- Recover from blocked, failed, or rejected work.

## 5. Deliverables

Create the following files:

- `docs/task_lifecycle.md`
- `docs/execution_state_model.md`
- `docs/decision_register.md`
- `docs/approval_policy.md`
- `docs/artifact_registry.md`
- `docs/memory_schema.md`
- `docs/review_schema.md`
- `docs/commander_execution_log.md`
- `docs/codex_chatgpt_handoff.md`
- `prompts/commander_prompt.md`

Update the following files:

- `AGENT_HARMES_RUNBOOK.md`
- `docs/orchestration_map.md`
- `projects/tnpa-trading-os/project_memory.md`

Do not build:

- Runtime code.
- Telegram integration.
- Discord integration.
- Notion integration.
- Google Drive integration.
- Dashboard UI.
- New EA features.

## 6. Required Content By Deliverable

### `docs/task_lifecycle.md`

Define:

- Task intake.
- Classification.
- Context loading.
- Workflow selection.
- Assignment.
- Execution.
- Testing.
- Review.
- Delivery.
- Memory update.
- Closure.
- Recovery.

Required task states:

- `intake`
- `classified`
- `planned`
- `assigned`
- `in_progress`
- `testing`
- `review`
- `approval_required`
- `blocked`
- `revision_required`
- `accepted`
- `delivered`
- `memory_updated`
- `closed`

### `docs/execution_state_model.md`

Define the minimum execution record for one work item:

- Execution ID.
- User goal.
- Project.
- Workflow.
- Playbook.
- Current state.
- Active agent.
- Inputs.
- Outputs.
- Dependencies.
- Required approvals.
- Artifacts.
- Review status.
- Memory update status.
- Next action.

### `docs/decision_register.md`

Define decision record fields:

- Decision ID.
- Date.
- Commander summary.
- Decision type.
- Context.
- Options considered.
- Selected option.
- Rationale.
- Risk.
- Human approval needed.
- Linked task.
- Linked artifacts.

### `docs/approval_policy.md`

Define approval requirements for:

- Live trading.
- Broker integration.
- Order execution.
- Risk rule changes.
- Public trading claims.
- External integrations.
- Credential handling.
- Deployment.
- Commit and push checkpoints.

### `docs/artifact_registry.md`

Define how Harmes tracks outputs:

- Specs.
- Source code.
- Tests.
- Reviews.
- Compile reports.
- Deployment reports.
- Memory updates.
- Prompt files.
- Workflow files.

Each artifact should have:

- Artifact ID.
- Path.
- Type.
- Owner agent.
- Status.
- Linked task.
- Review requirement.
- Latest validation result.

### `docs/memory_schema.md`

Define memory entry fields:

- Memory ID.
- Project.
- Category.
- Date.
- Source.
- Confidence.
- Status.
- Owner.
- Summary.
- Details.
- Linked task.
- Review cadence.

Memory categories:

- Lesson learned.
- Known issue.
- Approved rule.
- Rejected assumption.
- Future improvement.
- Decision summary.
- Validation result.

### `docs/review_schema.md`

Define standard review report fields:

- Review ID.
- Reviewed artifact.
- Reviewer role.
- Requirements checked.
- Pass items.
- Issues.
- Risks.
- Required fixes.
- Approval decision.
- Residual risk.

### `docs/commander_execution_log.md`

Define the execution log format:

- Execution ID.
- Goal.
- Route selected.
- Context loaded.
- Agents invoked.
- Key decisions.
- Artifacts created.
- Tests run.
- Reviews completed.
- Approvals requested.
- Delivery summary.
- Memory updates.

### `docs/codex_chatgpt_handoff.md`

Define what goes to Codex versus ChatGPT:

- Codex tasks.
- ChatGPT tasks.
- Required input format.
- Required output format.
- Handoff boundaries.
- Review expectations.
- When Commander must stop and ask for human approval.

### `prompts/commander_prompt.md`

Define the first usable Commander prompt:

- Role.
- Mission.
- Required context loading.
- Task classification rules.
- Workflow selection rules.
- Agent assignment rules.
- Review gates.
- Escalation rules.
- Memory update rules.
- Final delivery format.

## 7. Acceptance Criteria

Sprint 002 is accepted only if:

- Every deliverable file exists and is non-empty.
- Task lifecycle states are explicitly defined.
- Execution state model can represent a TNPA Signal System build from intake to closure.
- Decision records distinguish Commander decisions from human approvals.
- Approval policy blocks live trading, broker execution, credential handling, and risk changes without human approval.
- Artifact registry can track the existing TNPA v0.4 EA files.
- Memory schema can represent lessons, known issues, approved rules, rejected assumptions, future improvements, decisions, and validation results.
- Review schema can represent design reviews, code reviews, compile reports, deployment reports, and manual validation reports.
- Commander prompt is usable as a prompt-based agent entry point.
- Runbook and orchestration map reference the new execution-control documents.
- TNPA project memory records that v0.4 exists, is alert-only, is deployed to Exness MT5 20.3, and still needs manual signal validation.

## 8. Definition Of Done

Sprint 002 is done when:

- The execution framework documents are created.
- The Commander can take a new goal like "Build TNPA Signal Engine v0.5" and produce a traceable execution record.
- The Commander can identify current state, next state, required agent, required artifact, and required approval for that goal.
- Tester and Reviewer gates are represented as required lifecycle stages.
- Human approval gates are explicit.
- Memory update format is defined.
- Existing TNPA v0.4 artifacts can be registered under the artifact model.
- No integrations or runtime code are introduced prematurely.

## 9. Estimated Impact

Estimated impact: **High**

Expected improvement:

- Moves Agent Harmes from documentation-only orchestration toward executable orchestration.
- Makes future TNPA Signal System builds traceable.
- Reduces Commander ambiguity.
- Creates the foundation for runtime implementation.
- Creates schemas that future integrations can use.
- Prevents premature integration work from locking in weak process.

Roadmap impact:

- Advances Phase 2 from partial to strong.
- Makes Phase 3 implementation feasible.
- Prepares Phase 4 integrations to connect to real execution events later.
- Improves Phase 5 TNPA Trading OS repeatability.

## 10. Future Dependencies

Sprint 002 enables:

- Sprint 003: Runtime-lite task registry.
- Sprint 004: Commander execution simulation using real task records.
- Sprint 005: GitHub integration mapped to task and artifact records.
- Sprint 006: Telegram or Discord notification integration mapped to execution events.
- Sprint 007: Notion or Google Drive sync mapped to memory and artifact schemas.
- Sprint 008: TNPA Signal Engine v0.5 build using the execution framework.

Do not start integration sprints until Sprint 002 creates stable execution records.
