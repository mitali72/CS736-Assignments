function grad = Quadratic_Prior_Grad(X)
%QUADRATIC_GRAD_NEW 

dim = [1,2];
step = [1,-1];

grad = zeros([256 256]);

for i = 1:2
    for j = 1:2
        
        Y_diff = circshift(X, step(i), dim(j)) - X;
        grad = grad - 2*Y_diff;
        
    end
end
   

end

