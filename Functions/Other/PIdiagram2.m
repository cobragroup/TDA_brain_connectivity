function [piDiagram] = PIdiagram2(sbj,fpathOut,displayFigure,group1,group2)

if nargin<2
    displayFigure = 0;
end

nSbj = length(sbj);
for iSbj = 1:nSbj
    if ~isempty(sbj{iSbj})
        max_Birth(iSbj) = max(sbj{iSbj}(:,1));
        max_Pers(iSbj) = max(sbj{iSbj}(:,2) - sbj{iSbj}(:,1));
    end
end

res = 50; %
sig = 0.0001;%(.5*max(max_Pers))/res;
% sig = min(max_Pers)/(20*res);

params = [0,max(max_Pers)];
weight_func=@linear_ramp;

absMaxBirth = max(max_Birth);
absMaxPers = max(max_Pers);
absHk = [absMaxBirth absMaxPers];

for iSbj = 1:nSbj
    if ~isempty(sbj{iSbj})    
        intervals = {sbj{iSbj}};
        b_p_data = birth_persistence_coordinates(intervals, absMaxBirth, absMaxPers);
        [PIs(:,iSbj)] =  hard_bound_PIs(b_p_data,absHk, weight_func, params, res,sig); 
        piDiagram(:,:,iSbj)=PIs{iSbj};
    else
        piDiagram(1:res,1:res,iSbj) = 0;
    end
end
disp('Absolut values finished');
Abs_data = piDiagram;

if ~isempty(fpathOut)
    save([fpathOut 'piDiagram.mat'],'piDiagram','absMaxBirth','absMaxPers');
end
    
if displayFigure
    fig = figure('pos',[10 10 1000 450]); 
    subplot(1,2,1); imagesc(mean(Abs_data(:,:,group1),3)); title('Pi, group1');
    subplot(1,2,2); imagesc(mean(Abs_data(:,:,group2),3)); title('Pi, group2');
end

end