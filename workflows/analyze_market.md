# Analyze Market Workflow

## 1. Objective

Orchestrate market analysis that turns a business question, trading question, product question, or competitive question into decision-ready findings with clear evidence, assumptions, risks, and recommended next actions.

This workflow defines the coordination model for analysis. It does not define data collection scripts, trading algorithms, or implementation code.

## 2. Trigger Conditions

- A human operator requests market research, trend analysis, competitor analysis, or trading-market context.
- A project, EA, dashboard, or content workflow needs validated market assumptions.
- A strategic decision depends on current market conditions, audience behavior, demand, risk, or competition.
- Existing market findings are outdated, contradictory, unsupported, or insufficient for a decision.
- A prior analysis fails review and requires revalidation.

## 3. Inputs

- Human question, decision to support, and required depth.
- Target market, geography, audience, asset class, industry, competitors, or time horizon.
- Existing assumptions, hypotheses, constraints, and prior findings.
- Required source standards, citation expectations, and time sensitivity.
- Available internal context, product facts, trading assumptions, or business objectives.
- Required output type: research brief, market memo, competitor summary, opportunity analysis, risk assessment, or recommendation.

## 4. Outputs

- Clarified market question and decision context.
- Research plan with scope, source strategy, and analysis criteria.
- Market findings with evidence quality labels.
- Competitor, trend, audience, demand, risk, or price-action summary as applicable.
- Assumptions, uncertainties, contradictions, and open questions.
- Decision implications and recommended next actions.
- Review findings and acceptance recommendation.
- Final Commander synthesis with approved conclusions, risks, and memory updates.

## 5. Required Agents

- **Commander:** Owns question framing, orchestration, decision relevance, final synthesis, and escalation.
- **Planner:** Structures the analysis plan, milestones, dependencies, and acceptance criteria.
- **Researcher:** Gathers, verifies, compares, and synthesizes market evidence.
- **Coder:** Used only when approved analysis requires technical integration, dashboard updates, or structured artifact changes.
- **Tester:** Validates calculations, source links, data consistency, and reproducibility when applicable.
- **Reviewer:** Audits evidence quality, reasoning, assumptions, gaps, and decision readiness.

## 6. Execution Sequence

1. **Objective intake:** Commander clarifies the market question, decision context, time horizon, audience, and required output.
2. **Scope definition:** Commander distinguishes confirmed facts needed for a decision from exploratory or optional research.
3. **Planning:** Planner defines research workstreams, source criteria, comparison dimensions, milestones, and acceptance criteria.
4. **Research execution:** Researcher gathers and verifies evidence, labels source quality, identifies conflicts, and summarizes findings.
5. **Analysis synthesis:** Commander converts findings into decision implications, assumptions, risks, and recommended next actions.
6. **Validation:** Tester checks data consistency, cited links, calculations, tables, and reproducibility when applicable.
7. **Independent review:** Reviewer evaluates whether the evidence and reasoning are sufficient for the stated decision.
8. **Revision loop:** Commander assigns targeted follow-up research or corrections when gaps, contradictions, or weak assumptions remain.
9. **Final decision support:** Commander accepts, escalates, or closes with a final market analysis summary and memory updates.

## 7. Quality Checklist

- Market question and decision context are explicit.
- Scope, geography, audience, asset class, industry, or competitor set is defined.
- Source standards and time sensitivity are stated.
- Findings distinguish facts, estimates, assumptions, and opinions.
- Important claims are supported by credible evidence or clearly marked as uncertain.
- Contradictory evidence and data limitations are disclosed.
- Analysis connects findings to practical decision implications.
- Validation covers calculations, links, tables, and source consistency when applicable.
- Reviewer provides a clear accept, revise, or escalate recommendation.
- Commander records approved conclusions, unresolved uncertainty, and follow-up needs.

## 8. Failure Recovery Process

1. Commander identifies whether the failure is caused by scope ambiguity, weak evidence, stale data, flawed reasoning, calculation error, missing context, or review rejection.
2. Commander pauses downstream decisions that depend on the failed analysis.
3. Planner revises the research plan, source criteria, or acceptance criteria when scope or sequencing is the issue.
4. Researcher revalidates affected claims and replaces weak, outdated, or conflicting sources where possible.
5. Tester rechecks calculations, citations, tables, and reproducibility when applicable.
6. Reviewer confirms the corrected analysis is decision-ready or recommends escalation.
7. Commander records the correction, residual uncertainty, and whether the decision can proceed.

## 9. Git Commit Rules

- Commit market analysis artifacts only after Commander acceptance or a human-approved checkpoint.
- Keep research briefs, source notes, analysis documents, and related dashboard or content updates in coherent commits.
- Do not mix unrelated market topics, unrelated workflow changes, or implementation work into the same commit.
- Commit messages must state the workflow area and outcome, such as `docs: define market analysis workflow`.
- Include review status and major source limitations in the handoff notes before committing decision-support analysis.
- Do not commit proprietary market data, credentials, paid-source exports, account information, or unsanitized customer data.
- If analysis is corrected after review, use a separate recovery commit when it changes accepted conclusions.
