function [results] = SVM_FS_PCA_comb_test2(data, labels, dim_red, varargin)
% HELP svm_train
% The function is going to perform SVM on the data with "crossvalidation"
% It will permutate through the dataset defined number of times and
% evaluates the SVM
% 
% COMPULSARY PARAMETERS
% data = data structure (data(1).mat) if we want to separately analyze multimodal dataset using PCA
% labels = vector of labels
% dim_red = 'FS' for Fisher Score 'PCA' for PCA 'PCA together' 
% 
% other parameters are: 
% 'control' + vector "vector for which to control"
% 'percentage'  + float "percentage of features which to include in the
%               
% 
% EXAMPLE: svm_results = SVM_FS_PCA_comb(data, labels, 'FS');

%% Initia data inspection
no_patients = size(data(1).mat,1);
no_modalities = length(data);
no_features = zeros(1,no_modalities);
for i = 1:no_modalities
    no_features(i) = size(data(i).mat,2);
end

mat_res = zeros(1, no_patients);
classes = length(unique(labels));
mat_supp = zeros(no_patients, no_patients);
features_picked = struct();
% pre-definition fo the structures with the results
mat_res = struct();
mat_supp = struct();

%% CONTROL is there a vector to control for?
cid = find(strcmp(varargin,'control'),1);
switch isempty(cid)
    case 1
    case 0
        % orthogonalize the normalized features according to the controlled
        % variables
        for i = 1:no_modalities
            control = varargin{cid+1};    
            beta = (inv(control'*control))*control'*data(i).mat;
            data(i).mat = data(i).mat - control*beta;
        end
end

%% NO. FEATURES get the percentage of features to go into SVM (if empty 100% of the features is taken)
percentageid = find(strcmp(varargin,'percentage'),1);
width = zeros(1,no_modalities);

switch isempty(percentageid)
    case 1
        percentage = 1;
        width = no_features;
    case 0
        percentage = varargin{percentageid+1};
        switch percentage <= 1
            case 1
                width = ceil(no_features*percentage);
            case 0
                width = width + percentage;
        end
end

%% LEAVE-?-OUT
leaveOutFlag = find(strcmp(varargin,'leave2out'),1);

switch isempty(leaveOutFlag)
    case 0
        fL2O = 1;
    case 1
        fL2O = 0;
end


%% THE BIG CYCLE
% cycle for features picking and subsequent classification
disp('Permutation number')
for permi = 1:no_patients
fprintf('%4.f,', permi);
%     if mod(permi, 20) == 0 || permi == no_patients
%         fprintf('\n')
%     end
        
        % pick the variables
        if fL2O
            if permi<=no_patients/2
                pairi = permi+round(no_patients/2);
            else
                pairi = permi-round(no_patients/2);
            end
            train_index = setdiff((1:no_patients),[permi pairi]);
        else
            train_index = setdiff((1:no_patients),permi);
        end
        test_index = permi;     
        no_modalities = length(data);
        
        % Dimensionality reduction step 
        % --> pick between Fisher Score ('FS')
        % --> or PCA ('PCA')
        % --> or PCA ('together')
        switch dim_red
            case 'FS'
                % Compute the Fisher Score for all features
                for i = 1:no_modalities
                    [~, ~, rank] = FisherScore(data(i).mat(train_index,:),labels(train_index));
                    features_picked(i).mat(test_index,:) = rank(1:width(i));
                    train_in(i).mat = data(i).mat(train_index,rank(1:width(i)));
                    test_in(i).mat = data(i).mat(test_index,rank(1:width(i)));
                    colnames_in(i).mat = cellstr(string(1:size(train_in(i).mat,2)));
                end

            case 'PCA'
                % Create PCA from the data
                for i = 1:no_modalities
                    [coeff, score, ~, ~, explained, ~] = pca(data(i).mat(train_index,:),...
                                                            'Algorithm', 'svd',...
                                                            'Centered', 'off',...
                                                            'Economy', 'off',...
                                                            'Rows', 'all');     

                    width_prep = sum((sum(score==0)==(no_patients-1))==0); % redefinition of width if the number of features is bigger than the number of subjects                                    
                    width(i) = ceil(width_prep*percentage);
                    
                    features_picked(i).mat(test_index).score = NaN(no_patients, width(i));
                    features_picked(i).mat(test_index).score(train_index,:) = score(:,1:width(i));
%                     features_picked(i).mat(test_index).coeff = coeff(1:width(i));
                    features_picked(i).mat(test_index).explained = explained;
                    train_in(i).mat = score(:,1:width(i));
                    test_in(i).mat = data(i).mat(test_index,:)/(coeff');
                    colnames_in(i).mat = cellstr(string(1:size(train_in(i).mat,2)));
                end
                
                % Do the same as in PCA but combine the features together
                % at the end
            case 'PCA together'
                for i = 1:no_modalities
                    [coeff, score, ~, ~, explained, ~] = pca(data(i).mat(train_index,:),...
                                                            'Algorithm', 'svd',...
                                                            'Centered', 'off',...
                                                            'Economy', 'off',...
                                                            'Rows', 'all');     
                    
                    width_prep = sum((sum(score==0)==(no_patients-1))==0);
                    
                    % Creating the matrix of all the scores
                    switch i
                        case 1
                            scoreB = score(:,1:width_prep);
                            explainedB = explained(1:width_prep)';
                            testB = data(i).mat(test_index,:)/(coeff');
                        otherwise
                            scoreB = [scoreB,score(:,1:width_prep)];
                            explainedB = [explainedB,explained(1:width_prep)'];
                            testB = [testB,data(i).mat(test_index,:)/(coeff')];
                    end
                        
                end
                % Sort the big matrix so that we will add the features
                % according to the explained variability
                    [~, rank] = sort(explainedB,'descend');
                    width = ceil(length(explainedB)*percentage);
                    
                    train_in(1).mat = scoreB(:,rank(1:width));
                    test_in(1).mat = testB(:,rank(1:width));
                    colnames_in(i).mat = cellstr(string(1:size(train_in(1).mat,2)));
                    no_modalities = 1;
                    
            case 'none'
                for i = 1:no_modalities
                    train_in(i).mat = data(i).mat(train_index,1:width(i));
                    test_in(i).mat = data(i).mat(test_index,1:width(i));
                    colnames_in(i).mat = cellstr(string(1:size(train_in(i).mat,2)));
                end
                
        end
              
 % SVM
 for i = 1:no_modalities
        SVM_diff = fitcsvm(train_in(i).mat, labels(1,train_index),...
                                'CacheSize', 'maximal',...
                                'ClipAlphas', 1,...
                                'Cost', ones(size(classes,2),size(classes,2))-eye(size(classes,2),size(classes,2)),...
                                'CrossVal', 'off',...
                                'GapTolerance', 0,...
                                'DeltaGradientTolerance', 0,...
                                'IterationLimit', 1e5,...
                                'KernelFunction', 'linear',...
                                'OutlierFraction', 0,...
                                'PredictorNames',colnames_in(i).mat,... 
                                'Prior', 'uniform',...
                                'RemoveDuplicates', 0,...
                                'ResponseName', 'Vysledok',...
                                'ScoreTransform', 'none',...
                                'Solver', 'SMO',...
                                'Standardize', 1,...
                                'Verbose', 0);

    
    % Prediction on Test data
%     SVM_diff = compact(SVM_diff);
    [labels_pred, PostProbs] = predict(SVM_diff, test_in(i).mat(1:width(i)));
    disp([mat2str(labels_pred) ' ' mat2str(PostProbs)]);
%     disp(sum(train_in(i).mat(labels(1,train_index)==1)>train_in(i).mat(labels(1,train_index)==0)));
    
	mat_res(i).mat(test_index) = labels_pred;
    mat_supp(i).mat(train_index,permi) = SVM_diff.IsSupportVector;
 end
end

for i = 1:no_modalities
    diagACCUR(i) = Diagnostic_accuracy(mat_res(i).mat,labels,1,0);
end

results.labelsFIN = mat_res;
results.labelsORIG = labels;
results.diagACCUR = diagACCUR;
results.supp = mat_supp;
results.features_picked = features_picked;


% Fisher Score function
function [S, sorted, rank] = FisherScore(data,labels)
% Computation of the Fisher Score for all features in matrix according to
% the vector labels

classes = (unique(labels));

S = zeros(1,size(data,2));
n1 = sum(labels==classes(1));
n2 = sum(labels==classes(2));

for feati = 1:size(data,2)
    u = mean(data(:,feati));
    u1 = mean(data(labels==classes(1),feati));
    u2 = mean(data(labels==classes(2),feati));
    s1 = var(data(labels==classes(1),feati));
    s2 = var(data(labels==classes(2),feati));
    S(feati) = (n1*(u1-u)^2 + n2*(u2-u)^2)/(n1*s1^2 + n2*s2^2) ;
end

[sorted, rank] = sort(S,'descend');

end

end