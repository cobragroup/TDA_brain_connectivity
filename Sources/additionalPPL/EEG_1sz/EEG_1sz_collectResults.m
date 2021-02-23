
clearvars

fpathIn = 'Service/PaperUpd/EEG_1sz/Classification/';

cnt = 1;
result{1,1} = 'Dataset';
result{1,2} = 'Connectivity';
result{1,3} = 'Dimension';
result{1,4} = 'Feature';
result{1,5} = 'Accuracy';
result{1,6} = 'Sensitivity';
result{1,7} = 'Specificity';

dts = 'EEG_1sz';

matrixTypeSet = {'fullFC','maskedFC','fullEC'};%,'maskedEC'};
featureSet = {'AUC','IPF','PE','CC','kernel'};

for iM = 1:length(matrixTypeSet)
    matrixType = matrixTypeSet{iM};

    load([fpathIn '/naive/' dts '_SVMresults_naive_' matrixType '.mat']);
    cnt = cnt+1;
    result{cnt,1} = dts;
    result{cnt,2} = matrixType;
    result{cnt,3} = 'naive';
    result{cnt,4} = 'naive';
    result{cnt,5} = svm_results.diagACCUR.over_ac;
    result{cnt,6} = svm_results.diagACCUR.sens;
    result{cnt,7} = svm_results.diagACCUR.spec;

end

dimN = 'dim0';
for iM = 1:length(matrixTypeSet)
    matrixType = matrixTypeSet{iM};
    
    for iF = 1:length(featureSet)
        featureName = featureSet{iF};
        
        load([fpathIn '/' dimN '/' dts '_SVMresults_' featureName '_' matrixType '_' dimN '.mat']);
        cnt = cnt+1;
        result{cnt,1} = dts;
        result{cnt,2} = matrixType;
        result{cnt,3} = dimN;
        result{cnt,4} = featureName;
        result{cnt,5} = svm_results.diagACCUR.over_ac;
        result{cnt,6} = svm_results.diagACCUR.sens;
        result{cnt,7} = svm_results.diagACCUR.spec;
        
    end
        
end


dimN = 'dim1';
featureSet = {'PI','PE','PL','CC','kernel'};

for iM = 1:length(matrixTypeSet)
    matrixType = matrixTypeSet{iM};
    
    for iF = 1:length(featureSet)
        featureName = featureSet{iF};
        
        load([fpathIn '/' dimN '/' dts '_SVMresults_' featureName '_' matrixType '_' dimN '.mat']);
        cnt = cnt+1;
        result{cnt,1} = dts;
        result{cnt,2} = matrixType;
        result{cnt,3} = dimN;
        result{cnt,4} = featureName;
        result{cnt,5} = svm_results.diagACCUR.over_ac;
        result{cnt,6} = svm_results.diagACCUR.sens;
        result{cnt,7} = svm_results.diagACCUR.spec;
        
    end
        
end

save([fpathIn 'Classification_current.mat'],'result');
writecell(result,[fpathIn 'Classification_current.csv']);


















