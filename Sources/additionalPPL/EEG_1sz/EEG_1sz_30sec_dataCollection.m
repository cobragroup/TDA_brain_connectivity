clearvars

[numSz,txtSz,rawSz] = xlsread('szStarts_1sz_30sec.xlsx');
load('electrodes.mat');

fs = 256;

for i = 1:length(txtSz)
    disp(i); clear dtt;
    dataT = readEDF([txtSz{i} '.edf']);
    dtt = cell2mat(dataT);
    
    if numSz(i,3)==1
        channels = 1:22;
    else
        channels = electrodes(1:22);
    end
    
    dtt = dtt(:,channels);
    for j = 1:size(dtt,2)
        dtt(:,j) = bandpass(dtt(:,j),[1 70],fs); 
    end
%     dtt = bandPassFilter(dtt,fs,[1 70]); 
    dtt = filt50Hz(dtt,fs);
 
    szInd = i;
    szSt = numSz(szInd,1);
    szEnd = szSt+30;
    szTime = szSt*fs:szEnd*fs;
    szDuration = (szEnd-szSt)*fs;
    
    preTime = szTime - 60*fs;
    interTime = szTime - 3*60*fs;
    
    dataSz{i,1} = dtt(szTime,:);
    dataPre{i,1} = dtt(preTime,:);
    dataInter{i,1} = dtt(interTime,:);
end

save('Service/ScalpEEG/Data/eeg_1sz_30sec.mat',...
    'dataSz','dataPre','dataInter','fs');


























