-- Projection Insufficiency Theorem
-- Shawn Kevin Jason

import Mathlib.Data.Set.Basic
import Mathlib.Data.Set.Function

variable {T R Y : Type*}

-- P : trajectory space → representation space
-- Φ : trajectory space → property space

/-- A projection is bounded if it is not injective -/
def BoundedProjection (P : T → R) : Prop :=
  ∃ x y : T, x ≠ y ∧ P x = P y

/-- Φ is trajectory-dependent if it differs on some indistinguishability class -/
def TrajectoryDependent (P : T → R) (Φ : T → Y) : Prop :=
  ∃ x y : T, P x = P y ∧ Φ x ≠ Φ y

/-- Projection Insufficiency Theorem:
    No function f : R → Y can recover Φ from P
    when P is bounded and Φ is trajectory-dependent -/
theorem projection_insufficiency
    (P : T → R) (Φ : T → Y)
    (hP : BoundedProjection P)
    (hΦ : TrajectoryDependent P Φ) :
    ¬ ∃ f : R → Y, ∀ x : T, f (P x) = Φ x := by
  obtain ⟨x, y, hxy_ne, hxy_proj⟩ := hP
  obtain ⟨a, b, hab_proj, hab_phi⟩ := hΦ
  rintro ⟨f, hf⟩
  have ha := hf a
  have hb := hf b
  rw [hab_proj] at ha
  exact hab_phi (ha.symm.trans hb)