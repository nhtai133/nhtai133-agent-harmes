# Create Content Workflow

## 1. Objective

Orchestrate the creation, review, approval, and publication preparation of business, product, marketing, educational, or internal content for Agent Harmes initiatives.

This workflow focuses on content operations, agent handoffs, quality gates, and recovery. It does not define content-generation implementation code.

## 2. Trigger Conditions

- A human operator requests new content or revision of existing content.
- A project requires supporting documentation, marketing copy, announcement material, or knowledge-base content.
- Research findings need to be converted into decision-ready or audience-ready content.
- Existing content requires accuracy, tone, structure, or compliance review.
- Published or draft content fails review and needs correction.

## 3. Inputs

- Human objective and target audience.
- Content type, channel, format, and length expectations.
- Brand, tone, voice, positioning, and style constraints.
- Source material, research, product facts, decisions, or prior drafts.
- Required claims, prohibited claims, compliance constraints, and citation expectations.
- Deadline, approval owner, and publication destination.
- Required output type: brief, outline, draft, revision, review report, or publication-ready package.

## 4. Outputs

- Clarified content objective and audience definition.
- Content brief with scope, angle, constraints, and success criteria.
- Research brief or source summary when needed.
- Outline, draft, revised draft, or final content package.
- Claims and source notes.
- Review findings and acceptance recommendation.
- Publication readiness checklist.
- Final Commander synthesis with approvals, risks, and next actions.
- Memory updates for positioning, style decisions, and recurring content lessons.

## 5. Required Agents

- **Commander:** Owns content objective, orchestration, approvals, final synthesis, and escalation.
- **Planner:** Defines content workflow, milestones, dependencies, and acceptance criteria.
- **Researcher:** Verifies source material, facts, market context, audience context, and claims.
- **Coder:** Used only when content requires approved technical publishing changes or structured documentation integration.
- **Tester:** Validates links, formatting, publication constraints, and required checks when applicable.
- **Reviewer:** Audits accuracy, alignment, tone, completeness, risk, and readiness.

## 6. Execution Sequence

1. **Objective intake:** Commander captures the content goal, audience, channel, format, constraints, and approval path.
2. **Scope classification:** Commander determines whether the task is ideation, research, drafting, editing, review, publishing preparation, or recovery.
3. **Planning:** Planner defines milestones, owners, dependencies, source needs, review gates, and completion criteria.
4. **Research:** Researcher verifies source facts, audience context, claims, competitive context, and uncertainty.
5. **Content brief synthesis:** Commander creates or approves the content brief before drafting begins.
6. **Drafting assignment:** Commander assigns the draft or revision task with audience, angle, structure, claims rules, and expected output.
7. **Validation:** Tester checks formatting, links, metadata, destination requirements, and mechanical constraints when applicable.
8. **Independent review:** Reviewer evaluates the content for objective alignment, accuracy, clarity, tone, evidence quality, and risk.
9. **Revision loop:** Commander routes required changes to the responsible agent and limits revisions to the approved scope.
10. **Final synthesis:** Commander accepts, escalates, or closes with publication readiness notes and memory updates.

## 7. Quality Checklist

- Objective, audience, channel, format, and success criteria are explicit.
- Content brief defines angle, scope, non-goals, and approval owner.
- Important claims are supported by reliable source material or labeled as assumptions.
- Tone and structure match the intended audience and channel.
- Content is concise, coherent, and decision-ready or publication-ready.
- Prohibited claims, sensitive topics, and compliance limits are respected.
- Links, references, formatting, and metadata are checked when applicable.
- Reviewer provides a clear accept, revise, or escalate recommendation.
- Commander records final approvals, positioning decisions, and unresolved risks.

## 8. Failure Recovery Process

1. Commander identifies whether the failure is factual, strategic, tonal, structural, formatting-related, approval-related, or publication-related.
2. Commander pauses publication or downstream use until the issue is corrected.
3. Researcher revalidates affected claims, sources, or market context when accuracy is involved.
4. Planner updates milestones and dependencies if the content scope or deadline changes.
5. Responsible drafting agent revises only the failing sections or approved scope.
6. Tester rechecks formatting, links, metadata, and channel constraints when applicable.
7. Reviewer confirms the correction resolves the issue and does not introduce new risk.
8. Commander records the lesson learned and determines whether human approval is required before release.

## 9. Git Commit Rules

- Commit content work only after Commander acceptance or a human-approved content checkpoint.
- Keep content drafts, revisions, source notes, and publication metadata changes grouped by content asset.
- Do not mix unrelated content assets, unrelated documentation, or implementation changes into the same commit.
- Commit messages must state the workflow area and outcome, such as `docs: define content workflow`.
- Include review and approval status in the handoff notes for publication-ready content.
- Do not commit private source material, unreleased sensitive information, credentials, or unsanitized customer data.
- If content is corrected after review or publication preparation, use a separate recovery commit when it changes accepted output.
