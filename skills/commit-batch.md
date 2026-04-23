# commit batch

## Purpose
Persist an accepted implementation batch as a clean repository checkpoint after approval so the next batch starts from a clear review boundary.

## When to Use
Use this skill when the user wants to commit a reviewed and explicitly approved batch, preserve the accepted change set as a checkpoint, or clear the way for the next execution batch.

Typical triggers:
- “commit batch”
- “commit the approved changes”
- “create the batch commit”
- “checkpoint this approved batch”
- “persist this reviewed batch”

## Inputs
Expected inputs:
- active feature reference or resolved feature folder
- approved batch changes in the working tree
- confirmation that the batch was explicitly approved

Helpful but optional:
- preferred commit message wording
- the selected tasks covered by the batch
- known files that should be included in the commit

## Preconditions
Before committing a batch:
- resolve the active feature and confirm the approved batch context
- verify the batch was explicitly approved
- verify the working tree changes correspond to the approved batch
- verify the commit boundary is clean enough that the next review can start from a clean diff

This skill should operate only after approval.
If the batch is still awaiting review or approval, redirect to `review batch` instead.

## Behavior
Commit the approved batch as a repository checkpoint.

During commit preparation:
- keep the commit scoped to the approved batch
- prefer a commit message that reflects the accepted batch outcome rather than vague progress wording
- surface any ambiguity if unrelated changes are mixed into the working tree

If unrelated or unapproved changes are present:
- warn clearly
- avoid pretending the commit boundary is clean when it is not
- keep the developer in control of the final commit scope

The responsible role remains the Developer.
The agent may prepare and perform the commit, but should not silently commit unapproved work or hide scope contamination.

## Artifact Rules
This skill may read the Implementation Plan in `03-implementation-plan.md` to confirm which approved tasks the batch covered.

Apply these rules:
- commit follows explicit approval
- approved batches should be committed before the next batch begins
- this skill does not mark tasks done; that belongs to the approval path during `review batch`
- this skill does not reopen or reshape the Implementation Plan

This skill may:
- create a repository commit for the approved batch
- summarize what the commit contains
- highlight any scope contamination risks before committing

This skill must not:
- commit a batch that has not been explicitly approved
- include unrelated changes without surfacing the problem
- start the next batch as part of the same step
- treat commit as approval

## Outputs
This skill should produce:
- a repository commit for the approved batch
- the commit identity or summary
- any warnings about commit-scope ambiguity if relevant
- a clear likely next step

## Completion Signals
This skill is complete when:
- the approved batch is committed as a repository checkpoint
- the commit boundary is clear enough for the next review cycle
- approval and commit were kept as distinct workflow steps
- the next likely workflow action is stated plainly

## Guardrails
- Do not commit work that is still awaiting review or approval
- Do not hide unrelated working tree changes that contaminate the batch boundary
- Do not treat commit as a substitute for review
- Do not begin the next batch before this commit boundary is established
- Do not rewrite workflow state to make an unclean batch look clean
- Do not proceed to the next workflow action without explicit approval

## Likely Next Step
Usually suggest one of:
- `plan slice` if the current slice still has open work that needs refinement
- `implement batch` if prepared tasks remain and the next small batch is already clear
- `finish slice` if all tasks in the slice are now done and committed

Prefer `finish slice` when all tasks for the active slice are approved, committed, and ready for validation.
