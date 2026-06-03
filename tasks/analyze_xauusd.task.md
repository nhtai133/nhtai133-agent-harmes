# Analyze XAUUSD Task

## Goal

Request Agent Harmes to execute a reviewed XAUUSD market-analysis workflow that supports TNPA trading decisions, EA planning, content, or dashboard requirements.

This task should produce decision-support analysis with visible assumptions, source quality, uncertainty, and review status.

## Required Context

- `docs/orchestration_map.md`
- `playbooks/analyze_market.playbook.md`
- `workflows/analyze_market.md`
- `agents/commander.md`
- `agents/planner.md`
- `agents/researcher.md`
- `agents/coder.md`
- `agents/tester.md`
- `agents/reviewer.md`
- `projects/tnpa-trading-os/project_context.md`
- `projects/tnpa-trading-os/project_rules.md`
- `projects/tnpa-trading-os/project_memory.md`

Required user-supplied context:

- Analysis purpose: trading context, EA input, content support, dashboard input, or general market memo.
- Time horizon.
- Required source freshness.
- Decision the analysis should support.
- Any preferred or prohibited sources.

## Expected Deliverables

- Clarified XAUUSD analysis question and decision context.
- Research scope and source criteria.
- Market findings separated into facts, observations, interpretations, assumptions, and open questions.
- Source quality and freshness notes.
- Tester validation notes for citations, timestamps, calculations, and internal consistency when applicable.
- Reviewer acceptance, revision, or escalation recommendation.
- Commander final synthesis with implications, residual risks, and next actions.

## Success Criteria

- The task uses `playbooks/analyze_market.playbook.md` as the associated execution route.
- TNPA Project Memory is loaded before research planning.
- Time horizon and source freshness requirements are explicit.
- Findings do not present market direction as guaranteed.
- Unsupported claims are removed, revised, or labeled as unresolved.
- Reviewer confirms the analysis is decision-ready or identifies required revisions.
- Commander updates Project Memory with validated conclusions, rejected assumptions, or future research needs when applicable.

## Associated Playbook

- `playbooks/analyze_market.playbook.md`

## Review Requirements

- Reviewer must check alignment with `workflows/analyze_market.md`.
- Reviewer must verify that facts, assumptions, interpretations, and uncertainty are separated.
- Reviewer must flag stale data, weak evidence, unsupported conclusions, and direct trading-signal framing.
- Tester findings must be included when citations, timestamps, tables, or calculations are used.
- Commander must escalate if the output could influence live trading or high-impact strategy decisions.
