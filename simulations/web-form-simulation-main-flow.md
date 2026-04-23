# Web Form Simulation

## Overview

This document presents an interaction-only example of the Shape main flow for delivering a small feature in a Node.js / React application.

It intentionally includes only user-agent interactions. It does not include the actual PRD, Technical Concept, Implementation Plan, code, diffs, or commit output. The purpose is to show how the workflow feels in practice.

Feature used in this example:
- Node.js / React web application
- Public contact form
- User provides name, email, subject, and message
- Backend sends an email to a predefined recipient
- No authentication or authorization
- Validation is required

## Simulation

### 1. PRD

**User:** We need a contact form in the application. A user should fill in their information and message, submit it, and the backend should send an email to a predefined address.

**Agent:** I’ll start with the PRD. Before I narrow this down, do you already have constraints or rough notes beyond that summary?

**User:** Keep it simple. It is a public form. No login. We need validation. The recipient email is predefined on the backend.

**Agent:** Good. I’d shape the PRD around one straightforward flow: the user opens the form, fills the required fields, submits it, and gets a clear success or failure response. I also want to make the main error paths explicit: invalid input, failed submission, and email delivery failure.

**User:** Yes.

**Agent:** I need a few product-level clarifications before I call the PRD ready:
- What fields are required?
- Do we need persistence, admin visibility, or tracking?
- Do we care about anti-spam protections in this feature?

**User:** Required fields are name, email, subject, and message. No persistence, no admin panel, no tracking. Anti-spam is out of scope for now.

**Agent:** That gives a clean boundary. I’d mark authentication, inbox management, persistence, spam protection, analytics, and file attachments as out of scope. I’d also define acceptance criteria around required-field validation, invalid email handling, successful submission feedback, and failure feedback when the backend cannot send the email.

**User:** Makes sense.

**Agent:** Good. The PRD is ready for handoff. The next step is the Technical Concept unless you want to refine requirements further.

**User:** Move to Technical Concept.

### 2. Technical Concept

**User:** Continue.

**Agent:** I’ll keep the design aligned to the feature scope and avoid introducing infrastructure the PRD does not justify. The simplest sound approach is:
- a React form component with client-side validation
- a Node.js backend endpoint for form submission
- server-side validation of the submitted payload
- a small mail-sending service behind the endpoint
- backend-owned configuration for the predefined recipient

**User:** Yes, keep it minimal.

**Agent:** I’d explicitly avoid queues, background jobs, persistence, and any user identity model. For the error model, I’d keep it narrow:
- invalid request data returns a validation error
- mail delivery failure returns a controlled submission failure
- unexpected backend issues return a generic server error

**User:** That sounds right.

**Agent:** I want to confirm two things before I mark the Technical Concept ready:
- frontend validation is for UX, but the backend remains authoritative
- the recipient must not come from the client and must be backend configuration only

**User:** Correct on both points.

**Agent:** Good. That closes the main design decisions. The Technical Concept is ready. The next step is implementation planning.

**User:** Proceed.

### 3. Implementation Plan Initialization

**User:** Start implementation planning.

**Agent:** I’ll create the Implementation Plan from the ready PRD and Technical Concept. I want the slices small enough for focused execution sessions and clean review boundaries. For this feature I’d start with:
- Slice 1: frontend form UI and client validation
- Slice 2: backend submission endpoint and server-side validation
- Slice 3: email integration and submission wiring
- Slice 4: final verification, error-state polish, and completion

**User:** Reasonable.

**Agent:** I’d keep those as initial slices only, starting in `draft`. Tasks should be added when we prepare each slice, rather than planning the entire feature in task detail up front. The next step is to prepare the first unfinished slice and move it to `ready`.

**User:** Prepare the first slice.

### 4. Slice Preparation

**Agent:** I’m preparing Slice 1: frontend form UI and client validation. I’d break it into tasks like:
- create the contact form UI with the required fields
- add client-side required-field and email-format validation
- show inline validation feedback and submission-state messaging

**User:** That is the right breakdown.

**Agent:** I’m keeping submission wiring out of this slice so the frontend work stays reviewable on its own. The slice is still bounded and small enough for a focused execution session. Once you approve this breakdown, Slice 1 moves from `draft` to `ready`. The next step is for you to choose a small execution batch.

**User:** First batch: build the form UI and client validation. Leave submission behavior for later.

**Agent:** Good boundary. I’ll execute only those tasks and then return for review.

### 5. Batch Execution and Review

**User:** Execute the batch.

**Agent:** I’ve implemented the selected frontend tasks and stopped at the review boundary. This batch is now awaiting review and approval.

**User:** I reviewed it. The direction is right, but I want clearer error messages and disabled submit when required fields are empty.

**Agent:** That still fits within the current batch, so I’d adjust it without opening a new batch. After the revision I’d return it for review again.

**User:** After the adjustment, approve it.

**Agent:** Good. I’d mark the corresponding tasks as done in the Implementation Plan, update the relevant working file map if useful, and stop at the commit boundary. The approved task completion also means Slice 1 has now moved to `in progress`, and the Implementation Plan is now `in progress`. The next step is commit before any new batch begins.

**User:** Commit the approved batch and continue.

**Agent:** Done. The batch is committed. Slice 1 is still `in progress` until we explicitly validate and close it through `finish slice`. Once that happens, Slice 1 becomes `done`, and the next step is to pick up the feature in a fresh session and prepare the next slice.

### 6. Next Slice

**User:** Pick up the feature and continue with backend work.

**Agent:** We’re continuing the contact form feature. I’m preparing Slice 2: backend submission endpoint and authoritative validation. I’d refine that slice into:
- add the submission endpoint
- validate the request payload on the server
- return structured success and error responses

**User:** Use that breakdown. First batch should cover the endpoint and validation only.

**Agent:** Good. That keeps the review narrow. I’ll implement only the endpoint and validation, then return for review and approval.

**User:** I reviewed it. Looks fine. Approved.

**Agent:** I’d mark those batch tasks done, update the Implementation Plan, note that Slice 2 is now `in progress`, and stop again at the commit boundary before continuing.

**User:** Commit it. Then continue.

### 7. Email Integration Slice

**Agent:** I’m preparing the next slice around email delivery and end-to-end submission wiring. I’m keeping it separate because mail integration introduces external dependency handling and clearer operational error paths.

**User:** Agreed.

**Agent:** I’d propose tasks such as:
- implement a mail service using the selected backend mail mechanism
- read the predefined recipient from backend configuration
- connect the submission endpoint to the mail service
- map delivery failures to the expected user-facing error path

**User:** First batch: mail service plus backend integration. Frontend submission wiring can wait.

**Agent:** Good boundary. I’ll execute only that backend batch and then return it for review.

**User:** Review result: approved, but please record the implementation decision that the recipient is backend-owned configuration and not request data.

**Agent:** I’d record that in the Implementation Plan as an implementation-time decision, mark the approved tasks done, note that Slice 3 is now `in progress`, and stop at the commit boundary.

**User:** Commit and continue with the final batch.

### 8. Final Batch and Completion

**Agent:** The final batch will connect the frontend submission flow to the backend endpoint, handle loading, success, and error states cleanly, and complete the remaining end-to-end behavior required by the PRD and Technical Concept.

**User:** Execute it.

**Agent:** That batch is implemented. It is now awaiting review. Once you approve it, the next required step is commit before anything else continues.

**User:** I reviewed it. Approved.

**Agent:** I’d mark the remaining tasks complete, refresh the relevant file map if needed, and stop at the commit boundary. The final slice remains `in progress` until we explicitly validate it.

**User:** Commit it and finish the feature.

**Agent:** At this point I’d validate the final slice, move it from `in progress` to `done`, confirm that all earlier slices were also explicitly closed to `done`, set the Implementation Plan status to `done`, and report the feature as implemented. No PRD or Technical Concept updates were needed because the feature was delivered without late requirement or design changes.

## What This Shows About Shape

This example highlights the parts of Shape that are easy to miss in a shorter summary:
- the user and agent do not jump straight from idea to code
- PRD readiness and Technical Concept readiness are explicit handoff points
- the Implementation Plan becomes the live control document for execution
- slices move through `draft -> ready -> in progress -> done`
- slices are prepared before execution, but tasks are refined incrementally
- the developer selects each batch
- the agent executes within batch scope and does not self-approve
- review, approval, and commit are explicit workflow boundaries
- the agent keeps orienting the user toward the next valid step
