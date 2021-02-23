function [dataToSVM,feature] = feature_kernel(barcode)

nSbj = length(barcode);
K = zeros(nSbj,nSbj);
sigma = 0.05;
for iSbj = 1:nSbj
    for jSbj = 1:nSbj
        if ~isempty(barcode{iSbj})&&(length(barcode{iSbj})>2)
           if ~isempty(barcode{jSbj})&&(length(barcode{jSbj})>2)
               K(iSbj,jSbj) = kernelPH(barcode{iSbj},barcode{jSbj},sigma);
           else
               K(iSbj,jSbj) = 0;
           end
       else
           K(iSbj,jSbj) = 0;
        end
    end
%     disp(iSbj);
end

dataToSVM.mat = K;
feature = K;

end