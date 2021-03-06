clearvars

demean = 1;

fpathIn = 'Service/SW_iEEG/Barcodes/';
fpathOut = 'Service/SW_iEEG/Features/';

dimN = 'dim0';

disp('******************** Features calculation: dim0');

dts = 'SW_iEEG';

matrixTypeSet = {'fullEC','maskedEC'};

for iM = 1:length(matrixTypeSet)
    matrixType = matrixTypeSet{iM};
    
    load(['Service/SW_iEEG/Info_' dts '.mat']);
    load([fpathIn 'SW_barcodes_' matrixType '.mat']);

    info.data = dts;
    info.matrix = matrixType;
    info.dim = dimN;

    % AUC
    disp([matrixType ' AUC ' dimN]);

    [dataToSVM,feature] = feature_AUC(barcodes0);
    
    if demean
        meanVal = mean([dataToSVM.mat(1:nIll,:),dataToSVM.mat(1+nIll:end,:)],2);
        dataToSVM.mat = dataToSVM.mat - [meanVal; meanVal];
    end

    
    info.feature = 'AUC';

    fpathOutNow = [fpathOut '/' dimN];
    if ~isfolder(fpathOutNow)
        mkdir(fpathOutNow);
    end
    save([fpathOutNow '/' dts '_Feature_' info.feature '_' matrixType '_' dimN '.mat'],...
        'dataToSVM','feature','labels','info');

    % IPF slope
    disp([matrixType ' IPF ' dimN]);    
    [dataToSVM,feature] = feature_IPF(barcodes0);
    
    if demean
        meanVal = mean([dataToSVM.mat(1:nIll,:),dataToSVM.mat(1+nIll:end,:)],2);
        dataToSVM.mat = dataToSVM.mat - [meanVal; meanVal];
    end

    
    info.feature = 'IPF';
    
    fpathOutNow = [fpathOut '/' dimN];
    if ~isfolder(fpathOutNow)
        mkdir(fpathOutNow);
    end
    save([fpathOutNow '/' dts '_Feature_' info.feature '_' matrixType '_' dimN '.mat'],...
        'dataToSVM','feature','labels','info');

    
    % PE
    disp([matrixType ' PE ' dimN]);    
    [dataToSVM,feature] = feature_PE(barcodes0);
    
    if demean
        meanVal = mean([dataToSVM.mat(1:nIll,:),dataToSVM.mat(1+nIll:end,:)],2);
        dataToSVM.mat = dataToSVM.mat - [meanVal; meanVal];
    end

    
    info.feature = 'PE';
     
    fpathOutNow = [fpathOut '/' dimN];
    if ~isfolder(fpathOutNow)
        mkdir(fpathOutNow);
    end
    save([fpathOutNow '/' dts '_Feature_' info.feature '_' matrixType '_' dimN '.mat'],...
        'dataToSVM','feature','labels','info');
    
    % PL
    disp([matrixType ' PL ' dimN]);    
    [dataToSVM,feature] = feature_PL(barcodes0);
    
    if demean
        meanVal = mean([dataToSVM.mat(1:nIll,:),dataToSVM.mat(1+nIll:end,:)],2);
        dataToSVM.mat = dataToSVM.mat - [meanVal; meanVal];
    end

    
    info.feature = 'PL';
    
    fpathOutNow = [fpathOut '/' dimN];
    if ~isfolder(fpathOutNow)
        mkdir(fpathOutNow);
    end
    save([fpathOutNow '/' dts '_Feature_' info.feature '_' matrixType '_' dimN '.mat'],...
        'dataToSVM','feature','labels','info');
    
    % CC
    disp([matrixType ' CC ' dimN]);     
    [dataToSVM,feature] = feature_CC(barcodes0);
    
    if demean
        meanVal = mean([dataToSVM.mat(1:nIll,:),dataToSVM.mat(1+nIll:end,:)],2);
        dataToSVM.mat = dataToSVM.mat - [meanVal; meanVal];
    end

    
    info.feature = 'CC';    
    
    fpathOutNow = [fpathOut '/' dimN];
    if ~isfolder(fpathOutNow)
        mkdir(fpathOutNow);
    end
    save([fpathOutNow '/' dts '_Feature_' info.feature '_' matrixType '_' dimN '.mat'],...
        'dataToSVM','feature','labels','info');
   

    % Kernel
    disp([matrixType ' kernel ' dimN]);     
    [dataToSVM,feature] = feature_kernel(barcodes0);
    
    if demean
        meanVal = mean([dataToSVM.mat(1:nIll,:),dataToSVM.mat(1+nIll:end,:)],2);
        dataToSVM.mat = dataToSVM.mat - [meanVal; meanVal];
    end

    info.feature = 'kernel';
    
    fpathOutNow = [fpathOut '/' dimN];
    if ~isfolder(fpathOutNow)
        mkdir(fpathOutNow);
    end
    save([fpathOutNow '/' dts '_Feature_' info.feature '_' matrixType '_' dimN '.mat'],...
        'dataToSVM','feature','labels','info');
    
    
end


