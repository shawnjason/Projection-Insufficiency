-- Projection Insufficiency + Admissibility Non-Locality
-- Shawn Kevin Jason

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

theorem admissibility_nonlocal
    (T R : Type)
    (P : T → R)
    (admissible : T → Prop)
    (hAdm : ∃ x y : T, P x = P y ∧ admissible x ∧ ¬admissible y) :
    ¬ ∃ f : R → Prop, ∀ x : T, f (P x) ↔ admissible x := by
  obtain ⟨a, b, hab_proj, ha, hb⟩ := hAdm
  rintro ⟨f, hf⟩
  exact hb ((hf b).mp (hab_proj ▸ (hf a).mpr ha))