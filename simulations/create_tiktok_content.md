# Create TikTok Content Simulation

## Goal

Validate how Agent Harmes routes a user request to create TikTok content for TNPA Trading OS through Project Memory, the content workflow, agent specs, review, delivery, and memory update.

The simulation tests orchestration behavior only. It does not create scripts, captions, media assets, or implementation code.

## Commander Actions

- Receive the user goal: create TikTok content related to TNPA trading.
- Load TNPA Project Memory for mission, trading rules, risk constraints, known issues, and future content needs.
- Identify sensitive boundaries:
  - Avoid unsupported trading claims.
  - Do not present analysis as guaranteed results.
  - Do not expose private account data or broker details.
  - Preserve distinction between education, analysis, and advice.
- Select `workflows/create_content.md` as the active workflow.
- Frame the task as content brief creation and review unless the user requests a final content package.
- Assign Planner to define content workflow and review gates.
- Assign Researcher to validate facts, claims, audience context, and source needs.
- Assign Coder only if publication tooling or structured documentation integration is later approved.
- Assign Tester for link, format, metadata, and channel-readiness checks when applicable.
- Assign Reviewer for accuracy, tone, risk, and readiness.
- Synthesize final content orchestration output and update memory with approved messaging or content risks.

## Planner Actions

- Define the content workflow:
  - Audience definition.
  - Channel constraints.
  - Content objective.
  - Claim rules.
  - Drafting and review path.
  - Publication-readiness criteria.
- Identify dependencies:
  - Approved TNPA positioning.
  - Approved trading claims and prohibited claims.
  - Source material for any educational or market statements.
  - Human approval for public-facing claims.
- Define milestones:
  - Content brief.
  - Research and claim validation.
  - Draft or outline readiness.
  - Review and publication readiness.
- Define acceptance criteria for audience fit, clarity, risk handling, and compliance with project rules.

## Researcher Actions

- Check Project Memory for approved TNPA facts, unresolved trading rules, and known issues.
- Validate any proposed claims about:
  - Strategy behavior.
  - XAUUSD or market conditions if referenced.
  - EA performance or risk.
  - Trading education statements.
- Identify unsupported claims that require revision or removal.
- Label content inputs as verified, assumption-based, unresolved, or not suitable for public use.
- Produce a source and claims brief for the Commander.

## Coder Actions

- Do not write implementation code during the simulation.
- Do not build publishing automation, templates, or integrations unless separately approved.
- Identify possible technical handoff needs only if the workflow later requires:
  - Structured content storage.
  - Website publishing.
  - Dashboard content queue integration.
  - Metadata validation.
- Return no-code readiness notes to the Commander.

## Tester Actions

- Define validation checks for TikTok content readiness:
  - Format and length constraints.
  - Link or reference integrity when applicable.
  - Metadata and publication field completeness when applicable.
  - No accidental inclusion of private data.
  - No unsupported claims presented as facts.
- Mark visual, audio, and platform-upload checks as future validation if no media asset is produced.
- Produce a channel-readiness checklist.

## Reviewer Actions

- Audit whether Project Memory and `workflows/create_content.md` were used.
- Check that the content objective, audience, channel, and claim boundaries are clear.
- Review Researcher findings for factual support and uncertainty labels.
- Confirm the content avoids financial advice, guaranteed performance claims, and private data exposure.
- Confirm Tester identified publication-readiness checks without requiring implementation.
- Recommend accept, revise, or escalate.

## Final Deliverable

- TikTok content orchestration validation report.
- Confirmed routing path:
  - Project Memory to `workflows/create_content.md`.
  - Planner for content workflow and acceptance criteria.
  - Researcher for claims and source validation.
  - Coder bypassed unless technical publishing work is approved.
  - Tester for channel-readiness checks.
  - Reviewer for tone, accuracy, risk, and readiness.
- Open decisions:
  - Approved TNPA public positioning.
  - Prohibited trading claims.
  - Whether the content is educational, promotional, or analytical.
  - Human approval process for public-facing trading content.
- Recommended next action: create a TNPA content positioning and claims guide before producing public content at scale.

## Lessons Learned

- Trading content requires claim control because incomplete TNPA rules and risk limits can create misleading public messaging.
- The Commander should separate content strategy from final drafting and publication readiness.
- Researcher and Reviewer roles are critical for preventing unsupported trading claims.
- Coder is usually not required for content unless the task includes publishing systems or structured integrations.
- Project Memory should retain approved content positioning, prohibited claims, and recurring review issues.
