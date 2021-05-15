function running_sol = Rician_Quad_Grad_Descent(imageNoisy,alpha,num_iter,show_plot)
%RICIAN_QUAD_GRAD_DESCENT 

running_sol = imageNoisy;
initial_step = 1;
running_step = initial_step*ones([256 256]);
monitor_loss = zeros(num_iter);
iter_value = zeros(num_iter);

running_obj_val = Rician_Quad_Obj(running_sol,imageNoisy,alpha);

for i = 1:num_iter
    
    grad_matrix = Rician_Quad_Grad(running_sol, imageNoisy, alpha);
    potential_sol = running_sol - running_step.*grad_matrix;
    new_obj_val = Rician_Quad_Obj(potential_sol,imageNoisy,alpha);
    
    obj_diff = running_obj_val - new_obj_val;
    mask_matrix = heaviside(obj_diff);
    inverse_mask_matrix = heaviside(-obj_diff);
    running_sol = potential_sol.*mask_matrix + running_sol.*inverse_mask_matrix;
    step_factor = arrayfun(@(x) Step_Update(x), obj_diff);
    running_step = running_step.*step_factor;
    
    monitor_loss(i) = sum(new_obj_val, 'all');
    iter_value(i) = i;
    
end

if show_plot == 1
    figure;
    plot(iter_value, monitor_loss);
    title('Quadratic penalty'); 
    xlabel('iterations'); 
    ylabel('Objective function');
    save('../results/obj_quad.mat',"monitor_loss");
end

end

