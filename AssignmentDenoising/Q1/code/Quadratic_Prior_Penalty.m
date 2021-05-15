function penalty = Quadratic_Prior_Penalty(X)
%QUADRATIC_PRIOR_PENALTY_NEW 

dim = [1,2];
step = [1,-1];

penalty = zeros([256 256]);

for i = 1:2
    for j = 1:2
        
        Y_diff = circshift(X, step(i), dim(j)) - X;
        Y_sq = Y_diff.^2;
        penalty = penalty + Y_sq;
        
    end
end

end

