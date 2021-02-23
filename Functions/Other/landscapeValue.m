function [lanVal] = landscapeValue(points,edges)

% binInd = @(x,edges) floor(interp1(edges,1:length(edges),x,'linear','extrap'));

% segmentIndex = binInd(points,edges(:,1));
segmentIndex = discretize(points,edges(:,1));

segmentIndex(isnan(segmentIndex)) = 0;
segmentIndex(segmentIndex<1) = size(edges,1);
segmentIndex(segmentIndex>length(points)) = size(edges,1);

edges = [edges; edges(end,:); edges(end,:)];

lanVal = arrayfun(@(k) lineSegment(points(k),edges(segmentIndex(k),:),edges(segmentIndex(k)+1,:)),...
    1:length(points));

end









