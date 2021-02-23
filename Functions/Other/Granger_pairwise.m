function [grA,varA] = Granger_pairwise(data)

nCh = size(data,2);
% data1 = permute(data,[2 1 3]);
for i = 1:nCh-1
    for j = i+1:nCh
        data1 = [data(:,i) data(:,j)]';
        [grAt,varAt] = GCCA_tsdata_to_pwcgc(data1,1,'OLS');
        grA(i,j) = grAt(1,2);
        grA(j,i) = grAt(2,1);
        varA(i,j) = varAt(1,2);
        varA(j,i) = varAt(2,1);

    end
end

end

