# Agent Harmes Agent Handoff Protocol

## Purpose

The Agent Handoff Protocol defines how Commander assigns work to specialist agents.

The protocol prevents vague delegation, preserves context, and creates a repeatable contract for future autonomous execution.

Related documents:

- `workflows/task-state-machine.md`
- `docs/artifact-registry.md`
- `agents/contracts/commander-contract.md`
- `agents/contracts/researcher-contract.md`
- `agents/contracts/coder-contract.md`
- `agents/contracts/tester-contract.md`
- `agents/contracts/reviewer-contract.md`
- `tasks/TASK_TEMPLATE/README.md`

## Handoff Principles

- Commander owns routing and final accountability.
- Specialist agents own only the assigned scope.
- Every handoff must include context, expected output, constraints, acceptance criteria, and escalation conditions.
- Agents must not expand scope silently.
- Agents must return structured outputs that can be reviewed and registered as artifacts.

## Standard Handoff Record

```text
Handoff ID:
Task ID:
From:
To:
Current Task State:
Objective:
Project:
Workflow:
Playbook:
Required Context:
Inputs:
Expected Output:
Output Artifact Path:
Constraints:
Non-goals:
Acceptance Criteria:
Risks:
Escalation Conditions:
Due Condition:
```

## Commander To Researcher

Use when a task requires evidence, current facts, market context, platform constraints, source validation, or uncertainty analysis.

Required inputs:

- Research question.
- Decision the research supports.
- Source freshness requirement.
- Required source quality.
- Known assumptions.
- Prohibited conclusions.

Researcher output must include:

- Findings.
- Source notes when applicable.
- Evidence quality.
- Uncertainty.
- Contradictions.
- Open questions.
- Recommendation for next research or escalation.

Contract:

- `agents/contracts/researcher-contract.md`

## Commander To Coder

Use only when implementation or repository change is approved and scoped.

Required inputs:

- Approved requirements.
- Files or folders in scope.
- Files or folders out of scope.
- Non-goals.
- Test expectations.
- Review expectations.
- Safety restrictions.

Coder output must include:

- Files changed.
- Behavior changed.
- Assumptions.
- Validation run or not run.
- Known limitations.
- Handoff notes for Tester and Reviewer.

Contract:

- `agents/contracts/coder-contract.md`

## Commander To Tester

Use when an output must be validated against requirements, edge cases, safety rules, or regression risk.

Required inputs:

- Artifact to test.
- Requirements to validate.
- Expected behavior.
- Known risks.
- Environment constraints.
- Pass/fail criteria.

Tester output must include:

- Tests run or defined.
- Results.
- Defects.
- Reproduction steps when applicable.
- Coverage notes.
- Residual risk.
- Recommendation.

Contract:

- `agents/contracts/tester-contract.md`

## Commander To Reviewer

Use when a deliverable needs independent acceptance review.

Required inputs:

- Original objective.
- Relevant task record.
- Artifact under review.
- Tester findings.
- Acceptance criteria.
- Constraints and non-goals.

Reviewer output must include:

- Findings.
- Risks.
- Required fixes.
- Open questions.
- Approval decision.
- Residual risk.

Contract:

- `agents/contracts/reviewer-contract.md`

## Agent Return Format

Every specialist output should use this structure unless a workflow defines a stricter format:

```text
Result:
Artifact:
Evidence or Validation:
Issues:
Risks:
Assumptions:
Recommended Next State:
Memory Update Needed:
```

## Escalation Rules

Agents must escalate to Commander when:

- The assigned scope is impossible.
- Required context is missing.
- Requirements conflict.
- Human approval is required.
- A safety boundary may be crossed.
- The output could affect live trading, credentials, customer data, external publication, or production deployment.

## Handoff Completion

A handoff is complete when:

- The agent returns the expected output.
- The output is linked to the task record.
- Any artifact is registered under `docs/artifact-registry.md`.
- Commander updates the task state using `workflows/task-state-machine.md`.
