function [grad] = Quadratic_Grad(X)
    %QUADRATIC_GRAD : For MRF prior with Quadratic penalty funciton
    %   
    grad = zeros(256,256);
    
    dim = [1,2];
    step = [1,-1];
    for i=1:2
        for j = 1:2
            Ydiff1 = circshift(X,step(j),dim(i))-X;
            grad = grad + 2*Ydiff1;
        end
    end   
end

