%% Loading The Data
clear;
load('../data/assignmentSegmentBrain.mat');

%% Initializing parameters

%%% Bias field initialisation
initial_bias = ones(256);

%%% Class means initialisation

histogram(imageData.*imageMask)

% From the plot of the histogram, we can see three intensity peaks (excluding the masked peak) at
% approximately 0.49, 0.23 and 0.6 and these will be the initilizations of the class means

% A better way to determine an initial estimate of class means is by
% performing hard k-means on the given image and taking the class mean
% estimates from there. This is a good estimate because the
% fuzzy-clustering should lie to the hard segmented solution, helping find
% the optimum quicker

% [reference_image, initial_means] = kmeans(reshape(imageData.*imageMask,[256*256,1]),4);
% reference_image = reshape(reference_image,[256,256]);
% 
% class_means = [initial_means(2), initial_means(3), initial_means(4)];

initial_means = [0.636, 0.253, 0.457];

%%% Class memberships initialisation

% To get initial class-menberships, we csn again use the scheme to hard
% k-means segmentation by classifying all pixels closest to particular
% class mean belonging to the class it represents. Again, this is a good
% estimate as the fuzzy solution is expected to be close to the hard
% segmented solution

initial_ujk_vector = zeros([256 256 3]);

d_vector = zeros([256 256 3]);
d_vector(:,:,1) = (imageData - initial_means(1)).^2;
d_vector(:,:,2) = (imageData - initial_means(2)).^2;
d_vector(:,:,3) = (imageData - initial_means(3)).^2;

for i = 1:256
    for j = 1:256
        
        col = d_vector(i,j,:);
        [M, index] = min(col);
        
        initial_ujk_vector(i,j,index) = 1;
        
        for l = 1:length(col)
            
            if l == index
                continue
            end
            
            initial_ujk_vector(i,j,l) = 0;
            
        end
        
    end
end
  
for i = 1:3
    initial_ujk_vector(:,:,i) = initial_ujk_vector(:,:,i).*imageMask;
end

%%% Images of different initial class memberships
figure, imshow(initial_ujk_vector(:,:,1));
figure, imshow(initial_ujk_vector(:,:,2));
figure, imshow(initial_ujk_vector(:,:,3));

%% Visualizing the neighbourhood mask

filter_size = 3;
sigma = 1;

%%% Consider an arbitrary pixel (128, 128)
central_pixel = imageData(128,128);
wij = Gaussian_mask(filter_size,central_pixel,sigma);
imshow(wij);
impixelinfo;

%% Choosing Hyperparameters

filters = [3, 5, 9];
sigmas = [0.5, 1, 1.5];
q_values = [1.6, 2, 5];

%% Tune Hyperparameters

%%% This particular segmnent takes a very long time to run due to the large
%%% number of combinations considered, and each indiviual iteration taking
%%% some time. To run the hyperparameter tuning part, uncomment this
%%% section and comment out the next section where the results of this
%%% tuning have directly been used.

% best_q = q_values(1);
% best_sigma = sigmas(1);
% best_filter = filters(1);
% best_obj = inf;
% 
% for filter_index = 1:3
%     
%     h = waitbar(0,'Please wait...');
%     
%     for sigma_index = 1:3
%         for q_val_index = 1:3
%             
%             q = q_values(q_val_index);
%             filter_size = filters(filter_index);
%             sigma = sigmas(sigma_index);
%             
%             fprintf('For q = %d \n', q);
%             fprintf('For filter_size = %d \n', filter_size);
%             fprintf('For sigma = %d \n', sigma);
%             
%             bias_field = initial_bias;
%             class_means = initial_means;
%             ujk_vector = initial_ujk_vector;
% 
%             obj_cur = objective(imageData,imageMask,bias_field,class_means,filter_size,sigma,ujk_vector,q);
%             %fprintf('Initial value of objective function: %d \n', obj_cur);
% 
%             max_iters = 10;
% 
%             %h = waitbar(0,'Please wait...');
%             for iter = 1:max_iters
% 
%                 new_ujk = ujk_update(imageData,imageMask,bias_field,class_means,filter_size,sigma,ujk_vector,q);
%                 new_bi = bi_update(imageData,imageMask,class_means,filter_size,sigma,ujk_vector,q);
%                 new_ck = ck_update(imageData,imageMask,bias_field,filter_size,sigma,ujk_vector,q);
% 
%                 obj_new = objective(imageData,imageMask,new_bi,new_ck,filter_size,sigma,new_ujk,q);
% 
%                 if obj_new > obj_cur
%                     %fprintf('Terminating...');
%                     break;
%                 end
% 
%                 obj_cur = obj_new;
% 
%                 ujk_vector = new_ujk;
%                 bias_field = new_bi;
%                 class_means = new_ck;
% 
%                 %fprintf('Iteration: %d \n', iter);
%                 %fprintf('Objective Function Value: %d \n', obj_cur);
%                 %fprintf('Class means: %d \n', class_means);
% 
%                 %waitbar(i/max_iters)
% 
%             end
%             %close(h)
%             
%             fprintf('Objective = %d \n', obj_cur);
%             fprintf('----------------------\n');
%             
%             if obj_cur < best_obj
%                 best_obj = obj_cur;
%                 best_q = q;
%                 best_filter = filter_size;
%                 best_sigma = sigma;
%             end
%             
%         end
%     end
%     
%     waitbar(filter_index/4)
%     
% end
% close(h)

%% Directly Using Tuned Hyperparameters

best_q = 5;
best_sigma = 0.5;
best_filter = 3;

%% Running For The Best Hyperparameter Values

bias_field = initial_bias;
class_means = initial_means;
ujk_vector = initial_ujk_vector;

obj_cur = objective(imageData,imageMask,bias_field,class_means,best_filter,best_sigma,ujk_vector,best_q);
fprintf('Initial value of objective function: %d \n', obj_cur);

max_iters = 10;

h = waitbar(0,'Please wait...');
for iter = 1:max_iters
    
    new_ujk = ujk_update(imageData,imageMask,bias_field,class_means,best_filter,best_sigma,ujk_vector,best_q);
    new_bi = bi_update(imageData,imageMask,class_means,best_filter,best_sigma,ujk_vector,best_q);
    new_ck = ck_update(imageData,imageMask,bias_field,best_filter,best_sigma,ujk_vector,best_q);
    
    obj_new = objective(imageData,imageMask,new_bi,new_ck,best_filter,best_sigma,new_ujk,best_q);
    
    if obj_new > obj_cur
        fprintf('Terminating...\n');
        break;
    end
    
    obj_cur = obj_new;
    
    ujk_vector = new_ujk;
    bias_field = new_bi;
    class_means = new_ck;
    
    fprintf('Iteration: %d \n', iter);
    fprintf('Objective Function Value: %d \n', obj_cur);
    
    waitbar(i/max_iters)

end
close(h)

%% Displaying Obtained Images

%%% Corrupted Image
figure, imshow(imageData);
impixelinfo;

%%% Class Membership Estimates 
figure, imshow(ujk_vector(:,:,1));
impixelinfo;

figure, imshow(ujk_vector(:,:,2));
impixelinfo;

figure, imshow(ujk_vector(:,:,3));
impixelinfo;

%%% Bias Field
figure, imshow(bias_field);
impixelinfo;

%%% Bias Removed Image
final_image = zeros(256);

for k = 1:3
    
    final_image = final_image + ujk_vector(:,:,k)*class_means(k);
    
end

figure, imshow(final_image);
impixelinfo;

%%% Residual Image
res = imageData - final_image.*bias_field;

figure, imshow(res)
impixelinfo;

%% Uniqueness Problem

%%% The implementations discussed in class do not guarantee a unique
%%% solution due to the nature in which we have formulated the optimization 
%%% problem. We have assumed the given voxel yi = xi*bi + ni, and in this 
%%% representation, only yi is known with there being a degree of freedom 
%%% to adjust the values of xi according to bi.
