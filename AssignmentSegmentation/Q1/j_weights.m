function weight_vals = j_weights(orig_image,filter_size,sigma)
%WEIGHTS To compute all the wij's (summed over all i's) to be used in the computation of the ck
%update

weight_vals = cell(256,256);

for i = 1:256
    for j = 1:256
        
        weight = zeros(256,256);
        centre_pixel = orig_image(i,j);
        gaussian_weight = Gaussian_mask(filter_size,centre_pixel,sigma);
        
        gaussian_x_start = 1;
        gaussian_x_end = filter_size;
        gaussian_y_start = 1;
        gaussian_y_end = filter_size;
        
        lower_i = i - floor(filter_size/2);
        upper_i = i + floor(filter_size/2);
        lower_j = j - floor(filter_size/2);
        upper_j = j + floor(filter_size/2);
        
        if lower_i < 1
            diff = 1 - lower_i;
            gaussian_x_start = gaussian_x_start + diff;
            lower_i = 1;
        end
         
        if upper_i > 256
            diff = upper_i - 256;
            gaussian_x_end = gaussian_x_end - diff;
            upper_i = 256;
        end   
            
        if lower_j < 1
            diff = 1 - lower_j;
            gaussian_y_start = gaussian_y_start + diff;
            lower_j = 1;
        end
            
        if upper_j > 256
            diff = upper_j - 256;
            gaussian_y_end = gaussian_y_end - diff;
            upper_j = 256;
        end 
        
        weight(lower_i:upper_i, lower_j:upper_j) = gaussian_weight(gaussian_x_start:gaussian_x_end, gaussian_y_start:gaussian_y_end);
        weight_vals{i,j} = weight;   
        
    end     
end

end

