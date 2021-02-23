
clearvars;

load('Service/GlobalStructure/1.TimeSeries/pre/ESO190_aal_strin_90_deconv.mat', 'subj_tcs')
for i = 1:size(subj_tcs,3)
    ts{i,1} = subj_tcs(:,:,i);
end

save('Service/GlobalStructure/1.TimeSeries/ESO190.mat','ts');


markSet = {'chb06','chb15','chb24','cut'};
for iM = 1:length(markSet)
    mark = markSet{iM};
    
    load(['Service/GlobalStructure/1.TimeSeries/pre/ictal_' mark '_filt50Hz.mat'])
    load(['Service/GlobalStructure/1.TimeSeries/pre/interictal_' mark '_filt50Hz.mat'])
    ts = [dataSz'; dataPre'];
    if iM == 4
        mark = 'group';
    end
    save(['Service/GlobalStructure/1.TimeSeries/EEG_' mark '.mat'],'ts');

end






