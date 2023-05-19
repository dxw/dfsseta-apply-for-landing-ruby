# ADR 0013: Use a single controller for each stage

## Status
Proposal

## Context
The DfSSETA Apply for Landing application is quite simple, being composed of 7 stages with a linear flow. The controller logic is accordingly simply and could in principal be satisfied by a single Controller.

However, while combining all logic into a single controller would be terse and centralised, it would also arguably be less readable and harder for humans to parse.

## Proposal

One of the chief purposes of the Apply for Landing application is to serve as a reference implementation and basis for comparison for developers buidling their skills in new languages.

Accordingly, simplicity and legibility should be prioritised over terseness: a one-controller-per-stage architecture should be adopted.

## Consequences

There will be one Controller per stage, resulting in readable, readily-understandable code.
