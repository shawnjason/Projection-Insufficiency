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

Nine standalone Lean 4 proof files covering the principal formal results of the paper. The proofs split into four groups: a **foundational core** establishing the projection-insufficiency impossibility, the trajectory-dependence of admissibility, and the constructive partial converse under contractivity; a **trajectory-admissibility enforcement template** that codifies the canonical same-fiber conflict pattern instantiated by every domain specialization below; the **AI-domain specializations** of Section 9 (language-model hallucination, planning dead-ends, reinforcement-learning terminal-constraint failure); and the **adjacent formalisms** of Section 10 (POMDP belief-state insufficiency, constraint-propagation infeasibility in CSPs).

Each file is independent and verifies against the current Mathlib release.

---

## Files

### Foundational Results

**`004_projection_insufficiency.lean`** — Theorem 2 (Projection Insufficiency Theorem) and Corollary 3 (Non-recoverability is structural)
The headline impossibility result. When a projection map P : T → R is non-injective and a property Φ : T → Y differs across some indistinguishability class of P, no function f : R → Y can recover Φ from P. Corollary 3 follows immediately as a structural restatement: non-recoverability is not contingent on the choice of recovery function but on the projection's failure to separate trajectories that differ in the property of interest.

**`012_admissibility_nonlocal.lean`** — Proposition 11 (Admissibility is trajectory-dependent) and Corollary 12 (Non-locality of admissibility)
Specializes the projection-insufficiency obstruction to predicates: when admissibility is trajectory-dependent relative to a bounded projection, no function on the projection alone recovers the admissibility predicate. The file is self-contained — it includes a re-statement of the underlying projection-insufficiency theorem so it can be verified in isolation without importing the foundational PIT file.

**`015_contractive_fixed_point_unique.lean`** — Theorem 13 (Constructive resolution under contractivity)
Companion result establishing that under a contractive self-map K : X → X with constant q < 1, K has at most one fixed point — the constructive partial converse to the impossibility theorems above.

### Trajectory-Level Enforcement Template

**`021_trajectory_admissibility_enforcement.lean`** — Proposition 10 (canonical template for the specialization family)
The architectural template instantiated by every specialization below. Defines the `SameFiberConflict` predicate — the same-projection / different-admissibility pattern — and proves both deterministic and stochastic policy forms: no deterministic local policy and no stochastic local policy can guarantee admissibility uniformly across the indistinguishability classes of a non-injective projection. Each file in the AI-domain and adjacent-formalisms groups below is a domain-specific instance of this template.

### AI-Domain Specializations (Section 9)

**`018_lm_hallucination_ceiling.lean`** — Section 9.1 (language-model hallucination ceiling)
A language model with bounded context window of depth h is a forward-local system whose next-token selection is a function of the bounded context projection. The `SameContextHallucinationRisk` predicate is the LM specialization of the same-fiber conflict; both deterministic and stochastic decoder forms are proved.

**`019_planning_dead_end_boundary.lean`** — Section 9.2 (planning dead-end detection boundary)
A planner with bounded local state representation (lookahead horizon plus current state, abstraction, or factored variables) is a forward-local system whose action selection is a function of that bounded representation. The `SameRepDeadEndConflict` predicate yields both deterministic and stochastic planner forms.

**`020_rl_terminal_constraint_boundary.lean`** — Section 9.3 (reinforcement-learning terminal-constraint boundary)
An RL policy operating under a finite value horizon h evaluates states using a bounded value-projection of the trajectory. The `SameProjTerminalConflict` predicate yields both deterministic and stochastic policy forms.

### Adjacent Formalisms (Section 10)

**`022_pomdp_belief_state_insufficiency.lean`** — Section 10.1 (POMDP belief-state insufficiency)
A POMDP agent that derives its belief state from its observation history acts on a function of that history. When two trajectories produce identical observation histories, the composition belief∘obs is a lossy projection; the `SameBeliefAdmissibilityConflict` predicate yields belief-state insufficiency in both deterministic and stochastic forms.

**`023_constraint_propagation_boundary.lean`** — Section 10.2 (constraint-propagation infeasibility boundary)
Arc-consistency and generalized arc-consistency algorithms operate on a bounded local view of a partial assignment — the values and adjacencies in a finite neighborhood of constraint structure. The `SameViewFeasibilityConflict` predicate yields both deterministic and nondeterministic propagation forms.

---

## Mapping to the Paper

| Paper Result | File | Lean Theorem |
|---|---|---|
| Theorem 2 (Projection Insufficiency) | `004_projection_insufficiency.lean` | `projection_insufficiency` |
| Corollary 3 (Non-recoverability is structural) | `004_projection_insufficiency.lean` | covered by `projection_insufficiency` |
| Proposition 11 (Admissibility is trajectory-dependent) | `012_admissibility_nonlocal.lean` | `admissibility_nonlocal` |
| Corollary 12 (Non-locality of admissibility) | `012_admissibility_nonlocal.lean` | covered by `admissibility_nonlocal` |
| Theorem 13 (Constructive resolution under contractivity) | `015_contractive_fixed_point_unique.lean` | `contractive_fixed_point_unique` |
| Proposition 10 (Trajectory admissibility enforcement, deterministic) | `021_trajectory_admissibility_enforcement.lean` | `no_deterministic_local_policy_guarantees_admissibility` |
| Proposition 10 (Trajectory admissibility enforcement, stochastic) | `021_trajectory_admissibility_enforcement.lean` | `no_stochastic_local_policy_guarantees_admissibility` |
| Section 9.1 (LM hallucination, deterministic) | `018_lm_hallucination_ceiling.lean` | `lm_hallucination_ceiling_deterministic` |
| Section 9.1 (LM hallucination, stochastic) | `018_lm_hallucination_ceiling.lean` | `lm_hallucination_ceiling_stochastic` |
| Section 9.2 (Planning dead-end, deterministic) | `019_planning_dead_end_boundary.lean` | `planning_dead_end_boundary_deterministic` |
| Section 9.2 (Planning dead-end, stochastic) | `019_planning_dead_end_boundary.lean` | `planning_dead_end_boundary_stochastic` |
| Section 9.3 (RL terminal-constraint, deterministic) | `020_rl_terminal_constraint_boundary.lean` | `rl_terminal_constraint_boundary_deterministic` |
| Section 9.3 (RL terminal-constraint, stochastic) | `020_rl_terminal_constraint_boundary.lean` | `rl_terminal_constraint_boundary_stochastic` |
| Section 10.1 (POMDP belief-state, deterministic) | `022_pomdp_belief_state_insufficiency.lean` | `pomdp_belief_state_insufficient_deterministic` |
| Section 10.1 (POMDP belief-state, stochastic) | `022_pomdp_belief_state_insufficiency.lean` | `pomdp_belief_state_insufficient_stochastic` |
| Section 10.2 (Constraint propagation, deterministic) | `023_constraint_propagation_boundary.lean` | `constraint_propagation_boundary_deterministic` |
| Section 10.2 (Constraint propagation, nondeterministic) | `023_constraint_propagation_boundary.lean` | `constraint_propagation_boundary_nondeterministic` |

---

## How to Verify

1. Open [live.lean-lang.org](https://live.lean-lang.org)
2. Confirm the dropdown in the upper right is set to **Latest Mathlib**
3. Paste the contents of any `.lean` file into the editor
4. Wait for checking to complete — "No goals" on each theorem and no errors in the Problems pane confirms verification

Each file is independent; no cross-file imports are required.

---

## Scope

These proofs verify the formal logical structure of the principal projection-insufficiency theorem, its trajectory-admissibility enforcement companion, the constructive partial converse under contractivity, and the AI-domain and adjacent-formalism specializations of Sections 9 and 10. They do not establish the framework-level conjectures and open claims developed in the paper, nor the philosophical or methodological commentary surrounding the formal results.

---

## Related Work

The forward-case specialization of the projection-insufficiency theorem, with explicit adversarial constructions and cross-domain AI applications, is developed in:

*The Non-Locality of Extendability: An Impossibility Theorem for Bounded Information Systems, with Applications to Generative Sequential Systems* — [DOI: 10.5281/zenodo.19688367](https://doi.org/10.5281/zenodo.19688367) (Lean proofs: [10.5281/zenodo.19687799](https://doi.org/10.5281/zenodo.19687799))

The stochastic extension of the forward-case result, with a quantitative inconsistency-accumulation lower bound and a matching positive representational theorem, is developed in:

*Inconsistency Accumulation in Forward-Local Sequential Policies: A Lower Bound under Delayed Constraints* — [DOI: 10.5281/zenodo.19688628](https://doi.org/10.5281/zenodo.19688628) (Lean proofs: [10.5281/zenodo.19687094](https://doi.org/10.5281/zenodo.19687094))

---

## License

MIT
