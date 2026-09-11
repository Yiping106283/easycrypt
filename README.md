Companion material for EasyCrypt PR #1105 (change pHL to prevent negative probabilities), 2026-09-10.

downstream_fixes/  one unified diff per CI external project (sha3 `next`, cryptobox `next`,
                   xmss-security `main`/proof, sphincsplus `main`) that makes the project's CI
                   scenario pass with the #1105 binary (head bb75dba5a merged on main 311ba5d17).
                   Verified locally; the only remaining failures are the same SMT flakes that fail
                   on unpatched main.
repro/             the #1102 and #1119 reproducers as filed; both still compile (prove `false`)
                   with the #1105 binary.
