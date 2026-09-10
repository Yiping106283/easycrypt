(* `fel` must require every per-step weight to be non-negative on [0, q):
   at a counter value with no reachable state the per-oracle obligation is
   vacuous, so a negative weight there would shrink the full-range sum.
   Here 0 <= c <= 1 makes c = 2 unreachable and ash 2 = -2, so the sum is 0
   although Pr[bad] = 1. The trailing goal `0%r <= ash i` is false at i = 2. *)
require import AllCore List FelTactic StdBigop.
(*---*) import Bigreal.
(*---*) import List.Range.

module M = {
  var bad : bool
  var c   : int

  proc o() : unit = { bad <- M.c = 0 || bad; c <- 1; }
  proc f() : unit = { bad <- false; c <- 0; o(); }
}.

lemma pr_le0 &m : Pr[M.f() @ &m : M.bad] <= 0%r.
proof.
fel 2 M.c (fun x => if 0 <= x <= 1 then 1%r else (-2)%r) 3 M.bad
    [M.o : (M.c = 0)] (0 <= M.c <= 1).
- have -> : range 0 3 = [0; 1; 2] by do 3! (rewrite range_ltn //); rewrite range_geq //.
  by rewrite 3!BRA.big_cons BRA.big_nil /predT /=.
- smt().
- auto.
- by conseq (: _ ==> _ : <= 1%r) => //#.
- by move=> c; proc; auto.
- by move=> b c; proc; auto=> />.
move=> i [ge0_i lt_i3].
fail (by smt()).
abort.
