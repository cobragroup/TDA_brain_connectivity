function [dataToSVM,feature] = feature_IPF(barcode)

nSbj = length(barcode);
for iSbj = 1:length(barcode)
    if ~isempty(barcode{iSbj})
        filt{iSbj} = barcode{iSbj}(:,2);
        beti0{iSbj} = [length(filt{iSbj}):-1:1]';

        X = [ones(length(filt{iSbj}),1) filt{iSbj}];

        agg = sum(filt{iSbj})-cumsum(filt{iSbj});
        gamma1 = beti0{iSbj}.*agg;
        m = length(filt{iSbj});
        IPF{iSbj} = gamma1/(m*(m-1));

        lrCoef = X\IPF{iSbj};
        lrCoef2 = X\beti0{iSbj};
        slope(iSbj,1) = lrCoef(2);
    else
        slope(iSbj,1) = 0;
    end
end

dataToSVM.mat = slope;
feature = slope;

end