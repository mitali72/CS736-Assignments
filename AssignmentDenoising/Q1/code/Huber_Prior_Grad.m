function grad = Huber_Prior_Grad(X,gamma)
%HUBER_PRIOR_GRAD_NEW 

dim = [1,2];
step = [1,-1];

grad = zeros([256 256]);

for i = 1:2
    for j = 1:2
        
        Y_diff = circshift(X, step(i), dim(j)) - X;
        Y_huber = arrayfun(@(x) Huber_Grad(x,gamma), Y_diff);
        grad = grad - Y_huber;
        
    end
end

end

