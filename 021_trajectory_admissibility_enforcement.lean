-- ID 021: Trajectory-Level Admissibility Enforcement Requirement
--
-- Catalog ID 21 (Projection Insufficiency paper).
-- Companion to Theorem 2 (PIT, ID 4) and Proposition 11 / Corollary 12 (IDs 12 / 13).
--
-- Statement: if a sequential system selects actions via a function of a bounded
-- local projection, and there exist two prefixes sharing the same local
-- representation but with disjoint admissibility-preserving action sets, then
-- no policy defined solely on that projection can guarantee global admissibility
-- in all represented cases. This holds for both deterministic policies (a single
-- chosen action) and stochastic policies whose support must lie inside the
-- admissibility-preserving set.
--
-- Corresponds to Proposition 10 of:
--   "Projection Insufficiency and Trajectory Realization: A Unified
--    Constraint-Based Framework for Bounded Systems"
--
-- Shawn Kevin Jason

import Mathlib.Tactic
import Mathlib.Data.Set.Basic

variable {T R U : Type*}

/-- Same-fiber action conflict: two prefixes share their local representation
    under P but have disjoint admissibility-preserving action sets. -/
def SameFiberConflict (P : T → R) (U_adm : T → Set U) : Prop :=
  ∃ p1 p2 : T, P p1 = P p2 ∧ U_adm p1 ∩ U_adm p2 = ∅

/-- Deterministic policy form. No deterministic policy on R can place its chosen
    action inside U_adm(p) for every p when a same-fiber conflict exists. -/
theorem no_deterministic_local_policy_guarantees_admissibility
    (P : T → R) (U_adm : T → Set U)
    (h : SameFiberConflict P U_adm) :
    ¬ ∃ π : R → U, ∀ p : T, π (P p) ∈ U_adm p := by
  obtain ⟨p1, p2, hfiber, hdisj⟩ := h
  rintro ⟨π, hπ⟩
  have h1 : π (P p1) ∈ U_adm p1 := hπ p1
  have h2 : π (P p2) ∈ U_adm p2 := hπ p2
  rw [hfiber] at h1
  have hboth : π (P p2) ∈ U_adm p1 ∩ U_adm p2 := ⟨h1, h2⟩
  rw [hdisj] at hboth
  exact hboth

/-- Stochastic policy form. No stochastic policy on R can place its entire
    support inside U_adm(p) for every p when a same-fiber conflict exists. -/
theorem no_stochastic_local_policy_guarantees_admissibility
    (P : T → R) (U_adm : T → Set U)
    (h : SameFiberConflict P U_adm) :
    ¬ ∃ supp : R → Set U,
      (∀ r : R, (supp r).Nonempty) ∧
      (∀ p : T, supp (P p) ⊆ U_adm p) := by
  obtain ⟨p1, p2, hfiber, hdisj⟩ := h
  rintro ⟨supp, hne, hsub⟩
  obtain ⟨u, hu1⟩ := hne (P p1)
  have h1 : u ∈ U_adm p1 := hsub p1 hu1
  have hu2 : u ∈ supp (P p2) := by rw [← hfiber]; exact hu1
  have h2 : u ∈ U_adm p2 := hsub p2 hu2
  have hboth : u ∈ U_adm p1 ∩ U_adm p2 := ⟨h1, h2⟩
  rw [hdisj] at hboth
  exact hboth