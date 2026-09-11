require import AllCore Distr StdOrder.
import RealOrder.
module M = {
  proc f() : unit = { var x : int; while (true) { } x <$ dunit 0; }
}.
lemma h : phoare[ M.f : true ==> true ] <= (-1)%r.
proof.
proc.
rnd (fun (_ : int) => true).
while (true); auto.
qed.
lemma bad &m : false.
proof.
have hle : Pr[M.f() @ &m : true] <= (-1)%r by byphoare h.
have hge : 0%r <= Pr[M.f() @ &m : true] by rewrite Pr[mu_ge0].
have h0 : 0%r <= - 1%r.
- by move: (ler_trans Pr[M.f() @ &m : true] 0%r (-1)%r hge hle); rewrite fromintN.
have : 0%r < 0%r by apply (ler_lt_trans (- 1%r)) => //; apply ltrN10.
by rewrite ltrr.
qed.
