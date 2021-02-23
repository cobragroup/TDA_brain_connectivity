clearvars

fpathIn = 'Service/GlobalStructure/2.Matrices/';
fpathOut = 'Service/GlobalStructure/3.Barcodes/txt/';

fpathBr = 'Service/GlobalStructure/3.Barcodes/py_barcodes/';

load(['Service/GlobalStructure/0.Info/Settings/dataset_current.mat']);

disp('******************** PH computation: FC (Ripser)');

for k = 1:length(dataset)
    fIn = [fpathIn dataset{k}];
    [matrixNm,dts] = fileparts(dataset{k});

    load([fpathIn dataset{k} '/matrix.mat']);

    save([fpathBr 'matrix.mat'],'matrix');
    
    if strcmp(matrixNm(end-1:end),'FC')    
        commandStr = 'python /mnt/data/MATLAB/Persistent_homology/Service/GlobalStructure/3.Barcodes/py_barcodes/Barcodes_FC_Ripser.py';
        [status,commandOut] = system(commandStr);
        
        ffrom = [fpathBr 'Barcodes/Sub*'];
        fto = [fpathOut dataset{k} '/'];
        copyfile(ffrom,fto);
        delete(ffrom);
        
        disp([dataset{k} ' PH computation finished']);
        
%     elseif strcmp(matrix(end-1:end),'EC')  
%         commandStr = 'python /home/anna/Documents/MATLAB/Persistent_homology/Service/GlobalStructure/3.Barcodes/py_barcodes/Barcodes_EC_Flagser.py';
%         [status,commandOut] = system(commandStr);
%         
%         ffrom = [fpathBr 'Barcodes/Sub*'];
%         fto = [fpathOut dataset{k} '/'];
%         copyfile(ffrom,fto);
%         delete(ffrom);
         
    end   
     
end


