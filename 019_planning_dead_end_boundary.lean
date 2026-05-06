-- ID 019: Planning Dead-End Detection Boundary
--
-- Catalog ID 19 (Projection Insufficiency paper, Section 9.2).
-- Specialization of Theorem 2 (PIT, ID 4) to bounded-lookahead planning.
--
-- Statement: a planner with bounded local state representation (lookahead
-- horizon plus current state, abstraction, or factored variables) is a
-- forward-local system whose action selection is a function of that
-- bounded representation. When goal reachability — and therefore
-- dead-end status — depends on trajectory information outside the local
-- representation, two states can share the same local representation
-- while differing in goal-reachability. No function of the local
-- representation alone can correctly classify dead-ends in all cases.
-- This is the structural boundary on dead-end detection in classical
-- and probabilistic planning under bounded local evaluation.
--
-- Corresponds to Section 9.2 of:
--   "Projection Insufficiency and Trajectory Realization: A Unified
--    Constraint-Based Framework for Bounded Systems"
--
-- Shawn Kevin Jason

import Mathlib.Tactic
import Mathlib.Data.Set.Basic

variable {State LocalRep Action : Type*}

/-- A bounded local state-representation map for a planner. The relevant
    property is that two distinct planning states can collapse to the
    same local representation, hiding global reachability distinctions. -/
def NonInjectiveLocalRep (_locRep : State → LocalRep) : Prop :=
  ∃ s1 s2 : State, s1 ≠ s2 ∧ _locRep s1 = _locRep s2

/-- Goal-reachability-preserving action sets. `A_goal s` is the set of
    actions from state s that preserve at least one goal-reaching
    completion. A state with empty `A_goal s` is a dead-end. -/
def GoalReachingActions (_A_goal : State → Set Action) : Prop := True

/-- Same-representation dead-end conflict: two states share the same local
    representation but have disjoint goal-reaching action sets. The
    structural condition under which dead-end detection from the local
    representation alone is impossible. -/
def SameRepDeadEndConflict
    (locRep : State → LocalRep) (A_goal : State → Set Action) : Prop :=
  ∃ s1 s2 : State, locRep s1 = locRep s2 ∧ A_goal s1 ∩ A_goal s2 = ∅

/-- Deterministic planner form. No deterministic action selection rule
    defined solely on the bounded local representation can guarantee
    selection of a goal-reaching action in all states when a same-
    representation dead-end conflict exists. Bounded-lookahead planners
    cannot achieve complete dead-end detection in this setting. -/
theorem planning_dead_end_boundary_deterministic
    (locRep : State → LocalRep) (A_goal : State → Set Action)
    (h : SameRepDeadEndConflict locRep A_goal) :
    ¬ ∃ plan : LocalRep → Action, ∀ s : State, plan (locRep s) ∈ A_goal s := by
  obtain ⟨s1, s2, hrep, hdisj⟩ := h
  rintro ⟨plan, hpl⟩
  have h1 : plan (locRep s1) ∈ A_goal s1 := hpl s1
  have h2 : plan (locRep s2) ∈ A_goal s2 := hpl s2
  rw [hrep] at h1
  have hboth : plan (locRep s2) ∈ A_goal s1 ∩ A_goal s2 := ⟨h1, h2⟩
  rw [hdisj] at hboth
  exact hboth

/-- Stochastic planner form. No randomized planning rule whose action
    distribution support at a given local representation must lie inside
    the goal-reaching action set can satisfy this requirement for both
    states in a same-representation dead-end conflict pair. Probabilistic
    planning under bounded local evaluation faces the same structural
    obstruction as deterministic planning. -/
theorem planning_dead_end_boundary_stochastic
    (locRep : State → LocalRep) (A_goal : State → Set Action)
    (h : SameRepDeadEndConflict locRep A_goal) :
    ¬ ∃ supp : LocalRep → Set Action,
      (∀ r : LocalRep, (supp r).Nonempty) ∧
      (∀ s : State, supp (locRep s) ⊆ A_goal s) := by
  obtain ⟨s1, s2, hrep, hdisj⟩ := h
  rintro ⟨supp, hne, hsub⟩
  obtain ⟨a, ha1⟩ := hne (locRep s1)
  have h1 : a ∈ A_goal s1 := hsub s1 ha1
  have ha2 : a ∈ supp (locRep s2) := by rw [← hrep]; exact ha1
  have h2 : a ∈ A_goal s2 := hsub s2 ha2
  have hboth : a ∈ A_goal s1 ∩ A_goal s2 := ⟨h1, h2⟩
  rw [hdisj] at hboth
  exact hboth