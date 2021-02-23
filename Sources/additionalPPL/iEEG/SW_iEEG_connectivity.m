clearvars;

fpathIn = '/mnt/data/MATLAB/Persistent_homology/Data/SWEC_iEEG/';

load([fpathIn 'SW_iEEG_data.mat']);

mark = '';

disp('******************* Full FC');
nSbj = length(dataSz);
for iP = 1:nSbj
    
    fcSz = corr(dataSz{iP});
    fcPre = corr(dataPre{iP});
    fcInter = corr(dataInter{iP});
    
%     [pre{iP},sz{iP}] = cleaningOfInterictal(fcPre,fcSz,fcInter);
    pre{iP} = abs(fcPre - fcInter);
    sz{iP} = abs(fcSz - fcInter);

    disp(iP);
    disp(corMatr(pre{iP},sz{iP}));
    disp(corMatr(fcSz,fcPre));
end
matrix = [sz pre];
save(['Service/SW_iEEG/Matrices/SW_iEEG_fullFC' mark '.mat'],'pre','sz','matrix')

disp('******************* Masked FC');
for iP = 1:nSbj
    
    [fcSz,pSz] = corr(dataSz{iP});
    [fcPre,pPre] = corr(dataPre{iP});
    [fcInter,pInter] = corr(dataInter{iP});
    
    fcSz(pSz>0.05) = 0; fcSz(fcSz<0) = 0;
    fcPre(pPre>0.05) = 0; fcPre(fcPre<0) = 0;
    fcInter(pInter>0.05) = 0; fcInter(fcInter<0) = 0;
    
%     [pre{iP},sz{iP}] = cleaningOfInterictal(fcPre,fcSz,fcInter);
    pre{iP} = abs(fcPre-fcInter);
    sz{iP} = abs(fcSz - fcInter);
    
    disp(iP);
    disp(corMatr(pre{iP},sz{iP}));
    disp(corMatr(fcSz,fcPre));
end
matrix = [sz pre];
save(['Service/SW_iEEG/Matrices/SW_iEEG_maskedFC' mark '.mat'],'pre','sz','matrix')


disp('******************* Full EC');
for iP = 1:nSbj
    
    ecInter = Granger_pairwise(dataInter{iP});
%     ecInter = dd(ecOriginal./(max(max(ecOriginal))+0.01),1);
    
    ecOriginal = abs(Granger_pairwise(dataSz{iP}) - ecInter);
    ecSz = dd(ecOriginal./(max(max(ecOriginal))+0.01),1);
    
    ecOriginal = abs(Granger_pairwise(dataPre{iP}) - ecInter);
    ecPre = dd(ecOriginal./(max(max(ecOriginal))+0.01),1);
        
%     [pre{iP},sz{iP}] = cleaningOfInterictal(ecPre,ecSz,ecInter);
%     inter{iP} = ecInter;
    pre{iP} = ecPre;
    sz{iP} = ecSz;

    disp(iP);
    disp(corMatr(pre{iP},sz{iP}));
    disp(max([ecSz(:);ecPre(:)]));
end
matrix = [sz pre];
save(['Service/SW_iEEG/Matrices/SW_iEEG_fullEC' mark '.mat'],'pre','sz','matrix')

disp('******************* Masked EC');
for iP = 1:nSbj
    
    F = runFACDA(regressOutGlobalSignal(dataSz{iP}(1:20:end,:)));
    ecSz = dd(pre{iP}).*F;
    
    F = runFACDA(regressOutGlobalSignal(dataPre{iP}(1:20:end,:)));
    ecPre = dd(sz{iP}).*F;
    
%     F = runFACDA(regressOutGlobalSignal(dataInter{iP}(1:20:end,:)));
%     ecInter = dd(inter{iP}).*F;
    
%     [pre{iP},sz{iP}] = cleaningOfInterictal(ecPre,ecSz,ecInter);
    pre{iP} = ecPre;
    sz{iP} = ecSz;

    disp(iP);
    disp(corMatr(pre{iP},sz{iP}));
    disp(max([ecSz(:);ecPre(:)]));
end
matrix = [sz pre];
save(['Service/SW_iEEG/Matrices/SW_iEEG_maskedEC' mark '.mat'],'pre','sz','matrix')


