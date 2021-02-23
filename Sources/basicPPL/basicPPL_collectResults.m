
clearvars

fpathIn = 'Service/GlobalStructure/5.Classification/';

load(['Service/GlobalStructure/0.Info/Settings/dataset_current.mat']);

dimN = 'dim0';
load(['Service/GlobalStructure/0.Info/Settings/feature_dim0_current.mat']);

cnt = 1;
result{1,1} = 'Dataset';
result{1,2} = 'Connectivity';
result{1,3} = 'Dimension';
result{1,4} = 'Feature';
result{1,5} = 'Accuracy';
result{1,6} = 'Sensitivity';
result{1,7} = 'Specificity';

for k = 1:length(dataset)
    fIn = [fpathIn dataset{k}];
    [matrix,dts] = fileparts(dataset{k});

%     for iF = 1:length(featureSet)
        featureName = 'naive';
        
        load([fpathIn dataset{k} '/naive/SVMresults.mat']);
        cnt = cnt+1;
        result{cnt,1} = dts;
        result{cnt,2} = matrix;
        result{cnt,3} = dimN;
        result{cnt,4} = featureName;
        result{cnt,5} = svm_results.diagACCUR.over_ac;
        result{cnt,6} = svm_results.diagACCUR.sens;
        result{cnt,7} = svm_results.diagACCUR.spec;
        
%     end
        
end


for k = 1:length(dataset)
    fIn = [fpathIn dataset{k}];
    [matrix,dts] = fileparts(dataset{k});

    for iF = 1:length(featureSet)
        featureName = featureSet{iF};
        
        load([fpathIn dataset{k} '/' dimN '/' featureName '/SVMresults.mat']);
        cnt = cnt+1;
        result{cnt,1} = dts;
        result{cnt,2} = matrix;
        result{cnt,3} = dimN;
        result{cnt,4} = featureName;
        result{cnt,5} = svm_results.diagACCUR.over_ac;
        result{cnt,6} = svm_results.diagACCUR.sens;
        result{cnt,7} = svm_results.diagACCUR.spec;
        
    end
        
end


dimN = 'dim1';
load(['Service/GlobalStructure/0.Info/Settings/feature_dim1_current.mat']);

for k = 1:length(dataset)
    fIn = [fpathIn dataset{k}];
    [matrix,dts] = fileparts(dataset{k});

    for iF = 1:length(featureSet)
        featureName = featureSet{iF};

        if exist([fpathIn dataset{k} '/' dimN '/' featureName '/SVMresults.mat'],'file')
            load([fpathIn dataset{k} '/' dimN '/' featureName '/SVMresults.mat']);
            cnt = cnt+1;
            result{cnt,1} = dts;
            result{cnt,2} = matrix;
            result{cnt,3} = dimN;
            result{cnt,4} = featureName;
            result{cnt,5} = svm_results.diagACCUR.over_ac;
            result{cnt,6} = svm_results.diagACCUR.sens;
            result{cnt,7} = svm_results.diagACCUR.spec;
        end
    end
        
end

save([fpathIn 'Classification_current.mat'],'result');
writecell(result,[fpathIn 'Classification_current.csv']);
% writecell(result,['/home/bublik/Dropbox/Luigi_topology/Classification.csv']);
% writecell(result,['/home/bublik/Dropbox/Luigi_topology/Classification_current.csv']);


















