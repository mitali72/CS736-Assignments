function [grad] = Huber_Grad(X,gamma)
    %HUBER_GRAD_CLIQUE 
    %  X = Predicted Noisless Image
    grad = zeros(256,256);
    
    dim = [1,2];
    step = [1,-1];
    for i=1:2
        for j = 1:2
            Ydiff1 = circshift(X,step(j),dim(i)) - X;
            Yabs1 = abs(Ydiff1);
            condition = (Yabs1<=gamma);
            grad(~condition) = grad(~condition) + gamma*sign(Ydiff1(~condition));
            grad(condition) = grad(condition) + Ydiff1(condition);
        end
    end    
end

