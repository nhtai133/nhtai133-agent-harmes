# Agent Harmes Orchestration Map

## Overview

The orchestration map defines how the Commander routes a user goal through Agent Harmes before work is accepted or delivered.

The Commander should not treat a user request as an isolated task. It should connect the request to project memory, select the correct workflow, assign the right specialist agents, review outputs, and preserve useful knowledge for future cycles.

## Core Routing Path

Every user goal should move through four orchestration layers:

1. **Project Memory**
2. **Workflow Library**
3. **Agent Specs**
4. **Review and Delivery**

The Commander owns the full route. Specialist agents operate inside the route defined by the Commander.

## 1. Project Memory

Project Memory provides durable context before planning begins.

The Commander should check project memory to identify:

- Project mission, scope, and goals.
- Approved rules, constraints, and standards.
- Prior decisions and assumptions.
- Known issues, risks, and unresolved questions.
- Lessons learned from earlier workflows.
- Future improvements that may affect the current request.

For TNPA Trading OS work, the Commander should consult:

- `projects/tnpa-trading-os/project_context.md`
- `projects/tnpa-trading-os/project_rules.md`
- `projects/tnpa-trading-os/project_memory.md`

The Commander should use Project Memory to decide whether the user goal is already covered by existing rules, requires clarification, or needs escalation before execution.

## 2. Workflow Library

The Workflow Library defines the repeatable operating path for a type of work.

After checking Project Memory, the Commander should select the workflow that best matches the user goal:

- `workflows/build_ea.md` for Expert Advisor and MT5 EA work.
- `workflows/build_dashboard.md` for dashboard, reporting, and operational visibility work.
- `workflows/create_content.md` for content, documentation, marketing, and communication work.
- `workflows/analyze_market.md` for market research, competitive analysis, trading-market context, and decision support.

The selected workflow should define:

- Objective framing.
- Trigger conditions.
- Required inputs.
- Expected outputs.
- Required agents.
- Execution sequence.
- Quality checklist.
- Failure recovery process.
- Git commit rules.

If no workflow fits the user goal, the Commander should either adapt the closest workflow with explicit assumptions or create a new workflow specification before execution begins.

## 3. Agent Specs

Agent Specs define responsibility boundaries.

The Commander should route work to specialist agents based on the selected workflow and the current stage of execution:

- **Commander:** Frames the objective, selects workflow, assigns agents, manages decision gates, reviews progress, synthesizes delivery, and updates memory.
- **Planner:** Breaks the goal into phases, tasks, dependencies, milestones, acceptance criteria, and handoff points.
- **Researcher:** Verifies facts, gathers evidence, identifies uncertainty, and produces decision-ready research.
- **Coder:** Produces implementation artifacts only after the Commander approves a scoped implementation task.
- **Tester:** Validates outputs against requirements, edge cases, risks, and regression concerns.
- **Reviewer:** Audits completed work for alignment, quality, completeness, risk, and readiness.

The Commander should avoid assigning vague work. Each assignment should include:

- Objective.
- Context from Project Memory.
- Selected workflow stage.
- Expected output.
- Constraints and non-goals.
- Acceptance criteria.
- Escalation conditions.

## 4. Review and Delivery

Review and Delivery is the acceptance layer.

Before delivery, the Commander should ensure:

- The output satisfies the original user goal.
- Required workflow stages were completed or intentionally skipped with justification.
- Specialist outputs were reviewed before acceptance.
- Risks, assumptions, and unresolved questions are visible.
- Any required human approval was obtained.
- Relevant lessons, decisions, and known issues were recorded in Project Memory.

The final delivery should include:

- The accepted output or decision.
- Key assumptions.
- Review status.
- Residual risks or open questions.
- Next actions when needed.

The Commander should not deliver implementation-ready, trading-ready, publishing-ready, or decision-ready output when the review layer has identified unresolved material risk.

## Routing Examples

### Build MT5 EA

User goal: Build or improve an MT5 Expert Advisor for TNPA trading.

Commander route:

1. Check TNPA Project Memory for mission, approved trading rules, risk rules, known EA issues, and open strategy questions.
2. Select `workflows/build_ea.md`.
3. Ask Planner to define EA phases, dependencies, risk gates, acceptance criteria, and required approvals.
4. Ask Researcher to verify market assumptions, platform constraints, and strategy evidence.
5. Synthesize a strategy and implementation brief.
6. Escalate to the human operator before any high-risk strategy change, live-trading decision, or broker-connected automation.
7. Assign Coder only if implementation is approved and scoped.
8. Assign Tester to validate expected behavior, edge cases, backtest assumptions, and regression risk.
9. Assign Reviewer to audit alignment with trading rules, risk controls, evidence, and readiness.
10. Deliver the accepted EA plan, specification, or reviewed artifact.
11. Update Project Memory with lessons, known issues, rejected ideas, and future improvements.

### Build Trading Dashboard

User goal: Build a dashboard for trading operations, EA monitoring, agent status, or decision visibility.

Commander route:

1. Check TNPA Project Memory for dashboard needs, trading metrics, risk visibility requirements, and known monitoring gaps.
2. Select `workflows/build_dashboard.md`.
3. Ask Planner to define views, user workflows, data dependencies, states, milestones, and acceptance criteria.
4. Ask Researcher to validate dashboard patterns, trading-operations context, data definitions, and risk areas.
5. Synthesize dashboard requirements and decision-support priorities.
6. Escalate to the human operator for sensitive data exposure, access boundaries, or major scope decisions.
7. Assign Coder only if implementation is approved and scoped.
8. Assign Tester to validate data accuracy, empty states, error states, responsiveness, accessibility, and regressions.
9. Assign Reviewer to audit operational clarity, alignment, risk handling, and readiness.
10. Deliver the accepted dashboard specification or reviewed artifact.
11. Update Project Memory with approved dashboard conventions, unresolved issues, and future improvements.

### Create Content

User goal: Create documentation, marketing copy, announcements, knowledge-base content, or internal communication.

Commander route:

1. Check Project Memory for approved positioning, prior decisions, style expectations, sensitive topics, and known content issues.
2. Select `workflows/create_content.md`.
3. Ask Planner to define the content workflow, source needs, milestones, review gates, and publication criteria.
4. Ask Researcher to verify facts, claims, audience context, source quality, and uncertainty.
5. Synthesize a content brief with audience, angle, constraints, claims rules, and non-goals.
6. Assign drafting or revision work with clear output expectations.
7. Assign Tester when links, formatting, metadata, or publication constraints must be validated.
8. Assign Reviewer to audit accuracy, tone, alignment, evidence quality, and risk.
9. Deliver the accepted draft, final content package, or publication-ready artifact.
10. Update Project Memory with approved messaging, recurring issues, and future content improvements.

### Analyze Market

User goal: Analyze market conditions, competitors, trends, trading context, audience behavior, or opportunity.

Commander route:

1. Check Project Memory for existing assumptions, prior findings, known uncertainties, source standards, and decision context.
2. Select `workflows/analyze_market.md`.
3. Ask Planner to define research scope, comparison dimensions, source criteria, milestones, and acceptance criteria.
4. Ask Researcher to gather evidence, verify source quality, identify conflicts, and summarize findings.
5. Ask Tester to validate calculations, tables, citations, and reproducibility when applicable.
6. Ask Reviewer to audit evidence quality, reasoning, assumptions, gaps, and decision readiness.
7. Commander synthesizes findings into implications, risks, open questions, and recommended next actions.
8. Escalate when evidence is weak, data is stale, uncertainty is material, or the decision is high impact.
9. Deliver the accepted market analysis or decision-support memo.
10. Update Project Memory with validated conclusions, unresolved uncertainty, rejected assumptions, and follow-up needs.

## Escalation Rules

The Commander should escalate to the human operator when:

- The user goal is ambiguous and assumptions would materially change the outcome.
- Project Memory conflicts with the requested action.
- A workflow requires approval before implementation, publication, live trading, or sensitive data handling.
- Specialist agents disagree on material facts, risk, or readiness.
- The output could affect live capital, account access, customer data, public claims, or irreversible decisions.
- Review identifies unresolved material risk.

## Memory Update Rules

After delivery, the Commander should update memory when the workflow produces:

- Approved rules or standards.
- Rejected assumptions or ideas.
- Known issues.
- Lessons learned.
- Risk exceptions.
- Human approvals.
- Future improvements.

Memory updates should be concise, traceable, and useful for future routing. The Commander should not store secrets, credentials, unsanitized private data, or unsupported claims as confirmed knowledge.
