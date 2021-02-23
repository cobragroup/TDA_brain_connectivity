
mark = 'ESO190';

nSegm = 180;
nIll = 90;
nHealthy = 90;

group2 = 1:nHealthy; % for EEG it's group1 
group1 = nHealthy+1:nSegm;

labels = zeros(1,nSegm);
labels(group1) = 1;

save(['Service/GlobalStructure/0.Info/Info_' mark '.mat'],'nSegm','nIll','nHealthy','group1','group2','labels');











