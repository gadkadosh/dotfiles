---
name: review-loop
description: Use when the user asks for a review loop
---

# Review Loop

This is a workflow that allows iterating in a loop on an implementation according to the report of an external reviewer.

## Workflow

When done implementing a feature or fix and instructed to make a review loop, launch a separate agent instance and instruct the agent to review the changes only, no modifications. Read the review and decide on the smallest changes justified by the findings. Be careful of feature creep and don't shy away from pushing back. Report your conclusion and recommendation, then wait for approval before making changes or starting another review round.

In a herdr environment launch the review agent on a pane next to the current one.
Outside of herdr stop short, instruct me that herdr is unavailable and wait for other instructions before launching an agent.

## Budget

Run a maximum of 3 rounds.
