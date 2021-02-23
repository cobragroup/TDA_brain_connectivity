function [Ac] = runFACDA(data,p,threshold)

if nargin==2
    threshold = 0.01;
elseif nargin==1
    threshold = 0.01;
    p = 1;
end;

[~,n] = size(data);
Ac=zeros(n);
for i=1:n
    Ac(i,:)=FACDA(transpose(data),i,p,threshold);
end


end