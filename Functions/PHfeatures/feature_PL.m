function [dataToSVM,feature] = feature_PL(barcodes)

nSbj = length(barcodes);
K = 1; % Landscape number
points = [];
lenS = 0;
for iSbj = 1:nSbj
    if ~isempty(barcodes{iSbj})
        pl{iSbj,1} = persistenceLandscape(barcodes{iSbj});
        points = unique([points; pl{iSbj}(K).L(:,1)]);
        if length(pl{iSbj,1})>lenS
            lenS = length(pl{iSbj,1});
        end
    else
        pl{iSbj,1} = [];
    end
end

for iSbj = 1:nSbj
    if ~isempty(pl{iSbj})
        lanVal(:,iSbj) = landscapeValue(points,pl{iSbj}(K).L);
    else
        lanVal(1:lenS,iSbj) = 0;
    end
end

dataToSVM.mat = lanVal';
feature = lanVal;

end