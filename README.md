# Projection Insufficiency — Lean Proofs

[![DOI](https://zenodo.org/badge/DOI/10.5281/zenodo.19687629.svg)](https://doi.org/10.5281/zenodo.19687629)

Machine-checked Lean 4 proofs for:

**"Projection Insufficiency and Trajectory Realization: A Unified Constraint-Based Framework for Bounded Systems"**

Paper DOI (concept, always resolves to latest): [10.5281/zenodo.19633241](https://doi.org/10.5281/zenodo.19633241)

---

## Author

Shawn Kevin Jason — Independent Researcher, Las Vegas, NV
ORCID: [![ORCID iD](https://orcid.org/sites/default/files/images/orcid_16x16.png)](https://orcid.org/0009-0003-9208-1556) [0009-0003-9208-1556](https://orcid.org/0009-0003-9208-1556)

---

## What This Repository Contains

Three standalone Lean 4 proofs covering the principal formal results of the paper. Each file is independent and verifies against the current Mathlib release.

The paper formalizes a structural limitation shared by bounded information systems: any trajectory-dependent property cannot, in general, be recovered from a non-injective projection of that trajectory. The Projection Insufficiency Theorem is proved direction-agnostically and then specialized to record incompleteness, extendability non-locality, and sequential admissibility, with a closed-interval dynamical embedding under both contractive and non-contractive regimes.

---

## Files

| File | Paper Result |
|------|-------------|
| `projection_insufficiency.lean` | Theorem 2 (Projection Insufficiency Theorem), Corollary 3 (Non-recoverability is structural) |
| `admissibility_nonlocal.lean` | Proposition 11 (Admissibility is trajectory-dependent), Corollary 12 (Non-locality of admissibility) |
| `contractive_fixed_point_unique.lean` | Theorem 13 (Constructive resolution under contractivity) |

---

## How to Verify

1. Open [live.lean-lang.org](https://live.lean-lang.org)
2. Confirm the dropdown in the upper right is set to **Latest Mathlib**
3. Paste the contents of any `.lean` file into the editor
4. Wait for checking to complete — "No goals" on each theorem and no errors in the Problems pane confirms verification

Each file is independent; no cross-file imports are required.

---

## Scope

These proofs verify the formal logical structure of the principal theorems: the projection-insufficiency impossibility, its specialization to non-local admissibility, and the constructive resolution under contractivity. What they do not establish: the full AI-domain implications (hallucination in language models, dead-end states in planning, absorbing failure in reinforcement learning), which are developed narratively in the associated paper as architectural consequences of the formal results.

---

## Related Work

The forward-case specialization of the projection-insufficiency theorem, with explicit adversarial constructions and cross-domain AI applications, is developed in:

*The Non-Locality of Extendability: An Impossibility Theorem for Bounded Information Systems, with Applications to Generative Sequential Systems* — [DOI: 10.5281/zenodo.19688367](https://doi.org/10.5281/zenodo.19688367) (Lean proofs: [10.5281/zenodo.19687799](https://doi.org/10.5281/zenodo.19687799))

The stochastic extension of the forward-case result, with a quantitative inconsistency-accumulation lower bound and a matching positive representational theorem, is developed in:

*Inconsistency Accumulation in Forward-Local Sequential Policies: A Lower Bound under Delayed Constraints* — [DOI: 10.5281/zenodo.19688628](https://doi.org/10.5281/zenodo.19688628) (Lean proofs: [10.5281/zenodo.19687094](https://doi.org/10.5281/zenodo.19687094))

---

## License

MIT
