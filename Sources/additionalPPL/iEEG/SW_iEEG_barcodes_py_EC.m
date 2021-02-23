clearvars

fpathIn = 'Service/SW_iEEG/Matrices/';
fpathOut = 'Service/SW_iEEG/Barcodes/';

fpathBr = 'Service/SW_iEEG/Barcodes/';

matrixTypeSet = {'FullEC','MaskedEC'};

for iM = 1:length(matrixTypeSet)
    matrixType = matrixTypeSet{iM};
        
    for iP = 1:32

%        matrix = sz{iP};
%        save([fpathBr 'matrix.mat'],'matrix');

%        commandStr = 'python /mnt/data/MATLAB/Persistent_homology/Service/Ripser_calculations/Barcodes_FC_Ripser.py';
%        [status,commandOut] = system(commandStr);

        endpoints = load([fpathBr '/' matrixType '_SW_iEEG/Barcodes/Subject' mat2str(iP) '_dim0.txt'],'-ascii');
        ind = find(endpoints==Inf);
        endpoints(ind) = 1.1; %max(endpoints(:)+0.01);
        barcodes0{iP,1} = endpoints;

        endpoints = load([fpathBr '/' matrixType '_SW_iEEG/Barcodes/Subject' mat2str(iP) '_dim1.txt'],'-ascii');
        ind = find(endpoints==Inf);
        endpoints(ind) = 1.1; %max(endpoints(:)+0.01);
        barcodes1{iP,1} = endpoints;    


        disp(iP);

    end

    save([fpathOut 'SW_barcodes_' matrixType '.mat'],'barcodes0','barcodes1');

end
