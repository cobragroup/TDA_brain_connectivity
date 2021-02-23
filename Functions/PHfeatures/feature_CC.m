function [dataToSVM,feature] = feature_CC(barcodes)

nSbj = length(barcodes);
for iSbj = 1:nSbj
    if ~isempty(barcodes{iSbj})
        
        fCC(iSbj,1) = sum(barcodes{iSbj}(:,1).*(barcodes{iSbj}(:,2)-barcodes{iSbj}(:,1)))/length(barcodes{iSbj});
        fCC(iSbj,2) = sum((1-barcodes{iSbj}(:,2)).*(barcodes{iSbj}(:,2)-barcodes{iSbj}(:,1)))/length(barcodes{iSbj});
        fCC(iSbj,3) = sum((barcodes{iSbj}(:,1).^2).*((barcodes{iSbj}(:,2)-barcodes{iSbj}(:,1)).^4))/length(barcodes{iSbj});
        fCC(iSbj,4) = sum((1-barcodes{iSbj}(:,2)).^2.*(barcodes{iSbj}(:,2)-barcodes{iSbj}(:,1)).^4)/length(barcodes{iSbj});
        fCC(iSbj,5) = max(barcodes{iSbj}(:,2)-barcodes{iSbj}(:,1));
    else
        fCC(iSbj,1:5) = 0;
    end
end

%  dataSVM(1).mat = fCC;
for i = 1:size(fCC,2)
    dataToSVM(1).mat(:,i) = nrmlz01(fCC(:,i))';%(:,[1:5 7 9 11:12 14:17 19:end]));
end
feature = fCC;

end