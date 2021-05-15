function penalty = Huber_Prior_Penalty(X,gamma)
%HUBER_PRIOR_PENALTY_NEW 

dim = [1,2];
step = [1,-1];

penalty = zeros([256 256]);

for i = 1:2
    for j = 1:2
        
        Y_diff = circshift(X, step(i), dim(j)) - X;
        Y_huber = arrayfun(@(x) Huber_Function(x,gamma), Y_diff);
        penalty = penalty + Y_huber;
        
    end
end

end

