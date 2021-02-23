clearvars

fpathIn = 'Service/PaperUpd/EEG_1sz/Features/';
fpathOut = 'Service/PaperUpd/EEG_1sz/Classification/';


dimN = 'dim0';
featureSet = {'AUC','IPF','PE','CC','kernel'};

dts = 'EEG_1sz';

matrixTypeSet = {'fullFC','maskedFC'};

for iM = 1:length(matrixTypeSet)
    matrixType = matrixTypeSet{iM};

    for iF = 1:length(featureSet)
        featureName = featureSet{iF};
        
        load([fpathIn dimN '/' dts '_Feature_' featureName '_' matrixType '_' dimN '.mat']);

        disp([featureName ' ' dimN]);
        
        svm_results = SVM_FS_PCA_comb(dataToSVM, labels, 'FS');
        
        fpathOutNow = [fpathOut '/' dimN '/' ];
        if ~isfolder(fpathOutNow)
            mkdir(fpathOutNow);
        end
        save([fpathOutNow '/' dts '_SVMresults_' featureName '_' matrixType '_' dimN '.mat'],...
            'dataToSVM','svm_results','labels','info');

    end
        
end

dimN = 'dim1';
featureSet = {'PI','PE','PL','CC','kernel'};

for iM = 1:length(matrixTypeSet)
    matrixType = matrixTypeSet{iM};

    for iF = 1:length(featureSet)
        featureName = featureSet{iF};
        
        load([fpathIn dimN '/' dts '_Feature_' featureName '_' matrixType '_' dimN '.mat']);

        disp([featureName ' ' dimN]);
        
        svm_results = SVM_FS_PCA_comb(dataToSVM, labels, 'FS');
        
        fpathOutNow = [fpathOut '/' dimN '/' ];
        if ~isfolder(fpathOutNow)
            mkdir(fpathOutNow);
        end
        save([fpathOutNow '/' dts '_SVMresults_' featureName '_' matrixType '_' dimN '.mat'],...
            'dataToSVM','svm_results','labels','info');

    end
        
end

clear dataToSVM;
for iM = 1:length(matrixTypeSet)
    matrixType = matrixTypeSet{iM};
    
    load(['Service/PaperUpd/EEG_1sz/Matrices/EEG_1sz_' matrixType '.mat']);
    for i = 1:length(matrix)
        tt = matrix{i};
        dataToSVM.mat(i,:) = tt(:)';
    end
    svm_results = SVM_FS_PCA_comb(dataToSVM, labels, 'FS');
 
    info.data = dts;
    info.matrix = matrixType;
    info.dim = 'naive';
    info.feature = 'naive';
    
    fpathOutNow = [fpathOut '/naive/' ];
    if ~isfolder(fpathOutNow)
        mkdir(fpathOutNow);
    end
    save([fpathOutNow '/' dts '_SVMresults_naive_' matrixType '.mat'],...
        'dataToSVM','svm_results','labels','info');
end
