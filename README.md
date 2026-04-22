# Projection Insufficiency — Lean Proofs

Machine-checked proofs for the principal results in:

> **Projection Insufficiency and Trajectory Realization: A Unified Constraint-Based Framework for Bounded Systems**
>[![DOI](https://zenodo.org/badge/DOI/10.5281/zenodo.19687629.svg)](https://doi.org/10.5281/zenodo.19687629)

## Author

Shawn Kevin Jason — Independent Researcher, Las Vegas, NV
ORCID: [![ORCID iD](https://orcid.org/sites/default/files/images/orcid_16x16.png)](https://orcid.org/0009-0003-9208-1556) [0009-0003-9208-1556](https://orcid.org/0009-0003-9208-1556)

## Paper

The paper formalizes a structural limitation shared by bounded information systems: any trajectory-dependent property cannot, in general, be recovered from a non-injective projection of that trajectory. The Projection Insufficiency Theorem is proved direction-agnostically and then specialized to record incompleteness, extendability non-locality, and sequential admissibility, with a closed-interval dynamical embedding under both contractive and non-contractive regimes.

Preprint archive DOI (concept): [10.5281/zenodo.19633241](https://doi.org/10.5281/zenodo.19633241)

## Files

| File | Paper Result |
|------|-------------|
| `projection_insufficiency.lean` | Theorem 2 (Projection Insufficiency Theorem), Corollary 3 (Non-recoverability is structural) |
| `admissibility_nonlocal.lean` | Proposition 11 (Admissibility is trajectory-dependent), Corollary 12 (Non-locality of admissibility) |
| `contractive_fixed_point_unique.lean` | Theorem 13 (Constructive resolution under contractivity) |

## Verification

Each file is independent and verifies in the Lean 4 web editor at [live.lean-lang.org](https://live.lean-lang.org) against the current Mathlib release. Paste the contents of any `.lean` file into the editor; "No goals" on each theorem and no errors in the Problems pane confirms verification.

## Requirements

- [Lean 4](https://lean-lang.org/)

## Author

Shawn Kevin Jason — Independent Researcher, Las Vegas, NV
ORCID: [0009-0003-9208-1556](https://orcid.org/0009-0003-9208-1556)
Contact: shawnkevinjason@gmail.com

## License

MIT
