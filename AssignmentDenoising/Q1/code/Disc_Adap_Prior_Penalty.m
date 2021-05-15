function penalty = Disc_Adap_Prior_Penalty(X,gamma)
%DISC_ADAP_PRIOR

dim = [1,2];
step = [1,-1];

penalty = zeros([256 256]);

for i = 1:2
    for j = 1:2
        
        Y_diff = circshift(X, step(i), dim(j)) - X;
        Y_disc = arrayfun(@(x) Disc_Adap_Function(x,gamma), Y_diff);
        penalty = penalty + Y_disc;
        
    end
end

end

