-- ID 015: Constructive Resolution Under Contractivity
--
-- Catalog ID 15 (Projection Insufficiency paper, Theorem 13).
--
-- Statement: if a self-map K : X → X on a metric space is contractive
-- with constant q < 1, then K has at most one fixed point. Two points
-- both fixed by K must be equal.
--
-- This is the uniqueness half of the Banach fixed-point structure used
-- in the PIT paper's closed-interval dynamical embedding (Section 7).
-- The full Banach theorem also gives existence and geometric convergence
-- of iterates; this file isolates the uniqueness clause as a standalone
-- result. Existence and convergence are addressed elsewhere in the
-- framework (the iterate-convergence machinery), but uniqueness alone
-- is what the PIT paper's constructive resolution argument requires:
-- when contractivity holds, the admissible trajectory the paper
-- characterizes is unique, and projection-insufficiency obstructions
-- in the contractive regime have a single canonical resolution rather
-- than a class of equivalent ones.
--
-- The proof method: contractivity gives dist(K x, K y) ≤ q · dist(x, y).
-- If both x and y are fixed points, this becomes dist(x, y) ≤ q · dist(x, y),
-- which combined with q < 1 forces dist(x, y) = 0, hence x = y.
--
-- Corresponds to Theorem 13 of:
--   "Projection Insufficiency and Trajectory Realization: A Unified
--    Constraint-Based Framework for Bounded Systems"
--
-- Shawn Kevin Jason

import Mathlib.Tactic
import Mathlib.Topology.MetricSpace.Basic

/-- Constructive Resolution Under Contractivity (catalog ID 15 / Theorem 13
    of PIT).

    A contractive self-map on a metric space has at most one fixed point.
    If K is q-contractive with q < 1, and both x and y satisfy K x = x and
    K y = y, then x = y.

    The argument: contractivity gives dist(K x, K y) ≤ q · dist(x, y).
    Substituting the fixed-point equations yields dist(x, y) ≤ q · dist(x, y).
    Since 1 - q > 0 and dist is nonnegative, this forces dist(x, y) = 0,
    so x = y by the metric-space axiom that zero distance implies equality. -/
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