(* Regression for the `fel` counter-jump / negative-weight bug.

   The failure-event lemma tactic used to accept a counter that JUMPS (skipping
   indices) combined with NEGATIVE per-step weights at the skipped indices. The
   full-range weight sum could then be made smaller than the sum over the
   counter values actually visited, letting `fel` "prove" Pr[bad] <= 0 for an
   event that in fact happens with probability 1.  (A jump is one way to make
   a counter value in [0, q) unreachable; see tests/fel-unreachable-counter.ec
   for the general, non-jumping instance.)

   Here the counter jumps 0 -> 2 (index 1 is never visited) and the weight
   ash = (fun x => if x = 0 then 1 else -1) is negative at the skipped index 1,
   giving whole-range sum 1 + (-1) = 0.

   The fixed tactic emits an extra, trailing obligation
   `forall i, 0 <= i < q => 0 <= ash i` (unprovable here since ash 1 = -1).
   The six original goals are discharged exactly as before; only the trailing
   goal is left and closing it must fail. *)
require import AllCore List Distr DBool FelTactic StdBigop.
(*---*) import Bigreal.
(*---*) import List.Range.

module M = {
  var bad : bool
  var c   : int

  proc o() : unit = { if (c = 0) { bad <- true; c <- 2; } }
  proc f() : unit = { bad <- false; c <- 0; o(); }
}.

lemma pr_le0 &m : Pr[M.f() @ &m : M.bad] <= 0%r.
proof.
fel 2 M.c (fun x => if x = 0 then 1%r else (-1)%r) 2 M.bad [M.o : (M.c = 0)] (0 <= M.c /\ M.c <= 2).
- have -> : range 0 2 = [0; 1] by rewrite range_ltn // range_ltn // range_geq //.
  by rewrite BRA.big_cons BRA.big_cons BRA.big_nil /predT /=.
- by move=> &hr; smt().
- by auto.
- by proc; rcondt 1; auto.
- by move=> c0; proc; auto=> /#.
- by move=> b0 c0; proc; auto=> /#.
move=> i [ge0_i lt_i2].
fail (by smt()).
abort.
