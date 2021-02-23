function [clA] = deleteDiagonal(A, val)
% Delete diagonal elements from the matrix A
% change them into 'val'

if nargin<2
    val = 0;
end;

sizeA = size(A);
p = sizeA(2)/sizeA(1);
%display(sizeA);

clA = A;

for i=1:p
    for j=1:sizeA(1)
        clA(j,(i-1)*sizeA(1)+j) = val;
%        display(['i = ' mat2str(j) ', j = ' mat2str((i-1)*p+j)]);
    end;
end;


end