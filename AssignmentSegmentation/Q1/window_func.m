function windows = window_func(bias_field,size)
%WINDOW_FUNC To generate all possible windows of the bias field of
%filter_size x filter_size with different centre pixels

windows = cell(256,256);

lower = - floor(size/2);
upper = floor(size/2);

for i = 1:256
    for j = 1:256
        
        lower_i = i + lower;
        upper_i = i + upper;
        lower_j = j + lower;
        upper_j = j + upper;
        
        if(lower_i >= 1 && upper_i <= 256 && lower_j >= 1 && upper_j <= 256)
            
            windows{i,j} = bias_field((lower_i:upper_i), (lower_j:upper_j));
            
        else
            
            windows{i,j} = zeros(size);
            
        end
        
    end
end

end

