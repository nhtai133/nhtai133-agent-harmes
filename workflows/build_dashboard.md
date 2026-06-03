# Build Dashboard Workflow

## 1. Objective

Orchestrate the design, planning, construction, validation, and review of an Agent Harmes dashboard or dashboard feature that gives operators clear visibility into objectives, agents, tasks, decisions, risks, and outcomes.

This workflow defines coordination and acceptance expectations only. It does not include interface implementation code.

## 2. Trigger Conditions

- A human operator requests a new dashboard, admin view, status panel, or reporting interface.
- Existing dashboard scope needs clarification before design or implementation.
- Agent activity, task state, memory, project status, or quality signals need operational visibility.
- A dashboard feature is ready for testing, review, or release preparation.
- Dashboard output failed review or usability validation and needs a recovery cycle.

## 3. Inputs

- User objective and target dashboard audience.
- Required decisions the dashboard must support.
- Data sources, entities, states, and update frequency expectations.
- Current project context, agent architecture, task registry assumptions, and memory model assumptions.
- Existing dashboard artifacts, wireframes, issues, or review notes.
- Usability, accessibility, security, privacy, and performance constraints.
- Required output type: product brief, information architecture, design specification, implementation task, test plan, or review report.

## 4. Outputs

- Clarified dashboard objective and operator workflow.
- Dashboard requirements brief.
- Information architecture and view inventory.
- Data dependency and state model summary.
- Prioritized implementation plan or task brief.
- Validation plan covering usability, correctness, responsiveness, and access boundaries.
- Review report with acceptance recommendation.
- Final Commander synthesis with risks, decisions, and next actions.
- Memory updates for dashboard conventions and approved interface decisions.

## 5. Required Agents

- **Commander:** Owns orchestration, prioritization, approvals, final acceptance, and escalation.
- **Planner:** Breaks the dashboard objective into views, data dependencies, milestones, and delivery phases.
- **Researcher:** Gathers product, UX, domain, and technical context needed for informed dashboard decisions.
- **Coder:** Implements approved dashboard tasks only after receiving scoped requirements.
- **Tester:** Validates dashboard behavior, data accuracy, responsiveness, accessibility, and regression risk.
- **Reviewer:** Audits the dashboard against requirements, user goals, quality standards, and operational risk.

## 6. Execution Sequence

1. **Objective intake:** Commander clarifies the dashboard purpose, audience, operating context, and target decisions.
2. **Scope definition:** Commander separates must-have operator workflows from optional reporting or visual polish.
3. **Planning:** Planner defines views, navigation, data needs, dependencies, milestones, and acceptance criteria.
4. **Research:** Researcher validates relevant dashboard patterns, user expectations, data definitions, and risk areas.
5. **Requirements synthesis:** Commander converts planning and research into a dashboard brief with priorities, non-goals, and quality gates.
6. **Human gate:** Commander requests approval for scope, sensitive data exposure, major UX direction, or implementation start.
7. **Execution assignment:** Coder receives scoped tasks with expected states, data contracts, constraints, and validation requirements.
8. **Validation:** Tester verifies functional behavior, data correctness, empty and error states, responsiveness, accessibility, and regressions.
9. **Independent review:** Reviewer checks alignment with the objective, information hierarchy, risk handling, and readiness.
10. **Synthesis:** Commander accepts, requests revision, escalates, or closes the workflow with final decisions and memory updates.

## 7. Quality Checklist

- Dashboard purpose and primary operator decisions are explicit.
- Required views, states, entities, and data freshness expectations are defined.
- Data sources, ownership, privacy limits, and access boundaries are documented.
- Empty, loading, error, stale-data, and permission states are accounted for.
- User workflows are efficient and do not require unnecessary context switching.
- Visual hierarchy supports scanning, comparison, and repeated operational use.
- Validation covers desktop and mobile constraints when applicable.
- Tester findings are resolved or accepted as residual risk.
- Reviewer provides a clear accept, revise, or escalate recommendation.
- Commander records approved dashboard conventions and unresolved risks.

## 8. Failure Recovery Process

1. Commander identifies whether the failure is in scope, data definition, UX, implementation, validation, review, or approval.
2. Commander pauses dependent dashboard work until the failed area is corrected.
3. Planner revises affected workstreams, dependencies, and acceptance criteria.
4. Researcher rechecks user expectations, data assumptions, or technical constraints when needed.
5. Coder revises only the approved failing scope and preserves accepted behavior.
6. Tester reruns targeted checks plus affected regression and responsive checks.
7. Reviewer confirms the recovery resolves the issue and does not weaken dashboard clarity or operational safety.
8. Commander records the decision, updates dashboard memory, and determines whether another iteration is required.

## 9. Git Commit Rules

- Commit dashboard work only after Commander acceptance or a human-approved checkpoint.
- Keep dashboard requirements, design specs, implementation changes, and recovery fixes in coherent commits.
- Do not combine unrelated product areas, unrelated agent specs, or broad styling changes with dashboard workflow work.
- Commit messages must state the workflow area and outcome, such as `docs: define dashboard workflow`.
- Include validation and review status in the handoff notes before committing implementation-related dashboard work.
- Do not commit secrets, private operator data, production exports, or unsanitized logs.
- If a dashboard failure is corrected after review, commit the recovery separately when it changes accepted output.
