function [dataToSVM,feature] = feature_PE(barcodes)

nSbj = length(barcodes);
H = zeros(nSbj,1);

for iSbj = 1:nSbj
    if ~isempty(barcodes{iSbj})
        H(iSbj,1) = (entropy(barcodes{iSbj}));
    else
        H(iSbj,1) = 0;
    end
end

dataToSVM.mat = H;
feature = H;

end