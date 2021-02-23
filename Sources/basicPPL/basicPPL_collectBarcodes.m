clearvars

fpathIn = 'Service/GlobalStructure/3.Barcodes/txt/';
fpathOut = 'Service/GlobalStructure/3.Barcodes/mat/';

load(['Service/GlobalStructure/0.Info/Settings/dataset_current.mat']);


disp('******************** Barcodes collection');

for k = 1:length(dataset)
    fIn = [fpathIn dataset{k}];
    [matrix,dts] = fileparts(dataset{k});
    load(['Service/GlobalStructure/0.Info/Info_' dts '.mat']);
    
    if strcmp(matrix(end-1:end),'FC')
        brcAdj = '';
    else
        brcAdj = '/Barcodes';
    end
    
    
    clear barcodes0 barcodes1;
    if strcmp(dts,'EEG_chb24')
        sbjSet = [1:10 17:26];
    else
        sbjSet = 1:nSegm;
    end
    
    for iS = 1:nSegm
        iSbj = sbjSet(iS);
        endpoints = load([fIn brcAdj '/Subject' mat2str(iSbj) '_dim0.txt'],'-ascii');
        ind = find(endpoints==Inf);
        endpoints(ind) = 1.1; %max(endpoints(:)+0.01);
        barcodes0{iS,1} = endpoints;

        endpoints = load([fIn brcAdj '/Subject' mat2str(iSbj) '_dim1.txt'],'-ascii');
        ind = find(endpoints==Inf);
        endpoints(ind) = 1.1; %max(endpoints(:)+0.01);
        barcodes1{iS,1} = endpoints;
    end
    
    fpathOutNow = [fpathOut dataset{k}];
    if ~isfolder(fpathOutNow)
        mkdir(fpathOutNow);
    end
    save([fpathOutNow '/EndPoints.mat'],'barcodes0','barcodes1','group1','group2','nSegm','labels');
    
    disp([dataset{k} ' barcodes txt to mat finished']);
end


