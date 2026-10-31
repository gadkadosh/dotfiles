---
name: review-loop
description: Use when the user asks for a review loop
---

# Review Loop

This is a workflow that allows iterating in a loop on an implementation according to the report of an external reviewer.

## Workflow

When done implementing a feature or fix and instructed to make a review loop, launch a separate review agent. Instruct it to review only and make no modifications. Start the reviewer with a fresh context, without the parent conversation. Provide only a minimal self-contained brief covering the implementation’s purpose, review scope, and relevant constraints. Use a fresh review agent for each review round. Read the review and decide on the smallest changes justified by the findings. Be careful of feature creep and don't shy away from pushing back. Report your conclusion and recommendation, then wait for approval before making changes or starting another review round.

In T3 call `orchestrator_capabilities` before the first delegation. Launch each round with `delegate_task` using `role: "review"` and `isolation: "shared"` so the reviewer sees the current checkout, including uncommitted changes. 
In a herdr environment launch the review agent on a pane next to the current one.
If neither environment is available explain that and wait for instructions before launching a reviewer.

## Budget

Run a maximum of 3 rounds.
