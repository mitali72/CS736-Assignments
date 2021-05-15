function comb = Member(Y, X, mask, K, mu, vari, beta)
    X_map = X;
    log_posterior_new = 0;
    log_posterior_old = 0;
    
    %Code to find the optimal labeling,  within every iteration,  based on
    %a modified ICM that updates all labels at once ensuring that the
    %posterior probability increases
    for i=1:256
        for j=1:256
            if (mask(i,j)==0)
                continue
            end
                old_val = exp(-(Y(i,j)-mu(X(i,j)))^2/(2*vari(X(i,j))))*MRF(X(i,j),i,j,X,mask,beta,K); %Posterior Probability value with old label 
                max_val = exp(-(Y(i,j)-mu(1))^2/(2*vari(1)))*MRF(1,i,j,X,mask,beta,K); %The posterior probability
                max_l = 1;
                for k=2:K
                    val = exp(-(Y(i,j)-mu(k))^2/(2*vari(k)))*MRF(k,i,j,X,mask,beta,K); 
                    if(val > max_val)
                        max_val = val;
                        max_l = k; %Changing label to get higher posterior
                    end
                end
               X_map(i,j)= max_l;
               log_posterior_old = log_posterior_old + log(old_val);
               log_posterior_new = log_posterior_new + log(max_val);
        end
    end
    
    %Code to find the optimal value of the memberships, within every iteration
    mem = zeros(256,256,K);
    for i=1:256
        for j=1:256
            val = zeros(1,K);
            sum = 0;
            if (mask(i,j)==0)
                continue
            end
            for lab = 1:K
                val(lab) = exp(-(Y(i,j)-mu(lab))*(Y(i,j)-mu(lab))/(2*vari(lab)))*MRF(lab,i,j,X_map,mask,beta,K);
                sum = sum+ val(lab);
            end
            val = val/sum;
            mem(i,j,1) = val(1); %Memberships for each class
            mem(i,j,2) = val(2);
            mem(i,j,3) = val(3);
        end
    end
    comb.a = mem;  %Updated membership
    comb.b = X_map; %Updated Optimal label image
    comb.c = log_posterior_old; %Old posterior
    comb.d = log_posterior_new; %Updated posterior
end
    

