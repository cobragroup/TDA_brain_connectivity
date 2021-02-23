function [data_uninorm] = marginalUniform(data)

[Nsamples,Nvariables] = size(data); 

data_uninorm=zeros(size(data));
for ivariables =1:Nvariables
    if std(data(:,ivariables))
        [~, IX]=sort(data(:,ivariables),1);
        ranking(IX)=1:Nsamples;
        normal_sample=0:1/(Nsamples-1):1;%sort(randn(Nsamples, 1));
        data_uninorm(:,ivariables) = normal_sample(ranking);
    end
end 



end
