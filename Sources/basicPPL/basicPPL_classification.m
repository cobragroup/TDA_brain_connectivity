clearvars

fpathIn = 'Service/GlobalStructure/4.Features/';
fpathOut = 'Service/GlobalStructure/5.Classification/';

load(['Service/GlobalStructure/0.Info/Settings/dataset_current.mat']);

for k = 1:length(dataset)
    fIn = [fpathIn dataset{k}];
    featureName = 'naive';
  
        load([fpathIn dataset{k} '/' featureName '/Feature.mat']);

        disp([dataset{k} ' ' featureName]);
        
        svm_results = SVM_FS_PCA_comb_test2(dataToSVM, labels, 'FS','leave2out');
        
        fpathOutNow = [fpathOut dataset{k} '/' featureName];
        if ~isfolder(fpathOutNow)
            mkdir(fpathOutNow);
        end
        save([fpathOutNow '/SVMresults.mat'],'dataToSVM','svm_results','labels','info');
        
          
end


dimN = 'dim0';
load(['Service/GlobalStructure/0.Info/Settings/feature_dim0_current.mat']);

for k = 1:length(dataset)
    fIn = [fpathIn dataset{k}];

    for iF = 1:length(featureSet)
        featureName = featureSet{iF};
        
        load([fpathIn dataset{k} '/' dimN '/' featureName '/Feature.mat']);

        disp([dataset{k} ' ' featureName ' ' dimN]);
        
        svm_results = SVM_FS_PCA_comb_test2(dataToSVM, labels, 'FS','leave2out');
        
        fpathOutNow = [fpathOut dataset{k} '/' dimN '/' featureName];
        if ~isfolder(fpathOutNow)
            mkdir(fpathOutNow);
        end
        save([fpathOutNow '/SVMresults.mat'],'dataToSVM','svm_results','labels','info');

    end
        
end

dimN = 'dim1';
load(['Service/GlobalStructure/0.Info/Settings/feature_dim1_current.mat']);

for k = 1:length(dataset)
    fIn = [fpathIn dataset{k}];

    for iF = 1:length(featureSet)
        featureName = featureSet{iF};
        
        if exist([fpathIn dataset{k} '/' dimN '/' featureName '/Feature.mat'],'file')
            load([fpathIn dataset{k} '/' dimN '/' featureName '/Feature.mat']);

            disp([dataset{k} ' ' featureName ' ' dimN]);

            svm_results = SVM_FS_PCA_comb_test2(dataToSVM, labels, 'FS','leave2out');

            fpathOutNow = [fpathOut dataset{k} '/' dimN '/' featureName];
            if ~isfolder(fpathOutNow)
                mkdir(fpathOutNow);
            end
            save([fpathOutNow '/SVMresults.mat'],'dataToSVM','svm_results','labels','info');
        end
    end
        
end


