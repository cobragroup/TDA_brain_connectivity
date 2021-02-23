function hNew = nrmlz01(h)
% Rescale of vector h to [0,1] segment

if max(h)==min(h) 
    hNew = zeros(size(h));
else 
    hNew = (h-min(h))/(max(h)-min(h));
end;

end