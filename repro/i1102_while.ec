require import Real.
module M = {proc p() = {while (true) {}}}.
lemma bad: phoare[M.p: true ==> false] <= (-1%r).
proof.
proc.
while (true).
auto.
done.
qed.
