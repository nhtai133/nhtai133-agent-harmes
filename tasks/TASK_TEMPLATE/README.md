# Agent Harmes Task Template

## Purpose

This template defines the minimum task record for executable Agent Harmes work.

Use this template when Commander turns a user goal into a trackable task.

Related documents:

- `workflows/task-state-machine.md`
- `workflows/agent-handoff-protocol.md`
- `docs/artifact-registry.md`
- `memory/memory-update-rules.md`
- `memory/decision-log/README.md`
- `agents/contracts/commander-contract.md`

## Task Record

```text
Task ID:
Task Title:
Created Date:
Project:
Requested By:
Commander:
Current State:
Priority:
Risk Level:
```

## Goal

```text
User Goal:
Commander Interpretation:
Expected Outcome:
Non-goals:
```

## Classification

```text
Work Type:
Execution Stage:
Selected Workflow:
Selected Playbook:
Required Agents:
Human Approval Required:
Approval Reason:
```

## Required Context

```text
Project Memory:
Workflow Files:
Playbook Files:
Agent Contracts:
Prior Specs:
Prior Reviews:
Prior Tests:
Prior Deployments:
```

## Inputs

```text
User Inputs:
Repository Inputs:
External Inputs:
Missing Inputs:
Assumptions:
```

## Deliverables

```text
Expected Artifacts:
Artifact Registry Entries:
Review Artifacts:
Memory Updates:
Final User Output:
```

## Execution Plan

```text
Step 1:
Owner:
State Transition:
Expected Artifact:

Step 2:
Owner:
State Transition:
Expected Artifact:

Step 3:
Owner:
State Transition:
Expected Artifact:
```

## Agent Handoffs

Use `workflows/agent-handoff-protocol.md`.

```text
Handoff ID:
From:
To:
Objective:
Expected Output:
Status:
```

## Acceptance Criteria

```text
Criterion 1:
Criterion 2:
Criterion 3:
```

## Review Requirements

```text
Tester Required:
Reviewer Required:
Human Approval Required:
Approval Gate:
Residual Risk Allowed:
```

## Decisions

Use `memory/decision-log/README.md`.

```text
Decision ID:
Decision Summary:
Decision Status:
Linked Artifact:
```

## Artifacts

Use `docs/artifact-registry.md`.

```text
Artifact ID:
Path:
Type:
Status:
Owner:
Validation:
Review:
```

## Memory Update

Use `memory/memory-update-rules.md`.

```text
Memory Update Required:
Memory Target:
Memory Category:
Memory Summary:
Memory Status:
```

## Closure

```text
Final State:
Delivered:
Memory Updated:
Open Risks:
Recommended Next Task:
Closed Date:
```
