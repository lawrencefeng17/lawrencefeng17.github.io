# Style notes for Lawrence's writing

When drafting or editing prose for this site (blog posts, about pages, etc.), follow these preferences:

## Punctuation
- Prefer **semicolons over em-dashes** when joining two complete clauses.
- Use **em-dashes only** to surround incomplete clauses or parentheticals (e.g., "the whole performance — scratch work and all — becomes more likely").
- Prefer **semicolons over colons**. They are mostly interchangeable, but lean semicolon.

## Voice and tone
- Grounded, intuitive, real; easy-to-understand language.
- Avoid on-the-nose phrasings; prefer concrete, plain wording.
- Comfortable with rhetorical questions, asides, and a slightly playful register.
- See `aboutme.md` for a sample of Lawrence's natural writing style — flowing, comma-heavy sentences; rhetorical questions; parentheses for parentheticals; sparse use of em-dashes and colons.

## Blog posts specifically
- For the RL post (`_posts/2025-12-26-JAN.md`), the organizing lens is **credit assignment** (à la Karpathy's "Pong from Pixels"), not the standard MDP/Bellman textbook framing.
- Variance reduction is a theme but a secondary one; touch on it without making it central.

# Resume / Overleaf sync

The resume (`resume/resume.tex`) syncs with an Overleaf project over git via a
separate clone (default `~/Projects/overleaf-resume`, where the file is `main.tex`).
- `make push` sends local `resume.tex` up to Overleaf; `make pull` brings Overleaf down.
- These overwrite the whole file in one direction — there is no line-level merge.
  Edit in one place at a time, sync, then switch, to avoid divergence.
- See `resume/README.md` for full setup.
