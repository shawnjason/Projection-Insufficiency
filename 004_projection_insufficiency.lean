-- ID 004 (and 005): Projection Insufficiency Theorem
--
-- Catalog ID 4 (Projection Insufficiency paper, Theorem 2).
-- Catalog ID 5 (Corollary 3, Non-recoverability is structural) — proven
-- in the same file as a direct consequence.
--
-- Statement: when a projection map P : T → R is non-injective and a
-- property Φ : T → Y differs across some indistinguishability class of P,
-- no function f : R → Y can recover Φ from P alone. The result is
-- structural — it follows from the fiber structure of P, not from
-- stochastic noise, optimization weakness, or computational limitation.
--
-- This is the foundational impossibility theorem of the framework. Every
-- subsequent specialization across the AI papers (extendability
-- non-locality in NEO, inconsistency accumulation in IA, hallucination
-- ceiling in the language-model paper, dead-end detection in planning,
-- absorbing failure in RL, POMDP belief-state insufficiency) cites
-- this theorem as its structural backing.
--
-- Corresponds to Theorem 2 and Corollary 3 of:
--   "Projection Insufficiency and Trajectory Realization: A Unified
--    Constraint-Based Framework for Bounded Systems"
--
-- Shawn Kevin Jason

import Mathlib.Data.Set.Basic
import Mathlib.Data.Set.Function

variable {T R Y : Type*}

-- P : trajectory space → representation space
-- Φ : trajectory space → property space

/-- A projection is bounded (informationally lossy / non-injective) if
    there exist two distinct trajectories that map to the same
    representation. Equivalently, P fails to distinguish all trajectories
    in its domain. -/
def BoundedProjection (P : T → R) : Prop :=
  ∃ x y : T, x ≠ y ∧ P x = P y

/-- A property Φ is trajectory-dependent relative to P if it is not
    constant on the fibers of P. Equivalently, two trajectories that
    P collapses to the same representation can have differing Φ values. -/
def TrajectoryDependent (P : T → R) (Φ : T → Y) : Prop :=
  ∃ x y : T, P x = P y ∧ Φ x ≠ Φ y

/-- Projection Insufficiency Theorem (catalog ID 4 / Theorem 2 of PIT).

    No function f : R → Y can recover Φ from P alone when P is bounded
    (non-injective) and Φ is trajectory-dependent relative to P.

    The proof is direct: trajectory-dependence supplies two trajectories
    in a common P-fiber on which Φ differs. Any function f defined on R
    must assign the same value to both, contradicting correctness on at
    least one of them. The non-recoverability is therefore structural
    (catalog ID 5 / Corollary 3) and does not depend on any probabilistic
    or algorithmic assumption. -/
theorem projection_insufficiency
    (P : T → R) (Φ : T → Y)
    (hP : BoundedProjection P)
    (hΦ : TrajectoryDependent P Φ) :
    ¬ ∃ f : R → Y, ∀ x : T, f (P x) = Φ x := by
  obtain ⟨_, _, _, _⟩ := hP
  obtain ⟨a, b, hab_proj, hab_phi⟩ := hΦ
  rintro ⟨f, hf⟩
  exact hab_phi ((hf a).symm.trans (hab_proj ▸ hf b))