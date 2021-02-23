clearvars;

fpathIn = '/mnt/data/MATLAB/Shared/Data/SWEC-ETHZ_iEEG/';
fpathOut = '/mnt/data/MATLAB/Persistent_homology/Data/SWEC_iEEG/';

patSet = {'ID01','ID02','ID03','ID04','ID05','ID06','ID07','ID08','ID09','ID10','ID11',...
    'ID12','ID13','ID14','ID15','ID16'};

fs = 512;

for iP = 1:length(patSet)
    pat = patSet{iP};
    disp(pat);

    if isfolder([fpathIn pat])
        load([fpathIn pat '/Sz1.mat']);
    else
        load([fpathIn pat 'a/Sz1.mat']);
    end

    szStart = fs*3*60;
    szEnd = size(EEG,1) - fs*3*60;
    szDuration = fs*30; 
    interDuration = fs*1*60;

    dataSz{iP,1} = EEG(szStart:szEnd,:);
    dataPre{iP,1} = EEG(interDuration*2:2*interDuration+szDuration,:);
    
    dataInter{iP,1} = EEG(1:interDuration,:);
    
    disp(szDuration/(fs*60));
    
end

save([fpathOut 'SW_iEEG_data.mat'],'dataSz','dataPre','dataInter');





