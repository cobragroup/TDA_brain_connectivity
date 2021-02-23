function [H] = entropy(PD)

p = PD(:,2) - PD(:,1);
pl = p./sum(p);
pl(pl==0) = [];

H = -sum(pl.*log(pl));

end