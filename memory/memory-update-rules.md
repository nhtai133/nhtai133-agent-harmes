# Agent Harmes Memory Update Rules

## Purpose

Memory Update Rules define when and how Agent Harmes records durable knowledge.

Memory exists to improve future execution. It must not become a dumping ground for raw logs, stale assumptions, secrets, or unsupported claims.

Related documents:

- `docs/artifact-registry.md`
- `memory/decision-log/README.md`
- `workflows/task-state-machine.md`
- `workflows/agent-handoff-protocol.md`
- `projects/tnpa-trading-os/project_memory.md`

## Memory Layers

Agent Harmes uses two memory layers:

1. **Global Memory**
   - `memory/context.md`
   - `memory/lessons_learned.md`

2. **Project Memory**
   - Example: `projects/tnpa-trading-os/project_context.md`
   - Example: `projects/tnpa-trading-os/project_rules.md`
   - Example: `projects/tnpa-trading-os/project_memory.md`

Global memory should store cross-project operating lessons.

Project memory should store project-specific facts, rules, issues, decisions, and improvements.

## Memory Entry Categories

Allowed categories:

- `lesson_learned`
- `known_issue`
- `approved_rule`
- `rejected_assumption`
- `future_improvement`
- `decision_summary`
- `validation_result`
- `deployment_fact`
- `risk_boundary`

## Required Memory Entry Format

```text
Memory ID:
Date:
Project:
Category:
Source Task:
Source Artifact:
Owner:
Confidence:
Status:
Review Cadence:
Summary:
Details:
Next Review:
```

## Confidence Labels

Use one:

- `confirmed`
- `reviewed`
- `working_assumption`
- `unverified`
- `rejected`
- `superseded`

## Status Labels

Use one:

- `active`
- `pending_review`
- `resolved`
- `superseded`
- `archived`

## When Memory Must Be Updated

Commander must update memory when a task produces:

- Approved project rules.
- Confirmed safety boundaries.
- Human approvals.
- Rejected assumptions.
- Known issues.
- Durable lessons.
- Deployment facts.
- Validation results.
- Recurring failure modes.
- Future improvements that change prioritization.

## When Memory Must Not Be Updated

Do not store:

- Credentials.
- API keys.
- Telegram bot tokens.
- Broker passwords.
- Private account exports.
- Unsanitized logs.
- Unsupported market claims as confirmed facts.
- Temporary task chatter.
- Raw compiler logs unless summarized in a review artifact.

## TNPA Trading OS Memory Rules

For TNPA Trading OS, memory must preserve:

- Alert-only versus trade-execution boundaries.
- Approved signal rules.
- Known validation gaps.
- Broker/environment deployment facts.
- Manual testing status.
- Risk restrictions and human approval boundaries.

TNPA memory must not record:

- Broker credentials.
- Telegram tokens.
- Private trading account secrets.
- Unverified strategy performance claims.
- Live-trading approval unless explicitly granted by the human operator.

## Memory Update Procedure

1. Commander identifies whether the completed task created durable knowledge.
2. Commander selects global memory or project memory.
3. Commander writes a concise entry using the required format where practical.
4. Commander links the source task and artifact.
5. Reviewer checks memory updates when they affect safety, risk, or future execution.
6. Commander marks the task state `memory_updated`.

## Memory Conflict Handling

When new work conflicts with memory:

1. Commander pauses execution.
2. Commander identifies the conflicting entries.
3. Commander determines whether the new input is a correction, exception, or unresolved conflict.
4. Human approval is required if the conflict affects risk, trading behavior, credentials, deployment, or public claims.
5. Superseded memory must be marked as superseded instead of silently overwritten.

## Recommended Future Storage

Sprint 002 defines the rules only.

Sprint 003 may add structured memory record files under:

- `memory/records/`
- `projects/<project>/memory/`
