function [aligned_set_1, aligned_set_2] = Code_2(set_1, set_2, num_points)
%CODE_2 Code to align two pointsets of equal cardinality via similarity
%transformations as done by Cootes et al. Utilising the alternating
%minimisation algorithm

x_set_1 = set_1(1, :);
y_set_1 = set_1(2, :);
x_set_2 = set_2(1, :);
y_set_2 = set_2(2, :);

% Optimizing T to match centroids (making them as the origin)
% Carrying out the translations to center each point set at origin
centroid_1_x = sum(x_set_1)/num_points;
centroid_1_y = sum(y_set_1)/num_points;
centroid_2_x = sum(x_set_2)/num_points;
centroid_2_y = sum(y_set_2)/num_points;

x_set_1 = x_set_1 - ones(1, num_points)*centroid_1_x;
x_set_2 = x_set_2 - ones(1, num_points)*centroid_2_x;
y_set_1 = y_set_1 - ones(1, num_points)*centroid_1_y;
y_set_2 = y_set_2 - ones(1, num_points)*centroid_2_y;

% Reconstructing two pointsets S1 and S2
S1 = zeros(2, num_points);
S2 = zeros(2, num_points);

S1(1, :) = x_set_1;
S1(2, :) = y_set_1;
S2(1, :) = x_set_2;
S2(2, :) = y_set_2;

% Carrying out alternating minimisation
s = 1;
R = eye(2);

best_obj = Objective(S1, S2, s, R);

while(1)

    % Optimizing rotation by the Kabsch Algorithm
    S1_trans = s.*S1;
    
    A = S1_trans*(S2');
    [U, S, V] = svd(A);

    sz = size(U);
    
    R_new = V*(U');

    if(round(det(R_new)) ~= 1)
        
        I_2 = eye(sz(1));
        I_2(sz(1), sz(1)) = -1;

        R_new = V*I_2*(U');

    end
    
    new_obj = Objective(S1, S2, s, R_new);
    
    if new_obj < best_obj
        best_obj = new_obj;
        R = R_new;
    else
        break;
    end
    
    % Optimizing the scale parameter
    sz = size(S2);
    S1_trans = zeros(sz(1), sz(2));

    for i = 1:num_points
        S1_trans(:,i) = R*S1(:,i);
    end
    
    B = S2.*S1_trans;
    s_num = sum(B, 'all');
    
    S1_trans_sq = S1_trans.^2;
    s_den = sum(S1_trans_sq, 'all');
    
    s_new = s_num/s_den;
    
    new_obj = Objective(S1, S2, s_new, R);
    
    if(new_obj < best_obj)
        best_obj = new_obj;
        s = s_new;
    else
        break;
    end
    
end

S1_trans = R*S1;
aligned_set_1 = s*S1_trans;
aligned_set_2 = S2;
        
end