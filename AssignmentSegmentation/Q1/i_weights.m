function weight_vals = i_weights(orig_image,filter_size,sigma)
%WEIGHTS To compute all the wij's (summed over all j's) to be used in the computation 
%of the bi update

weight_vals = cell(256,256);

for i = 1:256
    for j = 1:256
        
        i_weight = zeros(256, 256);
        
        for k = - floor(filter_size/2):floor(filter_size/2)
            for l = - floor(filter_size/2):floor(filter_size/2)
                
                centre_x = i+k;
                centre_y = j+l;
                
                if centre_x < 1 || centre_x > 256 || centre_y < 1 || centre_y > 256
                    continue
                end
                
                centre_pixel = orig_image(centre_x,centre_y);
                gaussian_weight = Gaussian_mask(filter_size,centre_pixel,sigma);
                
                i_weight(centre_x,centre_y) = gaussian_weight(ceil(filter_size/2)-k,ceil(filter_size/2)-l);
                
            end
        end     
                
        weight_vals{i,j} = i_weight;   
        
    end
end

end

