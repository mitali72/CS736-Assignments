function g = Quadratic(X)
    %QUADRATIC Penalty 
    %   
    g = zeros(256,256);
    dim = [1,2];
    step = [1,-1];
    for i=1:2
        for j = 1:2
            Ydiff = circshift(X,step(j),dim(i)) - X;
            g = g + Ydiff.^2;
        end
    end   
end

