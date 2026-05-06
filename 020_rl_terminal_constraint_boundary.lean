-- ID 020: Reinforcement Learning Terminal-Constraint Boundary
--
-- Catalog ID 20 (Projection Insufficiency paper, Section 9.3).
-- Specialization of Theorem 2 (PIT, ID 4) to reinforcement learning under
-- finite value horizons.
--
-- Statement: an RL policy operating under a finite value horizon h
-- evaluates states using a bounded value-projection of the trajectory.
-- When admissibility — reaching a terminal reward threshold, terminating
-- inside a safety set, or satisfying a task-completion constraint — is a
-- property of the complete trajectory, two states can share the same
-- value-horizon projection while one admits a terminal-constraint-
-- satisfying continuation and the other does not. No action selection
-- rule defined solely on the bounded value projection can correctly
-- distinguish absorbing-failure states from recoverable ones in all cases.
-- This is the structural boundary on finite-horizon RL for terminal
-- constraint satisfaction.
--
-- Corresponds to Section 9.3 of:
--   "Projection Insufficiency and Trajectory Realization: A Unified
--    Constraint-Based Framework for Bounded Systems"
--
-- Shawn Kevin Jason

import Mathlib.Tactic
import Mathlib.Data.Set.Basic

variable {State ValueProj Action : Type*}

/-- A bounded value-horizon projection of trajectory states. The relevant
    property is that two distinct states can collapse to the same
    value-horizon view, hiding terminal-constraint distinctions. -/
def NonInjectiveValueProj (_valProj : State → ValueProj) : Prop :=
  ∃ s1 s2 : State, s1 ≠ s2 ∧ _valProj s1 = _valProj s2

/-- Terminal-constraint-preserving action sets. `A_term s` is the set of
    actions from state s that preserve at least one continuation reaching
    the terminal constraint. A state with empty `A_term s` is an absorbing-
    failure state. -/
def TerminalReachingActions (_A_term : State → Set Action) : Prop := True

/-- Same-projection terminal-constraint conflict: two states share their
    value-horizon projection but have disjoint terminal-reaching action
    sets. The structural condition under which finite-horizon RL cannot
    reliably distinguish absorbing-failure states. -/
def SameProjTerminalConflict
    (valProj : State → ValueProj) (A_term : State → Set Action) : Prop :=
  ∃ s1 s2 : State, valProj s1 = valProj s2 ∧ A_term s1 ∩ A_term s2 = ∅

/-- Deterministic policy form. No deterministic policy defined solely on
    the bounded value-horizon projection can guarantee selection of a
    terminal-constraint-preserving action in all states when a same-
    projection terminal conflict exists. Finite-horizon RL cannot reliably
    avoid absorbing-failure states under non-local terminal constraints. -/
theorem rl_terminal_constraint_boundary_deterministic
    (valProj : State → ValueProj) (A_term : State → Set Action)
    (h : SameProjTerminalConflict valProj A_term) :
    ¬ ∃ π : ValueProj → Action, ∀ s : State, π (valProj s) ∈ A_term s := by
  obtain ⟨s1, s2, hproj, hdisj⟩ := h
  rintro ⟨π, hπ⟩
  have h1 : π (valProj s1) ∈ A_term s1 := hπ s1
  have h2 : π (valProj s2) ∈ A_term s2 := hπ s2
  rw [hproj] at h1
  have hboth : π (valProj s2) ∈ A_term s1 ∩ A_term s2 := ⟨h1, h2⟩
  rw [hdisj] at hboth
  exact hboth

/-- Stochastic policy form. No stochastic RL policy whose action-distribution
    support at a given value-horizon projection must lie inside the
    terminal-reaching action set can satisfy this requirement for both
    states in a same-projection terminal conflict pair. Standard policy
    classes including ε-greedy, softmax, Gaussian, and entropy-regularized
    policies do not escape the obstruction at the level of support-based
    safety; they redistribute mass within the same projection-conditioned
    support. -/
theorem rl_terminal_constraint_boundary_stochastic
    (valProj : State → ValueProj) (A_term : State → Set Action)
    (h : SameProjTerminalConflict valProj A_term) :
    ¬ ∃ supp : ValueProj → Set Action,
      (∀ v : ValueProj, (supp v).Nonempty) ∧
      (∀ s : State, supp (valProj s) ⊆ A_term s) := by
  obtain ⟨s1, s2, hproj, hdisj⟩ := h
  rintro ⟨supp, hne, hsub⟩
  obtain ⟨a, ha1⟩ := hne (valProj s1)
  have h1 : a ∈ A_term s1 := hsub s1 ha1
  have ha2 : a ∈ supp (valProj s2) := by rw [← hproj]; exact ha1
  have h2 : a ∈ A_term s2 := hsub s2 ha2
  have hboth : a ∈ A_term s1 ∩ A_term s2 := ⟨h1, h2⟩
  rw [hdisj] at hboth
  exact hboth