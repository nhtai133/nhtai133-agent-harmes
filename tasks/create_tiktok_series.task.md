# Create TikTok Series Task

## Goal

Request Agent Harmes to execute the orchestration required to plan and review a TikTok content series for TNPA Trading OS.

This task should produce a content-series brief, claims boundaries, review path, and delivery package without creating implementation code.

## Required Context

- `docs/orchestration_map.md`
- `playbooks/create_content.playbook.md`
- `workflows/create_content.md`
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

- Target audience.
- Series objective.
- Number of videos or planned cadence.
- Topic boundaries.
- Tone and positioning expectations.
- Whether the series is educational, promotional, analytical, or internal.
- Approval owner for public-facing content.

## Expected Deliverables

- Clarified content-series objective and audience.
- TikTok series brief with topic structure and boundaries.
- Claims and source-validation brief.
- Planner milestone and review-gate summary.
- Researcher fact, claim, and uncertainty notes.
- Tester channel-readiness checklist for format, metadata, links, and publication constraints when applicable.
- Reviewer acceptance, revision, or escalation recommendation.
- Commander final synthesis with approved direction, open questions, and next actions.

## Success Criteria

- The task uses `playbooks/create_content.playbook.md` as the associated execution route.
- TNPA Project Memory is loaded before content planning.
- Trading claims are verified, removed, or labeled as assumptions.
- The content series does not promise trading results or provide unsupported financial claims.
- Audience, channel, objective, and approval path are explicit.
- Reviewer confirms the series is ready for drafting, revision, publication preparation, or escalation.
- Commander updates Project Memory with approved positioning, prohibited claims, recurring issues, or future content improvements when applicable.

## Associated Playbook

- `playbooks/create_content.playbook.md`

## Review Requirements

- Reviewer must check alignment with `workflows/create_content.md`.
- Reviewer must verify that public-facing trading claims are supported or removed.
- Reviewer must flag financial-advice framing, guaranteed-performance claims, and private data exposure.
- Tester findings must be included for format, metadata, links, or platform-readiness checks when applicable.
- Commander must escalate public-facing sensitive claims or publication approval gaps to the human operator.
