-- ID 022: POMDP Belief-State Insufficiency
--
-- Catalog ID 22 (Projection Insufficiency paper, Section 10.1).
-- Specialization of Theorem 2 (PIT, ID 4) to POMDP belief-state agents.
--
-- Statement: a POMDP agent that derives its belief state from its
-- observation history acts on a function of that history. When two
-- trajectories produce identical observation histories — and therefore
-- identical belief states — but differ in trajectory-dependent
-- admissibility, no function of the belief state alone can determine
-- admissibility. The belief state is a sufficient statistic of the
-- observation history for predicting future observations and rewards;
-- it is not in general a sufficient statistic for trajectory-level
-- admissibility properties whose distinction lies in the suppressed
-- portion of the history rather than in the current hidden state.
--
-- Corresponds to Section 10.1 of:
--   "Projection Insufficiency and Trajectory Realization: A Unified
--    Constraint-Based Framework for Bounded Systems"
--
-- Shawn Kevin Jason

import Mathlib.Tactic
import Mathlib.Data.Set.Basic

variable {Trajectory ObsHistory Belief Action : Type*}

/-- The belief-state derivation: an agent computes a belief state from its
    observation history. Two trajectories that produce the same observation
    history yield the same belief state by construction. -/
def NonInjectiveBeliefDerivation
    (_obs : Trajectory → ObsHistory) (_belief : ObsHistory → Belief) : Prop :=
  ∃ τ1 τ2 : Trajectory, τ1 ≠ τ2 ∧ _obs τ1 = _obs τ2

/-- Admissibility-preserving action sets. `A_adm τ` is the set of actions
    from trajectory τ that preserve at least one admissible completion.
    Admissibility may depend on the full trajectory, not only on the
    current hidden state. -/
def AdmissibleActions (_A_adm : Trajectory → Set Action) : Prop := True

/-- Same-belief admissibility conflict: two trajectories produce identical
    belief states (via identical observation histories) but have disjoint
    admissibility-preserving action sets. The structural condition under
    which belief-state agents cannot determine admissibility, even with
    perfect Bayesian inference over hidden states. -/
def SameBeliefAdmissibilityConflict
    (obs : Trajectory → ObsHistory) (belief : ObsHistory → Belief)
    (A_adm : Trajectory → Set Action) : Prop :=
  ∃ τ1 τ2 : Trajectory,
    belief (obs τ1) = belief (obs τ2) ∧ A_adm τ1 ∩ A_adm τ2 = ∅

/-- Deterministic belief-state policy form. No deterministic policy defined
    solely on the belief state can guarantee selection of an admissibility-
    preserving action in all trajectories when a same-belief admissibility
    conflict exists. POMDP belief-state agents face the same structural
    obstruction as raw observation-history agents for trajectory-dependent
    admissibility properties. -/
theorem pomdp_belief_state_insufficient_deterministic
    (obs : Trajectory → ObsHistory) (belief : ObsHistory → Belief)
    (A_adm : Trajectory → Set Action)
    (h : SameBeliefAdmissibilityConflict obs belief A_adm) :
    ¬ ∃ π : Belief → Action, ∀ τ : Trajectory, π (belief (obs τ)) ∈ A_adm τ := by
  obtain ⟨τ1, τ2, hbel, hdisj⟩ := h
  rintro ⟨π, hπ⟩
  have h1 : π (belief (obs τ1)) ∈ A_adm τ1 := hπ τ1
  have h2 : π (belief (obs τ2)) ∈ A_adm τ2 := hπ τ2
  rw [hbel] at h1
  have hboth : π (belief (obs τ2)) ∈ A_adm τ1 ∩ A_adm τ2 := ⟨h1, h2⟩
  rw [hdisj] at hboth
  exact hboth

/-- Stochastic belief-state policy form. No stochastic POMDP policy whose
    action-distribution support at a given belief state must lie inside
    the admissibility-preserving action set can satisfy this requirement
    for both trajectories in a same-belief admissibility conflict pair.
    Bayesian belief tracking does not in general resolve this obstruction
    because the obstruction lies upstream of belief computation, in the
    non-injectivity of the observation history map on trajectory-level
    admissibility distinctions. -/
theorem pomdp_belief_state_insufficient_stochastic
    (obs : Trajectory → ObsHistory) (belief : ObsHistory → Belief)
    (A_adm : Trajectory → Set Action)
    (h : SameBeliefAdmissibilityConflict obs belief A_adm) :
    ¬ ∃ supp : Belief → Set Action,
      (∀ b : Belief, (supp b).Nonempty) ∧
      (∀ τ : Trajectory, supp (belief (obs τ)) ⊆ A_adm τ) := by
  obtain ⟨τ1, τ2, hbel, hdisj⟩ := h
  rintro ⟨supp, hne, hsub⟩
  obtain ⟨a, ha1⟩ := hne (belief (obs τ1))
  have h1 : a ∈ A_adm τ1 := hsub τ1 ha1
  have ha2 : a ∈ supp (belief (obs τ2)) := by rw [← hbel]; exact ha1
  have h2 : a ∈ A_adm τ2 := hsub τ2 ha2
  have hboth : a ∈ A_adm τ1 ∩ A_adm τ2 := ⟨h1, h2⟩
  rw [hdisj] at hboth
  exact hboth