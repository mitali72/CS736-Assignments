function [obj_value] = ObjectiveShape(mean_shape,aligned_shape)
    %Objective function to minimise to find the shape mean
   
   d = vecnorm(mean_shape - aligned_shape);
   obj_value = sum(sum((d.^2),2),3);
  
end

