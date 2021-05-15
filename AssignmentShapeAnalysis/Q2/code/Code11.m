function [mean_shape,aligned_pointsets] = Code11(shapes)
    %Optimal Mean shape
   
    k = randi(40,1);
    mean_shape = shapes(:,:,k);
    num_points = size(shapes,2);
    aligned_pointsets = zeros(size(shapes));
    
    best_obj = 1e9;
    
    while(1)
        for i = 1:size(shapes,3)
            [aligned_pointsets(:,:,i),~] = Code_1(shapes(:,:,i),mean_shape,num_points);
        end
        
        mean_shape = mean(aligned_pointsets,3);
        
        %Since the aligned shapes are already in the pre-shape space, we
        %need not normalise mean shape
         %mean_shape = mean_shape./(norm(mean_shape));
        
        new_obj = ObjectiveShape(mean_shape,aligned_pointsets);
        if new_obj<best_obj
            best_obj = new_obj;
            
        elseif (abs(best_obj - new_obj) < 1e-4)
            break;
        end     
    end
end

