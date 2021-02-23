clearvars

fpathIn = 'Service/GlobalStructure/2.Matrices/';
fpathOut = 'Service/GlobalStructure/4.Features/';


load(['Service/GlobalStructure/0.Info/Settings/dataset_current.mat']);


disp('******************** Features calculation: naive matrices');



for k = 1:length(dataset)
    fIn = [fpathIn dataset{k}];
    [matrix,dts] = fileparts(dataset{k});
    load(['Service/GlobalStructure/0.Info/Info_' dts '.mat']);
    load([fpathIn dataset{k} '/matrix.mat']);

    info.data = dts;
    info.matrix = matrix;
    info.dim = 'dim1';

    % PI
    [dataToSVM,feature] = feature_naive(matrix(:,:,1:nSegm));
    info.feature = 'naive';
    
    fpathOutNow = [fpathOut dataset{k} '/naive/'];
    if ~isfolder(fpathOutNow)
        mkdir(fpathOutNow);
    end
    save([fpathOutNow '/Feature.mat'],'dataToSVM','feature','labels','info');
    disp([dataset{k} ' done']);
    
     
end


