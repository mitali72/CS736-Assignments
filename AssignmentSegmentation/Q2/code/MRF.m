function ret = MRF (k, i, j, X, mask, beta, K)
    row_val = [-1,1];
    col_val = [-1,1];
    
    %For edges, reducing neighbours
    if(i==256) 
        row_val = -1;
    end
    if(i==1)
        row_val = 1;
    end
    
    if(j==256)
        col_val = -1;
    end
    if(j==1)
        col_val = 1;
    end
    Z = 0;
    for lab = 1:K
        sum = 0;
        for row = row_val
            for col = col_val
                if(lab ~= X(i+row, j+col) && mask(i+row, j+col)==1) %Ignoring pixels with mask = 0
                    sum = sum + beta;  %Adding penalty
                end
            end
        end
        if (lab==k)
            num = exp(-1*sum);
        end
        Z = Z + exp(-1*sum); %Normalizing factor to ensure sum of probailities is 1
    end
    ret = num/Z;
end