
demean.EEG_1sz = 1;
demean.EEG_chb06 = 0;
demean.EEG_chb15 = 0;
demean.EEG_chb24 = 0;
demean.EEG_equal = 0;
demean.ESO190 = 0;

save(['Service/GlobalStructure/0.Info/Demean_info.mat'],'demean');

uMarginal.EEG_1sz = 0;
uMarginal.EEG_chb06 = 0;
uMarginal.EEG_chb15 = 0;
uMarginal.EEG_chb24 = 0;
uMarginal.EEG_equal = 0;
uMarginal.ESO190 = 0;

save(['Service/GlobalStructure/0.Info/UniformMarginals_info.mat'],'uMarginal');








