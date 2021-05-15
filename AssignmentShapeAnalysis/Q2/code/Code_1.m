function [aligned_set_1, aligned_set_2] = Code_1(set_1, set_2, num_points)
%CODE_1 Code to align two pointsets of equal cardinality via similarity
%transformations after standardizing the point sets to pre-shape space

x_set_1 = set_1(1, :);
y_set_1 = set_1(2, :);
x_set_2 = set_2(1, :);
y_set_2 = set_2(2, :);

% Carrying out the translations to center each point set at origin
centroid_1_x = sum(x_set_1)/num_points;
centroid_1_y = sum(y_set_1)/num_points;
centroid_2_x = sum(x_set_2)/num_points;
centroid_2_y = sum(y_set_2)/num_points;

x_set_1 = x_set_1 - ones(1, num_points)*centroid_1_x;
x_set_2 = x_set_2 - ones(1, num_points)*centroid_2_x;
y_set_1 = y_set_1 - ones(1, num_points)*centroid_1_y;
y_set_2 = y_set_2 - ones(1, num_points)*centroid_2_y;

% Carrying out scaling such that each point set has norm = 1
s_1 = sqrt(1/(sum(x_set_1.^2) + sum(y_set_1.^2)));
s_2 = sqrt(1/(sum(x_set_2.^2) + sum(y_set_2.^2)));

x_set_1 = x_set_1*s_1;
y_set_1 = y_set_1*s_1;
x_set_2 = x_set_2*s_2;
y_set_2 = y_set_2*s_2;

% Reconstructing two pointsets S1 and S2
S1 = zeros(2, num_points);
S2 = zeros(2, num_points);

S1(1, :) = x_set_1;
S1(2, :) = y_set_1;
S2(1, :) = x_set_2;
S2(2, :) = y_set_2;

% Using the Kabsch Algorithm
A = S1*(S2');
[U, S, V] = svd(A);

sz = size(U);

R = V*(U');
det_R = det(R);

if round(det_R) == 1
    
    aligned_set_1 = R*S1;
    aligned_set_2 = S2;
    
else

    I_2 = eye(sz(1));
    I_2(sz(1), sz(1)) = -1;

    R = V*I_2*(U');
    
    aligned_set_1 = R*S1;
    aligned_set_2 = S2;
   
end
end

