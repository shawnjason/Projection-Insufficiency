import Mathlib.Tactic
import Mathlib.Topology.MetricSpace.Basic

-- Contractive Fixed Point Uniqueness
-- Shawn Kevin Jason

theorem contractive_fixed_point_unique
    (X : Type)
    [MetricSpace X]
    (K : X → X)
    (q : ℝ)
    (hq1 : q < 1)
    (hK : ∀ x y : X, dist (K x) (K y) ≤ q * dist x y)
    (x y : X)
    (hx : K x = x)
    (hy : K y = y) :
    x = y := by
  have hKxy := hK x y
  rw [hx, hy] at hKxy
  have hd : (0 : ℝ) ≤ dist x y := dist_nonneg
  have hq : (0 : ℝ) < 1 - q := by linarith
  have h1 : (1 - q) * dist x y ≤ 0 := by nlinarith
  have h2 : dist x y ≤ 0 := by nlinarith
  exact eq_of_dist_eq_zero (le_antisymm h2 hd)