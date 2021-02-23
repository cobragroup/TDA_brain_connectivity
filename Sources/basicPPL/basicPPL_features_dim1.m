clearvars

fpathIn = 'Service/GlobalStructure/3.Barcodes/mat/';
fpathOut = 'Service/GlobalStructure/4.Features/';

load(['Service/GlobalStructure/0.Info/Settings/dataset_current.mat']);

dimN = 'dim1';

disp('******************** Features calculation: dim1');



for k = 1:length(dataset)
    fIn = [fpathIn dataset{k}];
    [matrix,dts] = fileparts(dataset{k});
    load(['Service/GlobalStructure/0.Info/Info_' dts '.mat']);
    load([fpathIn dataset{k} '/EndPoints.mat']);
    load(['Service/GlobalStructure/0.Info/Demean_info.mat']);
    load(['Service/GlobalStructure/0.Info/UniformMarginals_info.mat']);
    
    demeanFlag = demean.(dts);      % flag if to demean features 
    uniMarginal = uMarginal.(dts);  % flag if to make marginals uniform (for this analysis - NO)
    
    info.data = dts;            % Dataset mark
    info.matrix = matrix;       % Connectivity type
    info.dim = dimN;            % dimension 0 or 1 (for this script it's 'dim1')
    info.demean = demeanFlag;   % flag if to demean features 

   
    % PI
    disp([dataset{k} ' PI ' dimN]);    
    [dataToSVM,feature] = feature_PI(barcodes1);
    if uniMarginal
        for iFtr = 1:size(dataToSVM.mat,2)
             dataToSVM.mat(:,iFtr) = marginalUniform(dataToSVM.mat(:,iFtr));
        end
    end

    if demeanFlag
        meanVal = mean([dataToSVM.mat(1:nIll,:),dataToSVM.mat(1+nIll:end,:)],2);
        dataToSVM.mat = dataToSVM.mat - [meanVal; meanVal];
    end        
    info.feature = 'PI';

    fpathOutNow = [fpathOut dataset{k} '/' dimN '/PI/'];
    if ~isfolder(fpathOutNow)
        mkdir(fpathOutNow);
    end
    save([fpathOutNow '/Feature.mat'],'dataToSVM','feature','labels','info');

    % PE
    disp([dataset{k} ' PE ' dimN]);    
    [dataToSVM,feature] = feature_PE(barcodes1);
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
    [dataToSVM,feature] = feature_PL(barcodes1);
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
    [dataToSVM,feature] = feature_CC(barcodes1);
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
    [dataToSVM,feature] = feature_kernel(barcodes1);
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


