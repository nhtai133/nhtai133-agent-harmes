# Build EA Workflow

## 1. Objective

Orchestrate the creation or improvement of an Expert Advisor strategy artifact from business intent, market assumptions, and trading requirements into a reviewed, test-ready technical plan or deliverable.

This workflow focuses on coordination, decision gates, validation, and handoffs. It does not define trading algorithm implementation code.

## 2. Trigger Conditions

- A human operator requests a new EA concept, strategy specification, or EA improvement.
- Existing EA requirements are incomplete and need structured planning.
- Market logic, risk rules, or execution behavior require review before implementation.
- A completed EA-related task needs testing, review, or release preparation.
- Prior EA output failed review and requires a recovery cycle.

## 3. Inputs

- Human objective and desired trading outcome.
- Market, symbol, timeframe, and trading session assumptions.
- Strategy concept, indicators, entry logic, exit logic, and risk constraints.
- Account model, position sizing expectations, drawdown limits, and compliance limits.
- Existing EA documents, requirements, backtest notes, or defect reports.
- Required output type: concept brief, technical specification, test plan, review report, or release-ready package.
- Approval constraints from the human operator.

## 4. Outputs

- Clarified EA objective and non-goals.
- Strategy requirements brief.
- Workstream plan and agent assignments.
- Research summary for market context and strategy assumptions.
- Technical specification or implementation brief when approved.
- Test and validation plan.
- Review findings and acceptance recommendation.
- Final Commander synthesis with decisions, risks, and next actions.
- Memory notes for assumptions, rejected options, and lessons learned.

## 5. Required Agents

- **Commander:** Owns objective intake, orchestration, decision gates, final synthesis, and escalation.
- **Planner:** Converts the EA objective into phases, dependencies, milestones, and acceptance criteria.
- **Researcher:** Validates market context, strategy assumptions, platform constraints, and comparable approaches.
- **Coder:** Produces implementation artifacts only after the Commander approves a scoped implementation task.
- **Tester:** Defines and validates backtest, forward-test, regression, and edge-case checks.
- **Reviewer:** Audits requirements, test evidence, risks, and readiness before acceptance.

## 6. Execution Sequence

1. **Objective intake:** Commander captures the EA goal, trading context, expected outcome, constraints, and required deliverable.
2. **Scope classification:** Commander determines whether the request is research, specification, implementation, testing, review, or recovery.
3. **Planning:** Planner creates a workstream plan covering strategy definition, risk rules, platform constraints, validation approach, review gates, and required approvals.
4. **Research:** Researcher verifies market assumptions, time sensitivity, comparable strategy behavior, data needs, and uncertainty.
5. **Requirements synthesis:** Commander merges Planner and Researcher outputs into a clear EA brief with assumptions, acceptance criteria, non-goals, and escalation points.
6. **Human gate:** Commander requests human approval before implementation, high-risk strategy changes, or material risk assumptions.
7. **Execution assignment:** If approved, Commander assigns scoped work to Coder or another specialist with expected outputs and validation criteria.
8. **Validation:** Tester checks the completed work or specification against the acceptance criteria, risk limits, and known failure modes.
9. **Independent review:** Reviewer evaluates the full package for alignment, completeness, evidence quality, and operational risk.
10. **Synthesis:** Commander accepts, requests revision, escalates, or closes the workflow with final outputs and memory updates.

## 7. Quality Checklist

- Objective, target market, timeframe, and success criteria are explicit.
- Risk model, position sizing, drawdown limits, and prohibited behaviors are documented.
- Strategy assumptions are labeled as verified, unverified, or rejected.
- Entry, exit, stop, take-profit, and session rules are unambiguous enough for downstream work.
- Dependencies, data requirements, and platform constraints are visible.
- Validation plan includes normal behavior, edge cases, failure paths, and regression checks.
- Tester findings are resolved or explicitly accepted as residual risk.
- Reviewer gives a clear accept, revise, or escalate recommendation.
- Commander records final decisions and unresolved risks.

## 8. Failure Recovery Process

1. Commander identifies the failed stage: intake, planning, research, execution, testing, review, or approval.
2. Commander freezes downstream work until the failed stage is corrected.
3. Responsible agent produces a correction brief with cause, impact, and proposed fix.
4. Planner updates dependencies, sequence, and acceptance criteria if scope changed.
5. Researcher revalidates affected market or platform assumptions when the failure involves evidence or external conditions.
6. Coder revises only the approved scope when implementation artifacts are involved.
7. Tester reruns targeted validation plus any affected regression checks.
8. Reviewer confirms the recovery addressed the original failure without creating new material risk.
9. Commander records the lesson learned and either resumes execution or escalates to the human operator.

## 9. Git Commit Rules

- Commit only approved workflow, documentation, specification, or implementation artifacts related to the EA task.
- Do not mix unrelated refactors, unrelated documentation, or experimental strategy changes into the same commit.
- Commit after the Commander accepts the reviewed output or after a human-approved checkpoint.
- Commit messages must state the workflow area and outcome, such as `docs: define build EA workflow`.
- Include test or review status in the handoff notes before committing implementation-related work.
- Do not commit generated reports, raw backtest exports, credentials, account data, or broker-specific secrets unless explicitly approved and sanitized.
- If recovery work is required, use a separate commit for the correction when it changes accepted output.
