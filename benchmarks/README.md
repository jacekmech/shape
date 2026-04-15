# Benchmarks

This folder contains lightweight benchmark runs created while testing Shape on a simple feature delivery flow.

The main goal is to validate Shape in practice. Benchmarking is secondary and is used only to capture a practical view of cost, token usage, implementation quality, and workflow fit across different coding tools.

## Scope

The benchmark feature is a web-based contact application built as a full-stack monorepo.

Initial version:
- React frontend
- Node.js API
- Docker Compose runtime
- nginx routing
- contact form submission flow
- no authentication or authorization

Planned update:
- file attachment support added to the contact flow

## Setup

Each benchmark run should start from the same repository state and use the same implementation inputs.

Keep constant:
- same starting commit
- same feature scope
- same `AGENTS.md`
- same Shape artifacts
- same acceptance criteria
- same local development environment

The benchmark is meant to support comparison while testing the same Shape-driven implementation flow.

## Phase 1

Phase 1 is a simple practical comparison.

It uses:
- API-billed usage only
- no subscription-backed usage in measured runs
- no provider-specific cost optimization tricks unless explicitly noted

## Models

The initial benchmark models are:

- OpenAI: `gpt-5.4`
- Anthropic: `Claude Opus 4.6`
- Google: `Gemini 2.5 Pro`

These are treated as the main comparison set for the first Shape benchmark runs.

## What Is Measured

Each run should capture:

- **Cost** — billed API cost
- **Tokens** — total token usage where available
- **Quality** — acceptance criteria met
- **Fit** — implementation stayed aligned with Shape workflow

## Run Log

Each benchmark run should record only the key data points:

- date
- provider
- tool
- model
- feature
- starting commit
- ending commit
- billed cost
- token usage
- acceptance criteria met: yes/no
- Shape fit: yes/no
- notes

## Note

This benchmark is intentionally small.

It exists to help test Shape in a real implementation flow and to give a practical comparison point for coding tools used in that process.