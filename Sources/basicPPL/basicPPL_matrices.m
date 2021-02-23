clearvars;

dtsSet = {'EEG_equal','EEG_chb06','EEG_chb15','EEG_chb24','ESO190'};

% Full FC
for iM = 1:length(dtsSet)
    dataset = dtsSet{iM};
    
    clear fcOriginal fc;
    load(['Service/GlobalStructure/1.TimeSeries/' dataset '.mat'])
 
    for iS = 1:length(ts)
        fcOriginal(:,:,iS) = corr(ts{iS});
        fc(:,:,iS) = dd(abs(fcOriginal(:,:,iS)),1);
    end
    
    matrix = fc;
    fpathOut = ['Service/GlobalStructure/2.Matrices/FullFC/' dataset '/'];
    mkdir(fpathOut);
    save([fpathOut 'matrix.mat'],'fc','fcOriginal','matrix');

end

% Masked FC
for iM = 1:length(dtsSet)
    dataset = dtsSet{iM};
    
    load(['Service/GlobalStructure/1.TimeSeries/' dataset '.mat'])
 
    clear fcOriginal fc tmp pVal;
    for iS = 1:length(ts)
        [fcOriginal(:,:,iS),pVal(:,:,iS)] = corr(ts{iS});
        tmp = fcOriginal(:,:,iS);
        tmp(pVal(:,:,iS)>0.05) = 0;
        tmp(tmp<0) = 0;
        tmp = dd(tmp,1);
        fc(:,:,iS) = tmp;
    end
    
    matrix = fc;
    fpathOut = ['Service/GlobalStructure/2.Matrices/MaskedFC/' dataset '/'];
    mkdir(fpathOut);
    save([fpathOut 'matrix.mat'],'fc','fcOriginal','pVal','matrix');

end


% Full EC
for iM = 1:length(dtsSet)
    dataset = dtsSet{iM};
    
    load(['Service/GlobalStructure/1.TimeSeries/' dataset '.mat'])
 
    clear ecOriginal ec;
    for iS = 1:length(ts)
        tsf = regressOutGlobalSignal(ts{iS});
        ecOriginal(:,:,iS) = Granger_pairwise(tsf);
        ec(:,:,iS) = dd(ecOriginal(:,:,iS)./(max(max(ecOriginal(:,:,iS)))+0.01),1);
        disp(find(ec(:,:,iS)>1));
        disp(iS);
    end
    
    matrix = ec;
    fpathOut = ['Service/GlobalStructure/2.Matrices/FullEC/' dataset '/'];
    mkdir(fpathOut);
    save([fpathOut 'matrix.mat'],'ec','ecOriginal','matrix');

end



% Mask EC
for iM = 1:length(dtsSet)
    dataset = dtsSet{iM};
    
    load(['Service/GlobalStructure/1.TimeSeries/' dataset '.mat'])
    load(['Service/GlobalStructure/2.Matrices/FullEC/' dataset '/matrix.mat'])
    ecFull = ec;
        
    clear F;
    for iS = 1:length(ts)
        tsf = regressOutGlobalSignal(ts{iS});
        F(:,:,iS) = runFACDA(tsf);
        
        ec(:,:,iS) = dd(ecFull(:,:,iS)).*F(:,:,iS);
        disp(iS);
    end
    
    matrix = ec;
    fpathOut = ['Service/GlobalStructure/2.Matrices/MaskedEC/' dataset '/'];
    mkdir(fpathOut);
    save([fpathOut 'matrix.mat'],'ec','ecOriginal','F','matrix');

end


