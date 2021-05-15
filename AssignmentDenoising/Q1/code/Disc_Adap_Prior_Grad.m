function grad = Disc_Adap_Prior_Grad(X,gamma)
%DISC_ADAP_PRIOR_GRAD 

dim = [1,2];
step = [1,-1];

grad = zeros([256 256]);

for i = 1:2
    for j = 1:2
        
        Y_diff = circshift(X, step(i), dim(j)) - X;
        Y_disc = arrayfun(@(x) Disc_Adap_Grad(x,gamma), Y_diff);
        grad = grad - Y_disc;
        
    end
end

end

