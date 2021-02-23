function [dataToSVM,feature] = feature_naive(matrix)

nSbj = size(matrix,3);
for iSbj = 1:nSbj
    fc = matrix(:,:,iSbj);
    mtr(iSbj,:) = fc(:);
end

dataToSVM.mat = mtr;
feature = matrix;

end