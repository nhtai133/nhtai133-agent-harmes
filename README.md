# Agent Harmes

Agent Harmes is an AI CEO system designed to orchestrate multiple specialist AI agents toward clear business objectives. It provides a structured operating model for planning, delegation, execution, review, and continuous improvement across an organization-like agent network.

This repository currently defines the foundation of the system: vision, mission, agent architecture, Commander responsibilities, and the execution workflow. No implementation code is included at this stage.

## Vision

Agent Harmes exists to become a reliable executive intelligence layer for digital organizations. Its long-term vision is to coordinate specialist AI agents with the discipline, judgment, and accountability expected from an effective leadership team.

The system should help transform high-level strategic intent into concrete execution while preserving context, tracking decisions, measuring outcomes, and improving over time.

## Mission

The mission of Agent Harmes is to:

- Convert business goals into executable plans.
- Assign work to specialized AI agents based on role, capability, and context.
- Maintain operational clarity across concurrent initiatives.
- Review outputs for quality, alignment, and risk.
- Create a repeatable execution system that can scale from simple tasks to multi-agent business operations.

## Core Principles

- **Strategic clarity:** Every action should connect to a defined objective.
- **Delegated specialization:** Agents should operate within clear roles and responsibility boundaries.
- **Traceable execution:** Plans, decisions, assignments, and results should be observable.
- **Quality control:** Outputs should be reviewed before they become final decisions or downstream inputs.
- **Human governability:** The system should remain understandable, auditable, and controllable by human operators.

## Agent Architecture

Agent Harmes is organized around a central executive agent called the **Commander**. The Commander coordinates specialist agents that perform focused work across domains such as research, planning, product, engineering, marketing, finance, operations, and quality review.

At a high level, the architecture contains:

- **Commander:** Central orchestration agent responsible for strategy, delegation, prioritization, and review.
- **Specialist agents:** Domain-focused agents that execute assigned work.
- **Shared context layer:** Persistent memory, project state, decisions, constraints, and operating history.
- **Task registry:** Structured record of objectives, tasks, owners, dependencies, status, and outcomes.
- **Review layer:** Quality, risk, consistency, and policy checks before results are accepted.
- **Human control interface:** The point where users define goals, inspect execution, approve major decisions, and override the system.

## Commander Responsibilities

The Commander acts as the AI CEO of the system. It does not perform every task itself. Instead, it frames the objective, chooses the right agents, coordinates execution, and ensures that final outputs meet the mission.

Primary responsibilities include:

- Understand and clarify strategic objectives.
- Break goals into actionable workstreams.
- Select specialist agents for each workstream.
- Define expected outputs, constraints, deadlines, and success criteria.
- Monitor task progress and resolve conflicts.
- Review specialist outputs for alignment and quality.
- Escalate uncertainty, risk, or major decisions to the human operator.
- Preserve decisions and lessons learned for future execution.

See [docs/vision.md](docs/vision.md) and [agents/commander.md](agents/commander.md) for deeper specification.

## Execution Workflow

The first version of Agent Harmes follows a structured execution loop:

1. **Objective intake:** The human operator provides a goal, problem, or strategic direction.
2. **Context assessment:** The Commander identifies available context, missing information, constraints, and risks.
3. **Plan formation:** The Commander decomposes the objective into workstreams and tasks.
4. **Agent assignment:** Specialist agents receive scoped assignments with expected deliverables.
5. **Execution:** Specialist agents perform the work and return outputs.
6. **Review:** The Commander evaluates outputs for accuracy, completeness, alignment, and risk.
7. **Synthesis:** Approved outputs are combined into a final result, decision, plan, or next action.
8. **Memory update:** Important decisions, outcomes, assumptions, and lessons are recorded.
9. **Iteration:** The Commander determines whether the objective is complete or requires another execution cycle.

## Current Scope

This foundation defines the intended operating model only. It does not yet include:

- Runtime implementation.
- Agent APIs.
- Memory storage.
- Task orchestration engine.
- User interface.
- Integration with external tools.

Those elements should be designed and implemented after the architecture and specifications are stable.

