# Projection Insufficiency — Lean Proofs

Machine-checked proofs for the principal results in:

> **Projection Insufficiency and Trajectory Realization: A Unified Constraint-Based Framework for Bounded Systems**
> Shawn Kevin Jason, 2026

## Paper

The paper formalizes a structural limitation shared by bounded information systems: any trajectory-dependent property cannot, in general, be recovered from a non-injective projection of that trajectory. The Projection Insufficiency Theorem is proved direction-agnostically and then specialized to record incompleteness, extendability non-locality, and sequential admissibility, with a closed-interval dynamical embedding under both contractive and non-contractive regimes.

Preprint available on [SSRN](https://papers.ssrn.com/sol3/papers.cfm?abstract_id=6570761).

## Files

| File | Paper Result |
|------|-------------|
| `projection_insufficiency.lean` | Theorem 1 (Projection Insufficiency Theorem), Corollary 2 (Non-recoverability is structural) |
| `admissibility_nonlocal.lean` | Proposition 6 (Admissibility is trajectory-dependent), Corollary 7 (Non-locality of admissibility) |
| `contractive_fixed_point_unique.lean` | Theorem 8 (Constructive resolution under contractivity) |

## Requirements

- [Lean 4](https://lean-lang.org/)

## Author

Shawn Kevin Jason — Independent Researcher, Las Vegas, NV
Contact: shawnkevinjason@gmail.com

## License

MIT
