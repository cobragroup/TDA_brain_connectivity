clearvars

fpathIn = 'Service/SW_iEEG/Features/';
fpathOut = 'Service/SW_iEEG/Classification/';


dimN = 'dim0';
featureSet = {'AUC','IPF','PE','CC','kernel'};

matrixTypeSet = {'fullFC','maskedFC','fullEC','maskedEC'};

for iM = 1:length(matrixTypeSet)
    matrixType = matrixTypeSet{iM};

    for iF = 1:length(featureSet)
        featureName = featureSet{iF};
        
        load([fpathIn dimN '/SW_iEEG_Feature_' featureName '_' matrixType '_' dimN '.mat']);

        disp([featureName ' ' dimN]);
        
        svm_results = SVM_FS_PCA_comb_test2(dataToSVM, labels, 'FS','leave2out');
        
        fpathOutNow = [fpathOut '/' dimN '/' ];
        if ~isfolder(fpathOutNow)
            mkdir(fpathOutNow);
        end
        save([fpathOutNow '/SW_iEEG_SVMresults_' featureName '_' matrixType '_' dimN '.mat'],...
            'dataToSVM','svm_results','labels','info');

    end
        
end

dimN = 'dim1';
featureSet = {'PI','PE','PL','CC','kernel'};

for iM = 1:length(matrixTypeSet)
    matrixType = matrixTypeSet{iM};

    for iF = 1:length(featureSet)
        featureName = featureSet{iF};
        
        load([fpathIn dimN '/SW_iEEG_Feature_' featureName '_' matrixType '_' dimN '.mat']);

        disp([featureName ' ' dimN]);
        
        svm_results = SVM_FS_PCA_comb_test2(dataToSVM, labels, 'FS','leave2out');
        
        fpathOutNow = [fpathOut '/' dimN '/' ];
        if ~isfolder(fpathOutNow)
            mkdir(fpathOutNow);
        end
        save([fpathOutNow '/SW_iEEG_SVMresults_' featureName '_' matrixType '_' dimN '.mat'],...
            'dataToSVM','svm_results','labels','info');

    end
        
end


