# Coding Prompt Branch

Use this when the detected intent is **Code**. The techniques here are
common practitioner methods, described in this skill's own words and
organized by the job at hand; further learning at the end.

Coding prompts fail in a specific way: the person knows the language, the
codebase, the bug, and the expected behavior — and types almost none of it.
The model then guesses, and the guess is generic. Sharpening a coding prompt
is mostly about surfacing that hidden context.

## First, identify the coding sub-intent

| Sub-intent | The person wants... |
|---|---|
| Write | New code from a description. |
| Explain | Plain-language walkthrough of existing code. |
| Translate | Code converted between languages/frameworks. |
| Debug | A specific error or wrong behavior fixed. |
| Review / refactor | Existing code improved against a goal. |
| Blueprint / scaffold | A new feature planned and stubbed out. |

## What every sharpened coding prompt includes

- **Language and version** — plus framework/runtime when relevant
  (Python 3.12, React 18, Node 20).
- **The actual code**, fenced, not described — the model can't fix what it
  can't see.
- **Expected vs. actual behavior** for anything that misbehaves, with the
  exact error message and traceback.
- **Concrete input/output examples** — the cheapest way to pin down intent;
  add an edge case if behavior at the boundary matters. *Backfires when:*
  the examples are all happy-path — the model overfits them.
- **Constraints** — libraries allowed/forbidden, style, performance
  targets, patterns to avoid. Anchoring constraints keeps the model from
  "helpfully" introducing incompatible dependencies. *Backfires when:*
  over-constrained — leave room for a genuinely better approach.
- **What "done" looks like** — passes a named test, handles a named edge
  case, matches a signature.

## Techniques by job

### Debugging
- **Frame expected vs. actual first** ("it should X; instead it does Y,
  raising Z") — turns a guess into a diagnosis. The single biggest upgrade
  to any debug prompt.
- **Trace-the-execution**: ask the model to walk the suspect path and state
  variable values at each step — surfaces the hidden wrong assumption.
  *Backfires when:* the function is huge — narrow the region first, or the
  trace gets hallucinated.
- **Invite a wider pass**: "fix this, then flag any other bugs or
  improvements you notice" — debug prompts that invite review routinely
  catch a second bug.
- **Rubber-duck the understanding**: "here's what I think this code does —
  what am I missing?" — lets the model challenge the mental model, which is
  often where the bug lives. *Backfires when:* the model politely agrees;
  pair it with "be blunt about anything wrong in my description."

### Writing new code
- **Role** ("you are a senior {language} developer") when judgment and
  idiom matter; skip it for one-liners.
- **Behavior spec + input/output examples + constraints + done-criteria**
  (the checklist above, in full).
- Always remind the person to **read and test generated code** — plausible
  is not correct.

### Review / refactor
- **Name the goal** — readability, performance, idiomatic style; "refactor
  this" without a goal invites churn, not improvement.
- **Anchor the constraints** — what must not change (API surface, behavior,
  dependencies); ask for the reasoning behind each change.
- **Ask for alternatives** when exploring ("what would an iterative version
  look like?") — good for learning and comparisons. *Backfires when:*
  shipping is the goal; options are a detour.

### Blueprint / scaffold (new features)
- **Blueprint before code**: requirements as bullets + the tech stack +
  "plan the approach and explain the choices before writing anything."
  *Backfires when:* the scaffold locks in architecture prematurely — treat
  the first scaffold as a proposal.
- **Chain the steps**: structure the work as ordered stages ("first the
  data model, then the API route, then the UI") and advance one stage per
  prompt — big single prompts produce vague code. *Backfires when:* the
  task is small; chaining is ceremony.

### Explain / translate
- **Explain**: name the reader ("for a developer new to this codebase"),
  ask for a step-by-step walkthrough, paste the code.
- **Translate**: name source and target precisely (language *and* version/
  framework), require behavior preservation, and ask for target-language
  idioms rather than a literal transliteration.

## Worked example

**Raw prompt:** `fix my python code its not working`

**Sharpened prompt:**

```
You are a senior Python developer.

The function below sums the "amount" column of a monthly-expenses CSV.
Expected: it returns the total for the file. Actual: it raises

  KeyError: 'amount'

on a file that opens fine in a spreadsheet. Here is the code and the first
two lines of the CSV:

{paste the code here}
{paste the CSV header + one data row here}

Walk through how the header row is parsed and what keys the reader actually
produces, then debug what's wrong and explain the fix. After the fix,
review the rest of the function for other bugs or improvements and show the
corrected version. Standard library only — no external dependencies.
```

**What changed and why:**

- Stated expected vs. actual behavior with the real error — the model
  diagnoses instead of guessing.
- Included the *data* alongside the code — for parsing bugs, the input is
  half the evidence (here, a capitalized or padded header is the likely
  culprit the trace will surface).
- Asked the model to trace how the keys are produced — execution-tracing
  finds the wrong assumption rather than patching the symptom.
- Invited a wider review after the fix — routinely catches a second bug.
- Anchored the constraint (standard library) so the fix stays deployable.

## Further learning

- Addy Osmani's one-page reference on prompt techniques for AI code
  assistants — a compact catalog of these patterns.
- The code-prompting section of Google's *Prompt Engineering* whitepaper
  (Lee Boonstra) — write/explain/translate/debug prompting, with the
  standing caveat that generated code must be read and tested.
