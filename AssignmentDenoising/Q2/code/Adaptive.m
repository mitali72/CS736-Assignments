function g = Adaptive(X,gamma)
    % Discontinuity-adaptive penalty function
    %  
    g = zeros(256,256);
    dim = [1,2];
    step = [1,-1];
    for i=1:2
        for j = 1:2
            Ydiff = circshift(X,step(j),dim(i)) - X;
            Yabs = abs(Ydiff);
            g = g + gamma*Yabs - gamma*gamma*log(1 + Yabs/gamma);
        end
    end   
end

