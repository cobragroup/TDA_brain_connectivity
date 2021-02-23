function [kr] = kernelPH(X,Y,sigma)

if nargin<3
    sigma = 0.2;
end

kr = 0;
for k = 1:length(X)
    for m = 1:length(Y)
        kr = kr + ...
            exp(-norm(X(k,:)-Y(m,:))^2/(8*sigma))... 
            -exp(-norm(X(k,:)-[Y(m,2) Y(m,1)])^2/(8*sigma));
    end
end

kr =  kr/(8*pi*sigma);

end