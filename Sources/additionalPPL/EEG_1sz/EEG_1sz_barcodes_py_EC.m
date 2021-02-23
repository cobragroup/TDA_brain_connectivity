clearvars

fpathIn = 'Service/PaperUpd/EEG_1sz/Matrices/';
fpathOut = 'Service/PaperUpd/EEG_1sz/Barcodes/';

fpathBr = 'Service/PaperUpd/EEG_1sz/Barcodes/';

matrixTypeSet = {'fullEC','maskedEC'};

for iM = 1:length(matrixTypeSet)
    matrixType = matrixTypeSet{iM};
        
    for iP = 1:36

%        matrix = sz{iP};
%        save([fpathBr 'matrix.mat'],'matrix');

%        commandStr = 'python /mnt/data/MATLAB/Persistent_homology/Service/Ripser_calculations/Barcodes_FC_Ripser.py';
%        [status,commandOut] = system(commandStr);

        endpoints = load([fpathBr '/' matrixType '/EEG_1sz/Barcodes/Subject' mat2str(iP) '_dim0.txt'],'-ascii');
        ind = find(endpoints==Inf);
        endpoints(ind) = 1.1; %max(endpoints(:)+0.01);
        barcodes0{iP,1} = endpoints;

        endpoints = load([fpathBr '/' matrixType '/EEG_1sz/Barcodes/Subject' mat2str(iP) '_dim1.txt'],'-ascii');
        ind = find(endpoints==Inf);
        endpoints(ind) = 1.1; %max(endpoints(:)+0.01);
        barcodes1{iP,1} = endpoints;    


        disp(iP);

    end

    save([fpathOut 'EEG_1sz_barcodes_' matrixType '.mat'],'barcodes0','barcodes1');

end
