# Agent Harmes Runbook

## Purpose

This runbook defines the simplest practical way to use Agent Harmes today.

Agent Harmes is currently a documentation-based orchestration system. It does not yet have a runtime engine, agent API, task registry, or automated memory store. Use it as a practical operating method for deciding what context to load, what workflow to follow, what work to send to Codex or ChatGPT, and what needs human review.

## 1. What Agent Harmes Is

Agent Harmes is an AI CEO system for turning a user goal into organized execution.

The central role is the **Commander**. The Commander:

- Understands the goal.
- Loads relevant project memory.
- Chooses the right workflow.
- Creates an execution plan.
- Sends the right tasks to the right tool or agent.
- Reviews outputs before delivery.
- Records lessons and decisions for future use.

Today, Agent Harmes is best used as a disciplined coordination method, not as an autonomous system.

## 2. What User Should Input

The user should give a clear goal plus enough context for the Commander to route the work.

Use this format:

```text
Goal:
What I want built, analyzed, written, or reviewed.

Project:
Which project this belongs to.

Context:
Relevant files, rules, market, audience, platform, constraints, or prior decisions.

Output:
The exact deliverable I want.

Limits:
What should not be done.

Approval:
Anything that needs human approval before execution.
```

Example:

```text
Goal:
Build a simple MT5 EA that sends Telegram alerts when a trading condition appears.

Project:
TNPA Trading OS.

Context:
Use TNPA project memory. No live trading. Alerts only.

Output:
EA specification and implementation plan first.

Limits:
Do not place trades. Do not use broker credentials. Do not optimize strategy.

Approval:
Ask before writing code.
```

## 3. How Commander Classifies The Goal

Commander first classifies the request by work type:

- **Build EA:** MT5 EA, trading automation, strategy-to-EA requirements, backtest planning, alert EA, trade logic.
- **Build Dashboard:** trading dashboard, monitoring view, reporting interface, agent status view.
- **Create Content:** TikTok, documentation, marketing, scripts, posts, announcements, educational content.
- **Analyze Market:** XAUUSD, market conditions, competitor research, trend analysis, trading context.
- **Architecture or Review:** architecture audit, documentation review, workflow review, risk review.

Commander also classifies the requested stage:

- Research.
- Planning.
- Specification.
- Implementation.
- Testing.
- Review.
- Recovery.
- Delivery.

If the goal is ambiguous, Commander should ask for missing information before assigning execution.

## 4. How Commander Chooses A Workflow

Commander chooses the workflow from the current workflow library:

- Use `workflows/build_ea.md` for MT5 EA and trading automation work.
- Use `workflows/build_dashboard.md` for dashboards and operational visibility.
- Use `workflows/create_content.md` for content and communication work.
- Use `workflows/analyze_market.md` for market research and decision support.

For TNPA Trading OS work, Commander should load:

- `projects/tnpa-trading-os/project_context.md`
- `projects/tnpa-trading-os/project_rules.md`
- `projects/tnpa-trading-os/project_memory.md`

Commander should also check `docs/orchestration_map.md` when deciding the route.

## 5. How Commander Creates An Execution Plan

Commander creates a short plan before work begins.

The plan should include:

- Objective.
- Selected workflow.
- Required project memory.
- Required agents or tools.
- Deliverables.
- Review gates.
- Human approval points.
- What will not be done.

Practical plan format:

```text
Objective:

Workflow:

Context to load:

Execution steps:
1.
2.
3.

Codex tasks:

ChatGPT tasks:

Human review required:

Final output:
```

## 6. Which Tasks Go To Codex

Send work to Codex when the task requires repository access, file edits, command execution, or code-level validation.

Use Codex for:

- Creating or editing repo files.
- Reading project files and summarizing repository state.
- Writing specifications into markdown files.
- Implementing approved code changes.
- Running tests, linters, or local commands.
- Inspecting git status, diffs, commits, and branches.
- Verifying file structure and references.

Codex should not start implementation until the Commander has a scoped task and any required human approval.

## 7. Which Tasks Go To ChatGPT

Use ChatGPT when the task is reasoning-heavy, draft-heavy, or does not require direct repository access.

Use ChatGPT for:

- Brainstorming strategy options.
- Drafting content ideas.
- Explaining trading concepts.
- Reviewing a plan at a high level.
- Creating content outlines.
- Comparing possible approaches.
- Rewriting text for tone or clarity.
- General market reasoning when live data is not required.

Use browsing or verified sources when market facts, current prices, current platform rules, or time-sensitive claims matter.

## 8. Which Tasks Require Human Review

Human review is required when the task involves:

- Live trading.
- Broker integration.
- Account credentials or private account data.
- Order placement.
- Risk limit changes.
- Public trading or performance claims.
- Financial advice risk.
- Irreversible publication.
- Major architecture decisions.
- Contradictions between user request and project memory.
- Any unresolved material risk flagged by Tester or Reviewer.

For TNPA Trading OS, human review is required before:

- Turning alerts into trade execution.
- Changing approved risk behavior.
- Treating an experimental setup as an approved trading rule.
- Publishing content that implies performance, profit, or guaranteed results.

## 9. Final Output Format

Commander should deliver the final result in this format:

```text
Result:
What was produced or decided.

Workflow used:
The workflow or playbook followed.

Files changed:
Any repository files created or edited.

Review status:
Accepted, needs revision, blocked, or escalated.

Key assumptions:
Important assumptions used.

Risks:
Known residual risks or open questions.

Next actions:
What should happen next.
```

If files were changed, include exact file paths. If code or commands were run, include the important verification result.

## 10. Example: Build A Simple MT5 Telegram Alert EA

### User Input

```text
Goal:
Build a simple MT5 EA that sends a Telegram alert when a TNPA trading condition appears.

Project:
TNPA Trading OS.

Context:
Use existing TNPA memory. Alert only. No order placement.

Output:
Start with an EA specification, validation plan, and implementation-readiness review.

Limits:
Do not write live-trading logic. Do not place orders. Do not use broker credentials. Do not commit unless asked.

Approval:
Ask before writing implementation code.
```

### Commander Classification

- Work type: Build EA.
- Stage: Specification and validation planning.
- Project: TNPA Trading OS.
- Risk level: Medium, because it touches trading logic, but lower than live trading because alerts do not place orders.
- Human approval needed before implementation.

### Context Loading

Commander loads:

- `docs/orchestration_map.md`
- `workflows/build_ea.md`
- `playbooks/build_mt5_ea.playbook.md`
- `projects/tnpa-trading-os/project_context.md`
- `projects/tnpa-trading-os/project_rules.md`
- `projects/tnpa-trading-os/project_memory.md`
- `agents/commander.md`
- `agents/planner.md`
- `agents/researcher.md`
- `agents/coder.md`
- `agents/tester.md`
- `agents/reviewer.md`

### Execution Plan

1. Commander defines the EA objective: Telegram alerts only, no trading.
2. Planner identifies required inputs:
   - Symbol.
   - Timeframe.
   - TNPA condition.
   - Alert message format.
   - Telegram configuration assumptions.
3. Researcher checks:
   - MT5 Telegram alert options.
   - Any platform constraints.
   - Any missing TNPA rule definitions.
4. Coder does not write code yet. Coder identifies implementation readiness and blockers.
5. Tester defines validation:
   - Alert triggers only when the condition appears.
   - No orders are placed.
   - Duplicate alerts are controlled.
   - Missing Telegram configuration fails safely.
6. Reviewer checks:
   - No live-trading behavior.
   - Risk rules are respected.
   - Missing TNPA condition details are flagged.
7. Commander delivers the specification and asks for approval before implementation.

### Codex Tasks

- Inspect repository files.
- Create or update markdown specifications if requested.
- Later, write EA code only after explicit approval.
- Later, run any available validation commands if the repo supports them.

### ChatGPT Tasks

- Help draft the alert behavior.
- Explain Telegram alert design options.
- Help clarify user-facing alert messages.
- Review the specification for clarity before implementation.

### Human Review Required

Human must approve:

- The exact TNPA condition.
- The symbol and timeframe.
- Telegram setup assumptions.
- Any move from alerts to order placement.
- Any implementation code task.

### Final Output

```text
Result:
Created an MT5 Telegram alert EA specification and validation plan.

Workflow used:
workflows/build_ea.md and playbooks/build_mt5_ea.playbook.md.

Files changed:
List any created or edited files.

Review status:
Ready for human review before implementation.

Key assumptions:
Alert only. No orders. TNPA condition still requires confirmation.

Risks:
Duplicate alerts, missing Telegram configuration, unclear TNPA trigger rule.

Next actions:
Human confirms trigger condition, symbol, timeframe, and approval to implement.
```
