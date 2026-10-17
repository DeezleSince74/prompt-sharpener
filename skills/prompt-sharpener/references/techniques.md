# General Prompting Technique Library

The techniques below are widely used, research-documented prompting methods,
described here in this skill's own words and organized around its workflow.
Named techniques are credited to the researchers who introduced them; the
further-learning list at the end points to fuller treatments. Use this file
when the SKILL.md essentials aren't enough — choosing between techniques, or
explaining one in the rationale.

## Contents

1. The core techniques (what to reach for, and when)
2. Few-shot examples
3. System, role, and contextual prompting
4. Reasoning techniques (step-back, chain-of-thought, self-consistency,
   branch-then-commit)
5. Agentic prompts: plan – act – observe
6. Structured output and schemas
7. The best-practice checklist
8. Prompts that will be reused: variants, versioning, retesting
9. Further learning

---

## 1. The core techniques

A prompt sets the model up to produce the right output; the clearer the
setup, the better the prediction. Pick by intent — never apply everything.

| Technique | Best for | One-line summary | Skip when |
|---|---|---|---|
| Zero-shot | Simple, well-understood tasks | Clear instruction + the input, nothing else. | Output shape matters — add an example instead. |
| One-/few-shot | Tasks needing a pattern or format | Show 1–5 worked examples. | The task is trivial; examples just burn tokens. |
| System prompting | Global rules and format | "Return only the ISO date, nothing else." | — |
| Role prompting | Voice or expertise matters | "You are a veteran science editor." | Mechanical tasks; persona adds theater, not quality. |
| Contextual prompting | Background changes the answer | Supply the situation the model can't infer. | Context is irrelevant to the task — noise confuses. |
| Step-back | Generic-feeling or principle-driven work | Broad question first, then the specific ask. | Simple tasks — it doubles the calls. |
| Chain-of-thought | Math, logic, multi-step reasoning | Ask for the reasoning before the answer. | Trivial lookups — longer output, no accuracy gain. |
| Self-consistency | High-stakes answers that flip between runs | Multiple reasoning runs, majority answer. | Cost outweighs the stakes. |

## 2. Few-shot examples

Examples are the strongest steering tool: they *show* the target instead of
describing it. (In-context learning from examples was demonstrated at scale
by Brown et al.'s language-model research.)

- **One-shot:** a single example to imitate; **few-shot:** 3–5 (more for
  complex tasks) — treat ~6 as a tuning starting point, not a law.
- Quality gates: relevant, diverse, error-free. One sloppy example teaches
  the sloppiness.
- Include an edge case when the prompt must survive unusual input.
- For classification, shuffle the class order across examples — otherwise
  the model can learn the sequence instead of the features.

Add an example whenever the output needs a shape prose won't reliably convey
— a JSON layout, a house style, a fixed report format.

## 3. System, role, and contextual prompting

Three overlapping layers; a strong sharpened prompt often uses all three, in
this order: role near the top, context after it, the instruction, then
output rules at the end.

- **System prompting** sets global rules: output format, language, hard
  constraints. Example: "Classify each ticket. Respond with the label only,
  lowercase."
- **Role prompting** fixes tone, depth, and assumed expertise. Example:
  "You are a pediatric nurse writing for first-time parents." Pick 1–2
  style words (direct, warm, formal, playful) rather than stacking many.
- **Contextual prompting** supplies what the model can't infer. Example:
  "Context: this newsletter goes to volunteer coordinators at food banks —
  they have ten minutes and no budget."

## 4. Reasoning techniques

### Step-back prompting
Ask a broader question first, then feed its answer into the specific task —
principles before specifics. (Studied by Zheng et al.) Example: "First,
what makes a market stall memorable to someone walking past? Then design
our farmers-market stall around those principles." Use when direct prompts
come back generic; skip when the task is simple — it costs a second pass.

### Chain-of-thought (CoT)
Ask for intermediate reasoning before the final answer (Wei et al.'s
chain-of-thought research). Markedly better on math, logic, and multi-step
problems, and the reasoning is inspectable.

Placement rules: the **answer comes after the reasoning** (the reasoning
changes what gets predicted next); make the answer separable ("end with
`Answer:` on its own line"); for single-correct-answer tasks, pair with
deterministic sampling (temperature 0) if the person controls API settings.
A worked reasoning example (few-shot CoT) beats the bare "think step by
step" cue.

### Self-consistency
Run the same reasoning prompt several times and take the majority answer
(Wang et al.). Buys reliability with tokens — recommend only when a wrong
answer costs more than the extra runs, e.g. a classification a business
decision hangs on.

### Branch-then-commit
For problems with a wide solution space, have the model propose 2–3
distinct approaches first, evaluate them against stated criteria, then
develop only the winner. A practical, single-prompt cousin of
tree-of-thoughts exploration (Yao et al.). Skip for narrow tasks — options
without a decision rule are just length.

## 5. Agentic prompts: plan – act – observe

For prompts that drive tool use or multi-step autonomous work, structure
the loop explicitly (the reason-then-act pattern studied by Yao et al.):

- **Plan**: state the goal and a short ordered plan before acting.
- **Act**: one step at a time, naming the tool/resource used.
- **Observe**: after each step, check the result against the plan before
  continuing — and revise the plan when observation contradicts it.
- **Stop**: give a stopping condition ("when the test passes", "after at
  most N attempts, report what was tried") so the loop can't run on
  pointlessly. Cap output where the API allows.

When sharpening an agentic prompt, the stopping condition is the piece most
often missing — add it even when everything else is implicit.

## 6. Structured output and schemas

For extract / classify / rank / parse tasks, ask for **JSON** (or another
structured format): consistent shape, machine-readable types, and the
structure itself constrains drift and hallucination.

Go further with a **schema** — for the output (exact target shape: field
names, types, one-line descriptions) and, when feeding structured data in,
for the input too, so the model reads the right fields.

Caveat: JSON spends tokens fast, and truncation produces invalid JSON. For
long structured outputs, note the token limit, or plan a repair step
(JSON-repair libraries exist for exactly this).

## 7. The best-practice checklist

Apply to every rewrite:

- **Provide examples** — the highest-leverage single move.
- **Design simply** — concise, no needless words; if it confuses you, it
  confuses the model. Lead with an action verb: *Analyze, Classify,
  Compare, Draft, Evaluate, Extract, Generate, List, Rank, Rewrite,
  Summarize, Translate, Write.*
- **Be specific about the output** — length, structure, tone, format.
- **Instructions over constraints** — say what to do; keep prohibitions for
  safety, hard formats, and genuinely excluded options. Long don't-lists
  contradict each other.
- **Control length in the prompt** ("about 200 words", "one paragraph")
  whenever length matters.
- **Use `{variables}`** for anything swapped between uses — reusable beats
  one-off.
- **Experiment with framing** — the same goal as an instruction, a
  question, or a statement performs differently; an instruction usually
  wins.
- **Match output format to task** — structured for data tasks, prose for
  prose.

## 8. Prompts that will be reused: variants, versioning, retesting

Most sharpened prompts are one-offs; some become templates or production
prompts. For those, add engineering discipline:

- **Test variants.** Write 2–3 phrasings of the key instruction, run each
  against a handful of real inputs, keep the winner. (Prompt search can be
  automated at scale — Zhou et al.'s automatic-prompt-engineering research
  — but manual A/B over real cases is usually enough.)
- **Version and log.** Keep the prompt in its own file (not buried in
  code), name versions, and record what was tried and how it scored — an
  untracked prompt can't be improved deliberately.
- **Retest on model updates.** New model versions shift behavior; a
  production prompt is retested when the model under it changes.

Skip all of this for one-off prompts — it's overhead without a payoff.

## 9. Further learning

- Google's *Prompt Engineering* whitepaper (Lee Boonstra) — a broad
  practitioner treatment of these techniques and sampling configuration.
- Research origins, for the curious: few-shot in-context learning (Brown et
  al.), chain-of-thought (Wei et al.), self-consistency (Wang et al.),
  step-back (Zheng et al.), tree-of-thoughts and ReAct (Yao et al.),
  automatic prompt engineering (Zhou et al.).
