function g = Huber(X,gamma)
    %HUBER penalty funciton
    %   
    
    [rows,cols] = size(X);
    g = zeros(rows,cols);
    dim = [1,2];
    step = [1,-1];
    for i=1:2
        for j = 1:2
            Ydiff = circshift(X,step(j),dim(i)) - X;
            Yabs = abs(Ydiff);
            condition = (Yabs<=gamma);
            g(~condition) = g(~condition) + gamma*Yabs(~condition) - 0.5*gamma*gamma;
            g(condition) = g(condition) + 0.5*(Yabs(condition).^2);
        end
    end   
    
end

