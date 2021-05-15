function [grad] = Adaptive_Grad(X,gamma)
    %ADAPTIVE_GRAD 
    %   
    grad = zeros(256,256);
    
    dim = [1,2];
    step = [1,-1];
    for i=1:2
        for j = 1:2
            Ydiff1 = circshift(X,step(j),dim(i)) - X;
            Yabs1 = abs(Ydiff1);
            grad = grad + (gamma*Ydiff1)./(gamma + Yabs1);
        end
    end   
end

