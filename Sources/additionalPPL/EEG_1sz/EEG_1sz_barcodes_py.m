clearvars

fpathIn = 'Service/PaperUpd/EEG_1sz/Matrices/';
fpathOut = 'Service/PaperUpd/EEG_1sz/Barcodes/';

fpathBr = 'Service/Ripser_calculations/';

matrixTypeSet = {'fullFC','maskedFC'};

for iM = 1:length(matrixTypeSet)
    matrixType = matrixTypeSet{iM};
        
    load([fpathIn '/EEG_1sz_' matrixType '.mat']);

    for iP = 1:length(pre)

        matrix = sz{iP};
        save([fpathBr 'matrix.mat'],'matrix');

        commandStr = 'python /mnt/data/MATLAB/Persistent_homology/Service/Ripser_calculations/Barcodes_FC_Ripser.py';
        [status,commandOut] = system(commandStr);

        endpoints = load([fpathBr 'Barcodes/Subject1_dim0.txt'],'-ascii');
        ind = find(endpoints==Inf);
        endpoints(ind) = 1.1; %max(endpoints(:)+0.01);
        barcodes0{iP,1} = endpoints;

        endpoints = load([fpathBr 'Barcodes/Subject1_dim1.txt'],'-ascii');
        ind = find(endpoints==Inf);
        endpoints(ind) = 1.1; %max(endpoints(:)+0.01);
        barcodes1{iP,1} = endpoints;    



        matrix = pre{iP};
        save([fpathBr 'matrix.mat'],'matrix');

        commandStr = 'python /mnt/data/MATLAB/Persistent_homology/Service/Ripser_calculations/Barcodes_FC_Ripser.py';
        [status,commandOut] = system(commandStr);

        endpoints = load([fpathBr 'Barcodes/Subject1_dim0.txt'],'-ascii');
        ind = find(endpoints==Inf);
        endpoints(ind) = 1.1; %max(endpoints(:)+0.01);
        barcodes0{iP+length(pre),1} = endpoints;

        endpoints = load([fpathBr 'Barcodes/Subject1_dim1.txt'],'-ascii');
        ind = find(endpoints==Inf);
        endpoints(ind) = 1.1; %max(endpoints(:)+0.01);
        barcodes1{iP+length(pre),1} = endpoints;    

        disp(iP);

    end

    save([fpathOut 'EEG_1sz_barcodes_' matrixType '.mat'],'barcodes0','barcodes1');

end