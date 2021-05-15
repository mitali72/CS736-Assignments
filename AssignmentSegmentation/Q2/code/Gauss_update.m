function comb = Gauss_update(Y, mem, mask, K)

mean_sum = zeros(1,K);
vari_sum = zeros(1,K);
mem_sum = zeros(1,K);

%Code to find the optimal value of the class means, within every iteration.
for i=1:256
        for j=1:256
            if (mask(i,j)==0)
                continue
            end
            for k = 1:K
                mean_sum(k)= mean_sum(k)+ mem(i,j,k)*Y(i,j);
                mem_sum(k)= mem_sum(k)+ mem(i,j,k);
            end
        end
end
mu_new = mean_sum ./mem_sum; %Updating class means

%Code to find the optimal value of the class standard deviations (used as variance), within every iteration
for i=1:256
        for j=1:256
            if (mask(i,j)==0)
                continue
            end
            for k = 1:K
                vari_sum(k) = vari_sum(k)+ mem(i,j,k)*(Y(i,j)-mu_new(k))^2;
            end
        end
end
vari_new = vari_sum ./mem_sum; %updating variance
comb.a = mu_new;
comb.b = vari_new;

end