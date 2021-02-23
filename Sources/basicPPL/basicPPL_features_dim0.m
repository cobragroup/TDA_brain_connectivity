clearvars

fpathIn = 'Service/GlobalStructure/3.Barcodes/mat/';
fpathOut = 'Service/GlobalStructure/4.Features/';


load(['Service/GlobalStructure/0.Info/Settings/dataset_current.mat']);
dimN = 'dim0';

disp('******************** Features calculation: dim0');



for k = 1:length(dataset)
    fIn = [fpathIn dataset{k}];
    [matrix,dts] = fileparts(dataset{k});
    load(['Service/GlobalStructure/0.Info/Info_' dts '.mat']);
    load([fpathIn dataset{k} '/EndPoints.mat']);
    load(['Service/GlobalStructure/0.Info/Demean_info.mat']);
    load(['Service/GlobalStructure/0.Info/UniformMarginals_info.mat']);
    
    demeanFlag = demean.(dts);
    uniMarginal = uMarginal.(dts);
    
    info.data = dts;
    info.matrix = matrix;
    info.dim = dimN;
    info.demean = demeanFlag;
    
    % AUC
    disp([dataset{k} ' AUC ' dimN]);

    [dataToSVM,feature] = feature_AUC(barcodes0);
    if uniMarginal
        for iFtr = 1:size(dataToSVM.mat,2)
             dataToSVM.mat(:,iFtr) = marginalUniform(dataToSVM.mat(:,iFtr));
        end
    end
    
    if demeanFlag
        meanVal = mean([dataToSVM.mat(1:nIll,:),dataToSVM.mat(1+nIll:end,:)],2);
        dataToSVM.mat = dataToSVM.mat - [meanVal; meanVal];
    end
    info.feature = 'AUC';

    fpathOutNow = [fpathOut dataset{k} '/' dimN '/AUC/'];
    if ~isfolder(fpathOutNow)
        mkdir(fpathOutNow);
    end
    save([fpathOutNow '/Feature.mat'],'dataToSVM','feature','labels','info');

    % IPF slope
    disp([dataset{k} ' IPF ' dimN]);    
    [dataToSVM,feature] = feature_IPF(barcodes0);
    if uniMarginal
        for iFtr = 1:size(dataToSVM.mat,2)
             dataToSVM.mat(:,iFtr) = marginalUniform(dataToSVM.mat(:,iFtr));
        end
    end

    if demeanFlag
        meanVal = mean([dataToSVM.mat(1:nIll,:),dataToSVM.mat(1+nIll:end,:)],2);
        dataToSVM.mat = dataToSVM.mat - [meanVal; meanVal];
    end
    info.feature = 'IPF';
    
    fpathOutNow = [fpathOut dataset{k} '/' dimN '/IPF/'];
    if ~isfolder(fpathOutNow)
        mkdir(fpathOutNow);
    end
    save([fpathOutNow '/Feature.mat'],'dataToSVM','feature','labels','info');
    
    
    % PE
    disp([dataset{k} ' PE ' dimN]);    
    [dataToSVM,feature] = feature_PE(barcodes0);
    if uniMarginal
        for iFtr = 1:size(dataToSVM.mat,2)
             dataToSVM.mat(:,iFtr) = marginalUniform(dataToSVM.mat(:,iFtr));
        end
    end

    if demeanFlag
        meanVal = mean([dataToSVM.mat(1:nIll,:),dataToSVM.mat(1+nIll:end,:)],2);
        dataToSVM.mat = dataToSVM.mat - [meanVal; meanVal];
    end
    info.feature = 'PE';
     
    fpathOutNow = [fpathOut dataset{k} '/' dimN  '/PE/'];
    if ~isfolder(fpathOutNow)
        mkdir(fpathOutNow);
    end
    save([fpathOutNow '/Feature.mat'],'dataToSVM','feature','labels','info');    
    
    % PL
    disp([dataset{k} ' PL ' dimN]);    
    [dataToSVM,feature] = feature_PL(barcodes0);
    if uniMarginal
        for iFtr = 1:size(dataToSVM.mat,2)
             dataToSVM.mat(:,iFtr) = marginalUniform(dataToSVM.mat(:,iFtr));
        end
    end

    if demeanFlag
        meanVal = mean([dataToSVM.mat(1:nIll,:),dataToSVM.mat(1+nIll:end,:)],2);
        dataToSVM.mat = dataToSVM.mat - [meanVal; meanVal];
    end
    info.feature = 'PL';
    
    fpathOutNow = [fpathOut dataset{k} '/' dimN  '/PL/'];
    if ~isfolder(fpathOutNow)
        mkdir(fpathOutNow);
    end
    save([fpathOutNow '/Feature.mat'],'dataToSVM','feature','labels','info');    
    
    % CC
    disp([dataset{k} ' CC ' dimN]);     
    [dataToSVM,feature] = feature_CC(barcodes0);
    if uniMarginal
        for iFtr = 1:size(dataToSVM.mat,2)
             dataToSVM.mat(:,iFtr) = marginalUniform(dataToSVM.mat(:,iFtr));
        end
    end

    if demeanFlag
        meanVal = mean([dataToSVM.mat(1:nIll,:),dataToSVM.mat(1+nIll:end,:)],2);
        dataToSVM.mat = dataToSVM.mat - [meanVal; meanVal];
    end
    info.feature = 'CC';    
    
    fpathOutNow = [fpathOut dataset{k} '/' dimN  '/CC/'];
    if ~isfolder(fpathOutNow)
        mkdir(fpathOutNow);
    end
    save([fpathOutNow '/Feature.mat'],'dataToSVM','feature','labels','info');    
   

    % Kernel
    disp([dataset{k} ' kernel ' dimN]);     
    [dataToSVM,feature] = feature_kernel(barcodes0);
    if uniMarginal
        for iFtr = 1:size(dataToSVM.mat,2)
             dataToSVM.mat(:,iFtr) = marginalUniform(dataToSVM.mat(:,iFtr));
        end
    end

    if demeanFlag
        meanVal = mean([dataToSVM.mat(1:nIll,:),dataToSVM.mat(1+nIll:end,:)],2);
        dataToSVM.mat = dataToSVM.mat - [meanVal; meanVal];
    end
    info.feature = 'kernel';
    
    fpathOutNow = [fpathOut dataset{k} '/' dimN  '/kernel/'];
    if ~isfolder(fpathOutNow)
        mkdir(fpathOutNow);
    end
    save([fpathOutNow '/Feature.mat'],'dataToSVM','feature','labels','info');    
   
    
    
end


