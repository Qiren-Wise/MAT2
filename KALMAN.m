clear all
[A11,B11,C11,D11]=tf2ss([1 -100],[1 0 100]);
[A12,B12,C12,D12]=tf2ss([10 10],[1 0 100]);
[A21,B21,C21,D21]=tf2ss([-10 -10],[1 0 100]);
[A22,B22,C22,D22]=tf2ss([1 -100],[1 0 100]);
A=[blkdiag(A11,A12,A21,A22)];
B=[blkdiag(B11,B12); blkdiag(B21,B22)];
C=blkdiag([C11 C12],[C21 C22]);
D=[D11 D12;D21 D22];