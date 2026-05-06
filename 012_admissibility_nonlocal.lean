-- ID 012 (and 013): Admissibility Non-Locality
--
-- Catalog ID 12 (Projection Insufficiency paper, Proposition 11) —
--   Admissibility is trajectory-dependent.
-- Catalog ID 13 (Corollary 12, Non-locality of admissibility) —
--   proven in the same file as a direct consequence.
--
-- Statement: when admissibility is trajectory-dependent relative to a
-- bounded projection P, no function defined solely on the projection
-- can recover the admissibility predicate. This is the temporal
-- specialization of the Projection Insufficiency Theorem (ID 4) to
-- sequential systems whose admissibility depends on history outside
-- the operative projection.
--
-- This file also includes a re-statement of the underlying projection-
-- insufficiency theorem in self-contained form, so the file is verifiable
-- in isolation without importing the foundational PIT file. The two
-- theorems together establish the projection structure (PIT) and its
-- direct consequence for admissibility (admissibility_nonlocal).
--
-- Corresponds to Proposition 11 and Corollary 12 of:
--   "Projection Insufficiency and Trajectory Realization: A Unified
--    Constraint-Based Framework for Bounded Systems"
--
-- Shawn Kevin Jason

/-- Projection Insufficiency Theorem (re-stated for self-contained
    verification). No function on the projection recovers a trajectory-
    dependent property when the projection is non-injective on it. -/
theorem projection_insufficiency
    (T R Y : Type)
    (P : T → R) (Φ : T → Y)
    (hP : ∃ x y : T, x ≠ y ∧ P x = P y)
    (hΦ : ∃ x y : T, P x = P y ∧ Φ x ≠ Φ y) :
    ¬ ∃ f : R → Y, ∀ x : T, f (P x) = Φ x := by
  obtain ⟨_, _, _, _⟩ := hP
  obtain ⟨a, b, hab_proj, hab_phi⟩ := hΦ
  rintro ⟨f, hf⟩
  exact hab_phi ((hf a).symm.trans (hab_proj ▸ hf b))

/-- Admissibility Non-Locality (catalog ID 12 / Proposition 11 of PIT).

    When the admissibility predicate is trajectory-dependent relative to
    a bounded projection P, no function f : R → Prop can recover the
    admissibility status from the projection alone. This is the structural
    obstruction to inferring global admissibility from local information.

    Catalog ID 13 / Corollary 12 (Non-locality of admissibility) follows
    immediately: any system that respects admissibility while operating
    only on the bounded projection cannot guarantee admissibility uniformly
    across the indistinguishability classes of P. The proof is direct
    contradiction on a same-fiber pair where admissibility differs. -/
theorem admissibility_nonlocal
    (T R : Type)
    (P : T → R)
    (admissible : T → Prop)
    (hAdm : ∃ x y : T, P x = P y ∧ admissible x ∧ ¬admissible y) :
    ¬ ∃ f : R → Prop, ∀ x : T, f (P x) ↔ admissible x := by
  obtain ⟨a, b, hab_proj, ha, hb⟩ := hAdm
  rintro ⟨f, hf⟩
  exact hb ((hf b).mp (hab_proj ▸ (hf a).mpr ha))