function [pl] = persistenceLandscape(A0)
% A0 - Nx2 matrix with birth and deth from PD
    
[~,ind] = sort(A0(:,1));
A = A0(ind,:);
k = 1;

while ~isempty(A)
L = []; cnt = 0;
curPoint = A(1,:);
A(1,:) = []; p = 1;

cnt = cnt+1; L(cnt,1) = -Inf; L(cnt,2) = 0;
cnt = cnt+1; L(cnt,1) = curPoint(1); L(cnt,2) = 0;
cnt = cnt+1; L(cnt,1) = (curPoint(2)+curPoint(1))/2; L(cnt,2) = (curPoint(2)-curPoint(1))/2;

while ~(isinf(L(cnt,1))&& L(cnt,2)==0)
    if isempty(A)
            cnt = cnt+1; L(cnt,1) = curPoint(2); L(cnt,2) = 0;
            cnt = cnt+1; L(cnt,1) = Inf; L(cnt,2) = 0;            
    elseif (curPoint(2) >= max(A(:,2)))
            cnt = cnt+1; L(cnt,1) = curPoint(2); L(cnt,2) = 0;
            cnt = cnt+1; L(cnt,1) = Inf; L(cnt,2) = 0;            
    else
        i = p;
        while (A(i,2)<=curPoint(2))&&(i<size(A,1))
            i = i+1;
        end
        curPoint2 = A(i,:);
        p = i;
        A(i,:) = [];
        if curPoint2(1)>curPoint(2)
            cnt = cnt+1; L(cnt,1) = curPoint(2); L(cnt,2) = 0;
        end
        if curPoint2(1)>=curPoint(2)
            cnt = cnt+1; L(cnt,1) = curPoint2(1); L(cnt,2) = 0;
        else
            cnt = cnt+1; L(cnt,1) = (curPoint(2)+curPoint2(1))/2; L(cnt,2) = (curPoint(2)-curPoint2(1))/2;
            A(p+1:end+1,:) = A(p:end,:);
            A(p,:) = [curPoint2(1) curPoint(2)];
            p = p+1;
        end
        cnt = cnt+1; L(cnt,1) = (curPoint2(2)+curPoint2(1))/2; L(cnt,2) = (curPoint2(2)-curPoint2(1))/2;
        curPoint = curPoint2;
    end
end
pl(k).L = L(2:end-1,:); k = k+1;
end
end