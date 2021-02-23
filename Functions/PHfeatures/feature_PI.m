function [dataToSVM,feature] = feature_PI(barcodes)

[feature] = PIdiagram2(barcodes,[],0);

nSbj = length(barcodes);
for iSbj = 1:nSbj
    pi = feature(:,:,iSbj);
    dataToSVM(1).mat(iSbj,:) = pi(:)';
end

end