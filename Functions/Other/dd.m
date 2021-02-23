function [A] = dd(A,k)
if nargin<2
   k = 0;
end
   
    A = deleteDiagonal(A,k);
end