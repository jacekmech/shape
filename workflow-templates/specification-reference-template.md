# Specification Reference Template

Use for either a Product Specification or Technical Specification backed by an existing document. Replace the full authored template with this structure; do not duplicate the source content.

## Header
- **Title:**
- **Type:** Product Specification | Technical Specification
- **Status:** `draft | approved`
- **Date:** `YYYY-MM-DD`

## Source
- **Document:** [Document title](path-relative-to-this-artifact-or-URL)
- **Relevant scope / sections:**
- **Reviewed revision:** immutable URL, commit, document version, or reviewed date if no version is available
- **Access / unresolved gaps:**

## Local Supplements

Include only necessary feature-specific additions absent from the source. Omit this section if unnecessary. For a Product Specification, link to the source's proposed delivery iterations or add `## Proposed Delivery Iterations` locally, covering outcomes, scope, acceptance criteria, and dependencies. Do not add implementation tasks. For a Technical Specification, record repository alignment here if the source does not cover it. Surface conflicts for resolution instead of silently overriding the source.

## Updates

Append-only changes after Shape approval. Only approved updates are effective.

#### Update: <name>
- **Status:** `draft | approved`
- **Date:** `YYYY-MM-DD`

**Context**
- Previous reviewed source revision and reason for change

**Change / decision**
- New source link/revision or local supplement change; affected scope and summary

**Impact**
- Implications for downstream specifications, plans, and implementation

<!-- Usage rules; do not retain this comment in feature artifacts.
Read the source before assessing readiness. A link alone is not sufficient and external approval does not automatically approve the Shape artifact. Preserve the approved baseline; later source revisions belong in Updates. The latest approved source-revision update identifies the effective source. On pickup or downstream use, check the relevant source for drift. Use the approved revision when retrievable; if a mutable source has changed and that revision is unavailable, pause dependent work until reconciled through an approved update. Inaccessible sources remain an explicit gap. Do not silently edit external documents.
-->
