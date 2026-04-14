# Web Form Simulation Update Flow

## Overview

This document presents an interaction-only example of a Shape update flow after the original contact form feature has already been implemented.

It intentionally includes only user-agent interactions. It does not include the actual PRD, Technical Concept, Implementation Plan, code, diffs, or commit output. The purpose is to show how Shape handles late discovery without silently rewriting earlier decisions.

Feature change introduced in this example:
- the contact form already exists and works
- after completion, it becomes clear that users must also be able to attach files
- the change affects requirements, technical design, and remaining implementation work

This example follows the update path only:
- PRD update
- Technical Concept update
- Implementation Plan update
- follow-up implementation for the newly introduced scope

## Simulation

### 1. Discovery After Completion

**User:** We need to revisit the contact form feature we just finished. It turns out users also need to attach files when submitting the form.

**Agent:** Understood. Since the original feature is already implemented, I would treat this as a late change rather than silently reinterpreting the completed work. We should first update the PRD, then the Technical Concept, then bring the Implementation Plan back into an executable state for the missing work.

**User:** Yes, do that.

**Agent:** Before I update the PRD, I need the product boundary for attachments:
- what kinds of files are allowed
- how many files can be uploaded
- size limits
- whether attachments are mandatory or optional
- whether the files should be stored anywhere beyond email delivery

**User:** Attachments are optional. Allow up to three files. Only common document and image formats. Total upload size should be limited. We do not need long-term storage. The files only need to be included with the submitted email.

**Agent:** Good. That means the original requirements changed in a meaningful way. I’d add a PRD update capturing that the form now supports optional attachments, with clear file-type and size constraints, user feedback for invalid files, and explicit confirmation that persistence remains out of scope.

### 2. PRD Update

**User:** What else do you need before updating the PRD?

**Agent:** I want to close the user-facing behavior. When attachments are rejected, do you want the form to block submission until the invalid files are removed, or should it silently skip them?

**User:** Block submission. The user should see why the files are invalid and fix the issue before submitting.

**Agent:** Good. I’d add that to the PRD update as effective behavior. I’d also add acceptance criteria around:
- selecting valid files successfully
- blocking invalid file types
- blocking files over the allowed size limit
- sending valid attachments with the form submission
- keeping the existing non-attachment flow working

**User:** Yes. Mark the PRD update ready.

**Agent:** Good. The requirement-level change is now explicit. The next step is the Technical Concept update so the design matches the new requirement.

### 3. Technical Concept Update

**User:** Continue with the Technical Concept.

**Agent:** This change introduces more than a UI tweak. We now need to define how the frontend submits files, how the backend validates them, and how the mail layer includes them in the outgoing email. I’d add a Technical Concept update covering:
- multipart form submission instead of the previous payload shape
- client-side file validation for quick feedback
- authoritative server-side validation for file count, type, and size
- temporary handling of uploaded files only for the duration of request processing
- attachment mapping from validated upload input into the email send operation

**User:** Keep it simple. I still do not want persistence or background processing.

**Agent:** Agreed. I’d keep the design synchronous and request-scoped. Files would exist only long enough to validate and send the email. I’d also make the error model explicit:
- invalid attachments return validation errors
- oversized or disallowed files are rejected before send
- mail delivery failure still returns a controlled submission failure

**User:** Good.

**Agent:** I need one more design decision. Do you want the backend to reject the whole submission if one attachment is invalid, or accept the message without that file?

**User:** Reject the whole submission. The user should correct the attachments and resubmit.

**Agent:** Good. That keeps the behavior predictable. I’d mark the Technical Concept update ready with multipart submission, request-scoped file handling, authoritative backend validation, and full-request rejection on invalid attachments. The next step is to update the Implementation Plan so the new work is reflected explicitly.

### 4. Implementation Plan Update

**User:** Update the Implementation Plan.

**Agent:** I would apply the ready PRD and Technical Concept updates to the Implementation Plan inline. Since the original implementation was already complete, I would not rewrite closed work. Instead I’d add new open slices for the attachment functionality.

**User:** What slices would you add?

**Agent:** I’d add something like:
- Slice 5: frontend attachment selection and validation feedback
- Slice 6: backend attachment handling and validation
- Slice 7: email attachment delivery and end-to-end verification

**User:** That works.

**Agent:** I’d also refresh the relevant file map to bring the contact form component, submission endpoint, validation layer, and mail integration files back into focus. The next step is to prepare the first new slice rather than trying to fully task all new slices up front.

**User:** Prepare Slice 5.

### 5. Missing Implementation

**Agent:** I’m preparing Slice 5: frontend attachment selection and validation feedback. I’d break it into tasks like:
- add file input support to the contact form
- enforce client-side checks for file count, allowed types, and size limits
- show clear validation feedback for rejected files

**User:** Good. First batch should cover the file input and client-side validation only.

**Agent:** Good boundary. I’ll execute only that batch and return for review.

**User:** I reviewed it. Approved.

**Agent:** I’d mark those tasks done, update the Implementation Plan, and stop at the commit boundary.

**User:** Commit it and continue.

### 6. Backend Follow-Up

**Agent:** I’m preparing Slice 6: backend attachment handling and validation. I’d refine it into:
- accept multipart form submission on the contact endpoint
- validate attachment count, type, and size on the server
- return structured validation errors when attachments are invalid

**User:** Use that breakdown. First batch should cover multipart handling and backend validation.

**Agent:** Good. I’ll implement only that batch and return it for review.

**User:** I reviewed it. Approved.

**Agent:** I’d mark the approved tasks done, update the plan, and stop at the commit boundary before moving on.

**User:** Commit it and continue.

### 7. Email Attachment Delivery

**Agent:** I’m preparing the next slice around attaching the validated files to the outgoing email and verifying the end-to-end behavior. I’d break it into:
- extend the mail service to include validated attachments
- connect the validated upload data to the mail send operation
- verify success and failure behavior across the full submission flow

**User:** First batch: extend the mail service and wire the backend to it.

**Agent:** Good. I’ll execute that batch and return it for review.

**User:** Approved. Also record that attachments remain request-scoped only and are not stored after submission.

**Agent:** I’d record that as an implementation decision, mark the approved tasks done, and stop at the commit boundary.

**User:** Commit it. Then finish the remaining end-to-end checks.

### 8. Completion After Update

**Agent:** The final batch would complete the remaining end-to-end behavior, including the updated success and validation error handling for attachment scenarios, and then return for review.

**User:** I reviewed it. Approved.

**Agent:** I’d mark the remaining tasks complete, validate the new slices, and set the Implementation Plan back to done once the added work is fully integrated. At that point the feature and its later updates are aligned again across requirements, design, and implementation.

## What This Shows About Shape

This example highlights how Shape handles late change after a feature was already finished:
- the new requirement is not silently folded into the old baseline
- PRD and Technical Concept evolve through append-only updates
- the Implementation Plan is updated inline to reflect new execution work
- previously completed work is not rewritten just because new scope appeared later
- the workflow remains explicit about what changed at the requirement level, design level, and implementation level
- execution resumes through new slices, tasks, batches, review, approval, and commit boundaries
- the same person can wear all roles, while the workflow still preserves the role boundaries in the artifact flow
