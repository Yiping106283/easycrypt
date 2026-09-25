Companion material for EasyCrypt PR #1105 (change pHL to prevent negative probabilities), 2026-09-10.

downstream_fixes/  one unified diff per CI external project (sha3 `next`, cryptobox `next`,
                   xmss-security `main`/proof, sphincsplus `main`) that makes the project's CI
                   scenario pass with the #1105 binary (head bb75dba5a merged on main 311ba5d17).
                   Verified locally; the only remaining failures are the same SMT flakes that fail
                   on unpatched main.
repro/             the #1102 and #1119 reproducers as filed; both still compile (prove `false`)
                   with the #1105 binary.

downstream_fixes_rnd_pr/  the script changes the same three projects need for the per-tactic `rnd`
                   fix (extra goal `pre => 0%r <= bd`, PR for issue #1119): cryptobox 2 sites, sha3 16 sites,
                   xmss-security 3 sites. Verified: each project's CI scenario passes with that patch modulo the
                   same baseline SMT failures. sphincsplus and xsalsa20 need nothing.

downstream_fixes_rnd_pr/*_rnd-nonneg.patch  (2026-09-24) author-ready patches for sha3 `next` and cryptobox `next`
                   for EasyCrypt PR #1135 (pHL rnd non-negative bound goal), ON TOP of the #1105 changes already
                   merged there; `git am --keep-non-patch`. Verified with the #1135 build and CI-pinned provers:
                   sponge 21/21, cryptobox 8/8. The older *_rnd-nonneg.diff files (pre-#1105 base) are superseded.
