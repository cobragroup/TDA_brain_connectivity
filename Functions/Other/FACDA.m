function [w,counter]=FACDA(X,i,tmax,theta)
%X..times series, rows=elements (n), columns=times (length T) 
%X size (n,T)
%i response index
%tmax=max lag assumption
%theta=significance level

%w..vector size n*tmax in {0,1} denoting parent set of X_i(t) 
%order of elements in w=(X_1(1),....X_n(1),X_1(2),....,X_1(tmax)...X_n(tmax))
%counter=number of realized (partial) correlations


counter=0;
[n,T]=size(X);
w=zeros(1,n*tmax);
cval=zeros(1,n*tmax);
pval=zeros(1,n*tmax);

    for k=0:1:tmax 
        Y(n*(k)+1:(k+1)*n,:)=X(:,tmax-k+1:end-k); %time series lagged matrix
    end
    for j=1:1:n*tmax
              
        [x(j),cval(j)]=corr(transpose(Y(i,:)),transpose(Y(n+j,:))); %correlation x_i, x_j(t-tau) \forall j,tau
        counter=counter+1;
         if cval(j)>theta
            x(j)=0;
         else
             x(j)=abs(x(j));%-0.5*log(1-(x(j))^2)
         end   
    end
       [xmax,p]=max(x);
    if xmax>0
    K=p;
    x(p)=0;
    V=find(x);
    else
    K=[];   
    V=[];
    end
    %Conditioning 
    while (isempty(V)==0) 

             clear x;
             clear pval;
             clear p;
        for  j=1:1:length(V)

            [x(j),pval(j)]=partialcorri(transpose(Y(i,:)),transpose(Y(n+V(j),:)),transpose(Y(n+K,:)));    %partial correlation
            counter=counter+1;
            
            if pval(j)>theta
            x(j)=0;
            else
             x(j)=abs(x(j));%-0.5*log(1-(x(j))^2)
            end    
            
        end
               
            [xmax,p]=max((x));
            if xmax>0
            K=[K V(p)];
            x(p)=0;
            ff=find(x);
            V=V(ff);  
            else
            V=[];    
            end
            clear x;
            clear pval;
           
         
    end  


    w(K)=1;