%% Loading The Data
clear;
warning('off','all')
warning
load('../data/ellipses2D.mat');

%% (d) Visualizing The Data

random_color = rand(numOfPointSets,3);
data_fig = figure;

for k = 1:numOfPointSets
    
    cur_set = pointSets(:, :, k);
    x = cur_set(1, :);
    y = cur_set(2, :);
    s = scatter(x, y, 'filled');
    s.MarkerFaceColor = random_color(k,:);
    hold on
    
end

hold off
save('../results/data_fig.mat', 'data_fig')

%% (e) Mean Shape

% Using Code11
[mean_shape,aligned_pointsets] = Code11(pointSets);

mean_11_fig = figure;

for k = 1:numOfPointSets
    scatter(aligned_pointsets(1,:,k),aligned_pointsets(2,:,k),'filled','blue');
    hold on
end

plot(mean_shape(1,:),mean_shape(2,:),'-or','MarkerFaceColor','r');

hold off
title("Code11")
save('../results/mean_11_fig.mat','mean_11_fig');

% Using Code22

[mean_shape,aligned_pointsets] = Code22(pointSets);

mean_22_fig = figure;
for k = 1:numOfPointSets
    scatter(aligned_pointsets(1,:,k),aligned_pointsets(2,:,k),'filled','blue');
    hold on
end

plot(mean_shape(1,:),mean_shape(2,:),'-or','MarkerFaceColor','r');

hold off
title("Code22")
save('../results/mean_22_fig.mat','mean_22_fig');

%% (f) Principal Modes of Variation

% Using Code11

[mean_shape_11,aligned_pointsets_11] = Code11(pointSets);
[vec, val, mean_vec] = Variation_modes(mean_shape_11,aligned_pointsets_11);
vec_length = size(mean_shape_11, 2);

%%% Largest mode of variation
var_11_plus_3 = mean_vec + 3*sqrt(val(2*vec_length))*vec(:,2*vec_length);
var_11_plus_2 = mean_vec + 2*sqrt(val(2*vec_length))*vec(:,2*vec_length);

var_11x_plus_3 = zeros(vec_length, 1);
var_11y_plus_3 = zeros(vec_length, 1);

var_11x_plus_2 = zeros(vec_length, 1);
var_11y_plus_2 = zeros(vec_length, 1);

for i = 1:vec_length
    
    var_11x_plus_3(i) = var_11_plus_3(2*i-1);
    var_11y_plus_3(i) = var_11_plus_3(2*i);
    
    var_11x_plus_2(i) = var_11_plus_2(2*i-1);
    var_11y_plus_2(i) = var_11_plus_2(2*i);
    
end
 
var_11_minus_3 = mean_vec - 3*sqrt(val(2*vec_length))*vec(:,2*vec_length);
var_11_minus_2 = mean_vec - 2*sqrt(val(2*vec_length))*vec(:,2*vec_length);

var_11x_minus_3 = zeros(vec_length, 1);
var_11y_minus_3 = zeros(vec_length, 1);

var_11x_minus_2 = zeros(vec_length, 1);
var_11y_minus_2 = zeros(vec_length, 1);

for i = 1:vec_length
    
    var_11x_minus_3(i) = var_11_minus_3(2*i-1);
    var_11y_minus_3(i) = var_11_minus_3(2*i);
    
    var_11x_minus_2(i) = var_11_minus_2(2*i-1);
    var_11y_minus_2(i) = var_11_minus_2(2*i);
    
end

%%% Second largest mode of variation
var_21_plus_3 = mean_vec + 3*sqrt(val(2*vec_length-1))*vec(:,2*vec_length-1);
var_21_plus_2 = mean_vec + 2*sqrt(val(2*vec_length-1))*vec(:,2*vec_length-1);

var_21x_plus_3 = zeros(vec_length, 1);
var_21y_plus_3 = zeros(vec_length, 1);

var_21x_plus_2 = zeros(vec_length, 1);
var_21y_plus_2 = zeros(vec_length, 1);

for i = 1:vec_length
    
    var_21x_plus_3(i) = var_21_plus_3(2*i-1);
    var_21y_plus_3(i) = var_21_plus_3(2*i);
    
    var_21x_plus_2(i) = var_21_plus_2(2*i-1);
    var_21y_plus_2(i) = var_21_plus_2(2*i);
    
end

var_21_minus_3 = mean_vec - 3*sqrt(val(2*vec_length-1))*vec(:,2*vec_length-1);
var_21_minus_2 = mean_vec - 2*sqrt(val(2*vec_length-1))*vec(:,2*vec_length-1);

var_21x_minus_3 = zeros(vec_length, 1);
var_21y_minus_3 = zeros(vec_length, 1);

var_21x_minus_2 = zeros(vec_length, 1);
var_21y_minus_2 = zeros(vec_length, 1);

for i = 1:vec_length
    
    var_21x_minus_3(i) = var_21_minus_3(2*i-1);
    var_21y_minus_3(i) = var_21_minus_3(2*i);
    
    var_21x_minus_2(i) = var_21_minus_2(2*i-1);
    var_21y_minus_2(i) = var_21_minus_2(2*i);
    
end

%%% Third largest mode of variation
var_31_plus_3 = mean_vec + 3*sqrt(val(2*vec_length-2))*vec(:,2*vec_length-2);
var_31_plus_2 = mean_vec + 2*sqrt(val(2*vec_length-2))*vec(:,2*vec_length-2);

var_31x_plus_3 = zeros(vec_length, 1);
var_31y_plus_3 = zeros(vec_length, 1);

var_31x_plus_2 = zeros(vec_length, 1);
var_31y_plus_2 = zeros(vec_length, 1);

for i = 1:vec_length
    
    var_31x_plus_3(i) = var_31_plus_3(2*i-1);
    var_31y_plus_3(i) = var_31_plus_3(2*i);
    
    var_31x_plus_2(i) = var_31_plus_2(2*i-1);
    var_31y_plus_2(i) = var_31_plus_2(2*i);
    
end

var_31_minus_3 = mean_vec - 3*sqrt(val(2*vec_length-2))*vec(:,2*vec_length-2);
var_31_minus_2 = mean_vec - 2*sqrt(val(2*vec_length-2))*vec(:,2*vec_length-2);

var_31x_minus_3 = zeros(vec_length, 1);
var_31y_minus_3 = zeros(vec_length, 1);

var_31x_minus_2 = zeros(vec_length, 1);
var_31y_minus_2 = zeros(vec_length, 1);

for i = 1:vec_length
    
    var_31x_minus_3(i) = var_31_minus_3(2*i-1);
    var_31y_minus_3(i) = var_31_minus_3(2*i);
    
    var_31x_minus_2(i) = var_31_minus_2(2*i-1);
    var_31y_minus_2(i) = var_31_minus_2(2*i);
    
end

eigenvalues11 = [val(2*vec_length), val(2*vec_length-1), val(2*vec_length-2)];
figure;
eig_11 = plot(eigenvalues11);
title("Code11: Principal eigenvalues");
xlabel("ith principal eigenvalue");
ylabel("eigenvalue");
save('../results/eig_11.mat','eig_11');

% Using Code22

[mean_shape_22,aligned_pointsets_22] = Code22(pointSets);
[vec, val, mean_vec] = Variation_modes(mean_shape_22,aligned_pointsets_22);
vec_length = size(mean_shape_22, 2);

%%% Largest mode of variation
var_12_plus_3 = mean_vec + 3*sqrt(val(2*vec_length))*vec(:,2*vec_length);
var_12_plus_2 = mean_vec + 2*sqrt(val(2*vec_length))*vec(:,2*vec_length);

var_12x_plus_3 = zeros(vec_length, 1);
var_12y_plus_3 = zeros(vec_length, 1);

var_12x_plus_2 = zeros(vec_length, 1);
var_12y_plus_2 = zeros(vec_length, 1);

for i = 1:vec_length
    
    var_12x_plus_3(i) = var_12_plus_3(2*i-1);
    var_12y_plus_3(i) = var_12_plus_3(2*i);
    
    var_12x_plus_2(i) = var_12_plus_2(2*i-1);
    var_12y_plus_2(i) = var_12_plus_2(2*i);
    
end
 
var_12_minus_3 = mean_vec - 3*sqrt(val(2*vec_length))*vec(:,2*vec_length);
var_12_minus_2 = mean_vec - 2*sqrt(val(2*vec_length))*vec(:,2*vec_length);

var_12x_minus_3 = zeros(vec_length, 1);
var_12y_minus_3 = zeros(vec_length, 1);

var_12x_minus_2 = zeros(vec_length, 1);
var_12y_minus_2 = zeros(vec_length, 1);

for i = 1:vec_length
    
    var_12x_minus_3(i) = var_12_minus_3(2*i-1);
    var_12y_minus_3(i) = var_12_minus_3(2*i);
    
    var_12x_minus_2(i) = var_12_minus_2(2*i-1);
    var_12y_minus_2(i) = var_12_minus_2(2*i);
    
end

%%% Second largest mode of variation
var_22_plus_3 = mean_vec + 3*sqrt(val(2*vec_length-1))*vec(:,2*vec_length-1);
var_22_plus_2 = mean_vec + 2*sqrt(val(2*vec_length-1))*vec(:,2*vec_length-1);

var_22x_plus_3 = zeros(vec_length, 1);
var_22y_plus_3 = zeros(vec_length, 1);

var_22x_plus_2 = zeros(vec_length, 1);
var_22y_plus_2 = zeros(vec_length, 1);

for i = 1:vec_length
    
    var_22x_plus_3(i) = var_22_plus_3(2*i-1);
    var_22y_plus_3(i) = var_22_plus_3(2*i);
    
    var_22x_plus_2(i) = var_22_plus_2(2*i-1);
    var_22y_plus_2(i) = var_22_plus_2(2*i);
    
end

var_22_minus_3 = mean_vec - 3*sqrt(val(2*vec_length-1))*vec(:,2*vec_length-1);
var_22_minus_2 = mean_vec - 2*sqrt(val(2*vec_length-1))*vec(:,2*vec_length-1);

var_22x_minus_3 = zeros(vec_length, 1);
var_22y_minus_3 = zeros(vec_length, 1);

var_22x_minus_2 = zeros(vec_length, 1);
var_22y_minus_2 = zeros(vec_length, 1);

for i = 1:vec_length
    
    var_22x_minus_3(i) = var_22_minus_3(2*i-1);
    var_22y_minus_3(i) = var_22_minus_3(2*i);
    
    var_22x_minus_2(i) = var_22_minus_2(2*i-1);
    var_22y_minus_2(i) = var_22_minus_2(2*i);
    
end

%%% Third largest mode of variation
var_32_plus_3 = mean_vec + 3*sqrt(val(2*vec_length-2))*vec(:,2*vec_length-2);
var_32_plus_2 = mean_vec + 2*sqrt(val(2*vec_length-2))*vec(:,2*vec_length-2);

var_32x_plus_3 = zeros(vec_length, 1);
var_32y_plus_3 = zeros(vec_length, 1);

var_32x_plus_2 = zeros(vec_length, 1);
var_32y_plus_2 = zeros(vec_length, 1);

for i = 1:vec_length
    
    var_32x_plus_3(i) = var_32_plus_3(2*i-1);
    var_32y_plus_3(i) = var_32_plus_3(2*i);
    
    var_32x_plus_2(i) = var_32_plus_2(2*i-1);
    var_32y_plus_2(i) = var_32_plus_2(2*i);
    
end

var_32_minus_3 = mean_vec - 3*sqrt(val(2*vec_length-2))*vec(:,2*vec_length-2);
var_32_minus_2 = mean_vec - 2*sqrt(val(2*vec_length-2))*vec(:,2*vec_length-2);

var_32x_minus_3 = zeros(vec_length, 1);
var_32y_minus_3 = zeros(vec_length, 1);

var_32x_minus_2 = zeros(vec_length, 1);
var_32y_minus_2 = zeros(vec_length, 1);

for i = 1:vec_length
    
    var_32x_minus_3(i) = var_32_minus_3(2*i-1);
    var_32y_minus_3(i) = var_32_minus_3(2*i);
    
    var_32x_minus_2(i) = var_32_minus_2(2*i-1);
    var_32y_minus_2(i) = var_32_minus_2(2*i);
    
end

eigenvalues22 = [val(2*vec_length), val(2*vec_length-1), val(2*vec_length-2)];
figure;
eig_22 = plot(eigenvalues22);
title("Code22: Principal eigenvalues");
xlabel("ith principal eigenvalue");
ylabel("eigenvalue");
save('../results/eig_11.mat','eig_11');

%% (g) Plots of Aligned Pointsets, Means & Principal Means of Variation

% Code 1 Results

code11_sd1 = figure;
for k = 1:numOfPointSets
    scatter(aligned_pointsets_11(1,:,k),aligned_pointsets_11(2,:,k),'filled','y');
    hold on
end

h1 = plot(mean_shape_11(1,:),mean_shape_11(2,:),'-or','MarkerFaceColor','r');
hold on
h2 = plot(var_11x_plus_3,var_11y_plus_3,'-or','MarkerFaceColor','g');
hold on
h3 = plot(var_11x_minus_3,var_11y_minus_3,'-or','MarkerFaceColor','b');
% hold on
% plot(var_11x_plus_2,var_11y_plus_2,'-or','MarkerFaceColor','black');
% hold on
% plot(var_11x_minus_2,var_11y_minus_2,'-or','MarkerFaceColor','black');
legend([h1,h2(1),h3(1)], 'Code11: Mean Shape','Code11: +3SD1','Code11: -3SD1')
save('../results/code11_sd1.mat', 'code11_sd1')

code11_sd2 = figure;
for k = 1:numOfPointSets
    scatter(aligned_pointsets_11(1,:,k),aligned_pointsets_11(2,:,k),'filled','y');
    hold on
end

h1 = plot(mean_shape_11(1,:),mean_shape_11(2,:),'-or','MarkerFaceColor','r');
hold on
h2 = plot(var_21x_plus_3,var_21y_plus_3,'-or','MarkerFaceColor','g');
hold on
h3 = plot(var_21x_minus_3,var_21y_minus_3,'-or','MarkerFaceColor','b');
% hold on
% plot(var_21x_plus_3,var_21y_plus_2,'-or','MarkerFaceColor','black');
% hold on
% plot(var_21x_minus_3,var_21y_minus_2,'-or','MarkerFaceColor','black');
% title("var21")
legend([h1,h2(1),h3(1)], 'Code11: Mean Shape','Code11: +3SD2','Code11: -3SD2')
save('../results/code11_sd2.mat', 'code11_sd2')

code11_sd3 = figure;
for k = 1:numOfPointSets
    scatter(aligned_pointsets_11(1,:,k),aligned_pointsets_11(2,:,k),'filled','y');
    hold on
end

h1 = plot(mean_shape_11(1,:),mean_shape_11(2,:),'-or','MarkerFaceColor','r');
hold on
h2 = plot(var_31x_plus_3,var_31y_plus_3,'-or','MarkerFaceColor','g');
hold on
h3 = plot(var_31x_minus_3,var_31y_minus_3,'-or','MarkerFaceColor','b');
% hold on
% plot(var_31x_plus_2,var_31y_plus_2,'-or','MarkerFaceColor','black');
% hold on
% plot(var_31x_minus_2,var_31y_minus_2,'-or','MarkerFaceColor','black');
% title("var31")
legend([h1,h2(1),h3(1)], 'Code11: Mean Shape','Code11: +3SD3','Code11: -3SD3')
save('../results/code11_sd3.mat', 'code11_sd3')


% Code 2 Results

code22_sd1 = figure;
for k = 1:numOfPointSets
    scatter(aligned_pointsets_22(1,:,k),aligned_pointsets_22(2,:,k),'filled','y');
    hold on
end

h1 = plot(mean_shape_22(1,:),mean_shape_22(2,:),'-or','MarkerFaceColor','r');
hold on
h2 = plot(var_12x_plus_3,var_12y_plus_3,'-or','MarkerFaceColor','g');
hold on
h3 = plot(var_12x_minus_3,var_12y_minus_3,'-or','MarkerFaceColor','b');
% hold on
% plot(var_12x_plus_2,var_12y_plus_2,'-or','MarkerFaceColor','black');
% hold on
% plot(var_12x_minus_2,var_12y_minus_2,'-or','MarkerFaceColor','black');
% title("var12")
legend([h1,h2(1),h3(1)], 'Code22: Mean Shape','Code22: +3SD1','Code22: -3SD1')
save('../results/code22_sd1.mat', 'code22_sd1')

code22_sd2 = figure;
for k = 1:numOfPointSets
    scatter(aligned_pointsets_22(1,:,k),aligned_pointsets_22(2,:,k),'filled','y');
    hold on
end

h1 = plot(mean_shape_22(1,:),mean_shape_22(2,:),'-or','MarkerFaceColor','r');
hold on
h2 = plot(var_22x_plus_3,var_22y_plus_3,'-or','MarkerFaceColor','g');
hold on
h3 = plot(var_22x_minus_3,var_22y_minus_3,'-or','MarkerFaceColor','b');
% hold on
% plot(var_22x_plus_2,var_22y_plus_2,'-or','MarkerFaceColor','black');
% hold on
% plot(var_22x_minus_2,var_22y_minus_2,'-or','MarkerFaceColor','black');
% title("var22")
legend([h1,h2(1),h3(1)], 'Code22: Mean Shape','Code22: +3SD2','Code22: -3SD2')
save('../results/code22_sd2.mat', 'code22_sd2')

code22_sd3 = figure;
for k = 1:numOfPointSets
    scatter(aligned_pointsets_22(1,:,k),aligned_pointsets_22(2,:,k),'filled','y');
    hold on
end

h1 = plot(mean_shape_22(1,:),mean_shape_22(2,:),'-or','MarkerFaceColor','r');
hold on
h2 = plot(var_32x_plus_3,var_32y_plus_3,'-or','MarkerFaceColor','g');
hold on
h3 = plot(var_32x_minus_3,var_32y_minus_3,'-or','MarkerFaceColor','b');
% hold on
% plot(var_32x_plus_2,var_32y_plus_2,'-or','MarkerFaceColor','black');
% hold on
% plot(var_32x_minus_2,var_32y_minus_2,'-or','MarkerFaceColor','black');
% title("var32")
legend([h1,h2(1),h3(1)], 'Code22: Mean Shape','Code22: +3SD3','Code22: -3SD3')
save('../results/code22_sd3.mat', 'code22_sd3')

%%% Saving the results
save('../results/aligned_pointsets11.mat',"aligned_pointsets_11");
save('../results/aligned_pointsets22.mat',"aligned_pointsets_22");
save('../results/mean_shape_11.mat',"mean_shape_11");
save('../results/mean_shape_22.mat',"mean_shape_22");
save('../results/var_11_plus_3.mat',"var_11_plus_3");
save('../results/var_21_plus_3.mat',"var_21_plus_3");
save('../results/var_31_plus_3.mat',"var_31_plus_3");
save('../results/var_11_minus_3.mat',"var_11_minus_3");
save('../results/var_21_minus_3.mat',"var_21_minus_3");
save('../results/var_31_minus_3.mat',"var_31_minus_3");
save('../results/var_12_plus_3.mat',"var_12_plus_3");
save('../results/var_22_plus_3.mat',"var_22_plus_3");
save('../results/var_32_plus_3.mat',"var_32_plus_3");
save('../results/var_12_minus_3.mat',"var_12_minus_3");
save('../results/var_22_minus_3.mat',"var_22_minus_3");
save('../results/var_32_minus_3.mat',"var_32_minus_3");
