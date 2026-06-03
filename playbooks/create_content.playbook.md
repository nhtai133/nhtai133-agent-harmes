# Create Content Playbook

## Purpose

Provide an executable orchestration path for routing content goals through Agent Harmes from user request to reviewed deliverable and memory update.

This playbook operationalizes:

- `docs/orchestration_map.md`
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

It defines orchestration only. It does not include content-generation implementation code.

## Entry Conditions

Use this playbook when the user goal involves:

- Creating content.
- Revising existing content.
- Producing documentation, marketing copy, social content, announcements, knowledge-base material, or internal communication.
- Converting research or project decisions into audience-ready output.
- Preparing content for review or publication.

Do not proceed directly to publication-ready output when:

- Claims are unsupported.
- Audience, channel, or approval owner is unclear.
- The content includes trading, performance, financial, or public-facing claims that require review.
- The source material includes private data or sensitive project information.

## Context Loading Sequence

1. Load `docs/orchestration_map.md`.
2. Load `workflows/create_content.md`.
3. Load agent specs:
   - `agents/commander.md`
   - `agents/planner.md`
   - `agents/researcher.md`
   - `agents/coder.md`
   - `agents/tester.md`
   - `agents/reviewer.md`
4. Identify content type, audience, channel, tone, length, deadline, source material, and approval path.
5. Identify whether the request is for ideation, brief, outline, draft, revision, review, publication preparation, or recovery.

## Project Memory Loading Sequence

1. Load relevant project memory for the content domain.
2. For TNPA trading content, load:
   - `projects/tnpa-trading-os/project_context.md`
   - `projects/tnpa-trading-os/project_rules.md`
   - `projects/tnpa-trading-os/project_memory.md`
3. Extract approved positioning, known issues, sensitive topics, prohibited claims, and unresolved assumptions.
4. Identify claims that require Researcher validation.
5. Identify memory updates that may be needed after content review.

## Workflow Selection Logic

Select `workflows/create_content.md` when the primary deliverable is a content brief, outline, draft, revision, or publication-ready content package.

Use supporting workflows when needed:

- Use `workflows/analyze_market.md` when market facts, audience context, or competitive claims require validation.
- Use `workflows/build_ea.md` when content depends on EA behavior or trading-system claims.
- Use `workflows/build_dashboard.md` when content describes dashboard features or operational reporting.

If the content includes public trading claims, Commander should require Researcher validation and Reviewer acceptance before delivery.

## Agent Invocation Order

1. **Commander:** Clarify content objective, audience, channel, constraints, source material, and approval requirements.
2. **Planner:** Define content workflow, milestones, dependencies, review gates, and acceptance criteria.
3. **Researcher:** Verify facts, claims, audience context, source quality, and uncertainty.
4. **Commander:** Synthesize a content brief with angle, scope, non-goals, claim rules, and delivery format.
5. **Coder:** Participate only if approved technical publishing, structured documentation, or integration work is required.
6. **Tester:** Validate links, formatting, metadata, channel constraints, and publication readiness when applicable.
7. **Reviewer:** Audit accuracy, alignment, tone, evidence quality, risk, and readiness.
8. **Commander:** Accept, revise, escalate, deliver, and update memory.

## Review Gates

- **Gate 1: Brief readiness.** Commander confirms audience, channel, content type, scope, constraints, and success criteria.
- **Gate 2: Claim readiness.** Researcher confirms important claims are supported, revised, removed, or labeled as assumptions.
- **Gate 3: Draft readiness.** Planner confirms the content structure and output expectations are clear.
- **Gate 4: Publication readiness.** Tester confirms format, links, metadata, and channel requirements where applicable.
- **Gate 5: Acceptance review.** Reviewer gives accept, revise, or escalate recommendation.

## Delivery Criteria

Deliver only when:

- The content objective, audience, channel, and format are clear.
- Required claims are verified or clearly labeled.
- Sensitive or prohibited claims are removed or escalated.
- The output matches the selected workflow stage.
- Tester has completed applicable publication-readiness checks.
- Reviewer has accepted the content or identified only documented residual risk.
- Commander has summarized open questions and next actions.

Do not deliver as publication-ready when factual claims, public trading claims, or approval requirements remain unresolved.

## Memory Update Procedure

After delivery, Commander updates project memory when the workflow produces:

- Approved positioning.
- Approved or prohibited claims.
- Useful source notes.
- Recurring content issues.
- Review lessons.
- Human approvals.
- Future content improvements.

Memory updates should preserve long-term content judgment without storing private source material, sensitive drafts, credentials, or unsupported claims as confirmed facts.

## Escalation Rules

Escalate to the human operator when:

- The audience, channel, or approval owner is unclear and materially affects the output.
- The content includes financial, trading, performance, legal, or sensitive public claims.
- Source evidence is weak, contradictory, or missing.
- The content could expose private project, customer, account, or broker data.
- Reviewer identifies unresolved risk.
- Publication would be irreversible or externally visible.
