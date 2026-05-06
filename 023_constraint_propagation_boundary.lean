-- ID 023: Constraint-Propagation Infeasibility Boundary
--
-- Catalog ID 23 (Projection Insufficiency paper, Section 10.2).
-- Specialization of Theorem 2 (PIT, ID 4) to constraint propagation in CSPs.
--
-- Statement: arc-consistency and generalized arc-consistency algorithms
-- operate on a bounded local view of a partial assignment — the values
-- and adjacencies in a finite neighborhood of constraint structure.
-- When global feasibility depends on non-local constraints linking
-- non-adjacent variables, two partial assignments can share the same
-- locally-checkable view while one admits a consistent completion and
-- the other does not. No propagation procedure operating only on local
-- consistency can correctly certify global infeasibility in all cases.
-- This is the structural boundary on what constraint propagation can
-- guarantee in the presence of non-local constraints.
--
-- Corresponds to Section 10.2 of:
--   "Projection Insufficiency and Trajectory Realization: A Unified
--    Constraint-Based Framework for Bounded Systems"
--
-- Shawn Kevin Jason

import Mathlib.Tactic
import Mathlib.Data.Set.Basic

variable {PartialAssignment LocalView Extension : Type*}

/-- A bounded local view of a partial assignment for constraint propagation.
    The relevant property is that two distinct partial assignments can
    collapse to the same local view, hiding non-local feasibility
    distinctions. -/
def NonInjectiveLocalView (_localView : PartialAssignment → LocalView) : Prop :=
  ∃ a1 a2 : PartialAssignment, a1 ≠ a2 ∧ _localView a1 = _localView a2

/-- Feasibility-preserving extensions. `E_feas a` is the set of next
    variable assignments from partial assignment a that preserve at least
    one globally consistent completion. A partial assignment with empty
    `E_feas a` is globally infeasible. -/
def FeasibleExtensions (_E_feas : PartialAssignment → Set Extension) : Prop := True

/-- Same-view feasibility conflict: two partial assignments share the
    same local view but have disjoint feasibility-preserving extension
    sets. The structural condition under which constraint propagation
    cannot certify global infeasibility from local consistency alone. -/
def SameViewFeasibilityConflict
    (localView : PartialAssignment → LocalView)
    (E_feas : PartialAssignment → Set Extension) : Prop :=
  ∃ a1 a2 : PartialAssignment,
    localView a1 = localView a2 ∧ E_feas a1 ∩ E_feas a2 = ∅

/-- Deterministic propagation form. No deterministic propagation procedure
    defined solely on the bounded local view can guarantee selection of a
    feasibility-preserving extension in all partial assignments when a
    same-view feasibility conflict exists. Local arc and path consistency
    cannot achieve complete global infeasibility detection in this setting. -/
theorem constraint_propagation_boundary_deterministic
    (localView : PartialAssignment → LocalView)
    (E_feas : PartialAssignment → Set Extension)
    (h : SameViewFeasibilityConflict localView E_feas) :
    ¬ ∃ propagate : LocalView → Extension,
      ∀ a : PartialAssignment, propagate (localView a) ∈ E_feas a := by
  obtain ⟨a1, a2, hview, hdisj⟩ := h
  rintro ⟨propagate, hprop⟩
  have h1 : propagate (localView a1) ∈ E_feas a1 := hprop a1
  have h2 : propagate (localView a2) ∈ E_feas a2 := hprop a2
  rw [hview] at h1
  have hboth : propagate (localView a2) ∈ E_feas a1 ∩ E_feas a2 := ⟨h1, h2⟩
  rw [hdisj] at hboth
  exact hboth

/-- Nondeterministic propagation form. No propagation procedure whose
    extension-set support at a given local view must lie inside the
    feasibility-preserving extension set can satisfy this requirement
    for both partial assignments in a same-view feasibility conflict
    pair. Branching, restart, and randomized propagation strategies do
    not escape the obstruction at the level of soundness on local-view-
    indexed extension sets. -/
theorem constraint_propagation_boundary_nondeterministic
    (localView : PartialAssignment → LocalView)
    (E_feas : PartialAssignment → Set Extension)
    (h : SameViewFeasibilityConflict localView E_feas) :
    ¬ ∃ supp : LocalView → Set Extension,
      (∀ v : LocalView, (supp v).Nonempty) ∧
      (∀ a : PartialAssignment, supp (localView a) ⊆ E_feas a) := by
  obtain ⟨a1, a2, hview, hdisj⟩ := h
  rintro ⟨supp, hne, hsub⟩
  obtain ⟨e, he1⟩ := hne (localView a1)
  have h1 : e ∈ E_feas a1 := hsub a1 he1
  have he2 : e ∈ supp (localView a2) := by rw [← hview]; exact he1
  have h2 : e ∈ E_feas a2 := hsub a2 he2
  have hboth : e ∈ E_feas a1 ∩ E_feas a2 := ⟨h1, h2⟩
  rw [hdisj] at hboth
  exact hboth