%%% This is the main script running all the models with tuned
%%% hyperparameter values. The tuning part can be found in a seperate
%%% script called Hyperparameter_Optimization.m

clear;
load('../data/assignmentImageDenoisingPhantom.mat');

%% Part A - Initial RRMSE

rrmse = RRMSE(imageNoiseless,imageNoisy);
disp('RRMSE between the noisy and noiseless images is:');
disp(rrmse);

disp('---------------------------');

%% Part B - Results

%%% MRF prior: Quadratic function

disp('Results with a Quadratic prior and Rician noise model');

best_alpha = 0.9602;

%RRMSE at optimum value of alpha
denoised_quad = Rician_Quad_Grad_Descent(imageNoisy,best_alpha,30,0);
rrmse = RRMSE(imageNoiseless,denoised_quad);
disp('RRMSE at optimum alpha');
disp(rrmse);

%RRMSE at alpha = 1 (since 1.2*a is >1 and out of range)
denoised = Rician_Quad_Grad_Descent(imageNoisy,1,30,0);
rrmse = RRMSE(imageNoiseless,denoised);
disp('RRMSE at alpha = 1 since 1.2*a is >1');
disp(rrmse);

%RRMSE at alpha = 1 (since 0.8*a = 0.7682)
denoised = Rician_Quad_Grad_Descent(imageNoisy,0.7682,30,0);
rrmse = RRMSE(imageNoiseless,denoised);
disp('RRMSE at 0.8*alpha');
disp(rrmse);

disp('---------------------------');

%%% MRF prior: Huber function

best_alpha = 0.9997;
best_gamma = 1.6975e-04;

disp('Results with a Huber prior and Rician noise model');

%RMSE at (a*,b*)
denoised_huber = Rician_Huber_Grad_Descent(imageNoisy,[best_alpha,best_gamma],30,0);
rrmse = RRMSE(imageNoiseless,denoised_huber);
disp('RRMSE at optimum alpha and gamma');
disp(rrmse);

%RMSE at (1,b*) since 1.2*alpha>1
denoised = Rician_Huber_Grad_Descent(imageNoisy,[1,best_gamma],30,0);
rrmse = RRMSE(imageNoiseless,denoised);
disp('RRMSE at alpha = 1 since 1.2*a is >1 and optimum gamma');
disp(rrmse);

%RMSE at (0.8a,b*) 
denoised = Rician_Huber_Grad_Descent(imageNoisy,[0.8*best_alpha,best_gamma],30,0);
rrmse = RRMSE(imageNoiseless,denoised);
disp('RRMSE at 0.8*alpha and optimum gamma');
disp(rrmse);

%RMSE at (a,1.2b*) 
denoised = Rician_Huber_Grad_Descent(imageNoisy,[best_alpha,1.2*best_gamma],30,0);
rrmse = RRMSE(imageNoiseless,denoised);
disp('RRMSE at optimum alpha and 1.2*gamma');
disp(rrmse);

%RMSE at (a,0.8b*) 
denoised = Rician_Huber_Grad_Descent(imageNoisy,[best_alpha,0.8*best_gamma],30,0);
rrmse = RRMSE(imageNoiseless,denoised);
disp('RRMSE at optimum alpha and 0.8*gamma');
disp(rrmse);

disp('---------------------------');

%%% MRF prior: Discontinuity-Adaptive function

disp('Results with a Adaptive-Discontinuity prior and Rician noise model');

best_alpha = 0.9825;
best_gamma = 9.7881;

%RMSE at (a*,b*)
denoised_disc = Rician_Disc_Grad_Descent(imageNoisy,[best_alpha,best_gamma],30,0);
rrmse = RRMSE(imageNoiseless,denoised_disc);
disp('RRMSE at optimum alpha and gamma');
disp(rrmse);

%RMSE at (1,b*) since 1.2*alpha>1
denoised = Rician_Disc_Grad_Descent(imageNoisy,[1,best_gamma],30,0);
rrmse = RRMSE(imageNoiseless,denoised);
disp('RRMSE at alpha = 1 since 1.2*a is >1 and optimum gamma');
disp(rrmse);

%RMSE at (0.8a,b*) 
denoised = Rician_Disc_Grad_Descent(imageNoisy,[0.8*best_alpha,best_gamma],30,0);
rrmse = RRMSE(imageNoiseless,denoised);
disp('RRMSE at 0.8*alpha and optimum gamma');
disp(rrmse);

%RMSE at (a,1.2b*) 
denoised = Rician_Disc_Grad_Descent(imageNoisy,[best_alpha,1.2*best_gamma],30,0);
rrmse = RRMSE(imageNoiseless,denoised);
disp('RRMSE at optimum alpha and 1.2*gamma');
disp(rrmse);

%RMSE at (a,0.8b*) 
denoised = Rician_Disc_Grad_Descent(imageNoisy,[best_alpha,0.8*best_gamma],30,0);
rrmse = RRMSE(imageNoiseless,denoised);
disp('RRMSE at optimum alpha and 0.8*gamma');
disp(rrmse);

disp('---------------------------');

%% Part C - JET Colormaps

myNumOfColors = 200;
myColorScale = [ [0:1/(myNumOfColors-1):1]' , ... 
[0:1/(myNumOfColors-1):1]' , [0:1/(myNumOfColors-1):1]' ]; 

figure;
imagesc (single (imageNoiseless));
title('Noiseless Image');
colormap (myColorScale);
colormap jet;
daspect ([1 1 1]);
axis tight;
colorbar;

figure;
imagesc (single (imageNoisy));
title('Noisy Image');
colormap (myColorScale);
colormap jet;
daspect ([1 1 1]);
axis tight;
colorbar;

figure;
imagesc (single (denoised_quad));
title('Image denoised using quadratic prior');
colormap (myColorScale);
colormap jet;
daspect ([1 1 1]);
axis tight;
colorbar;

figure;
imagesc (single (denoised_huber));
title('Image denoised using Huber prior');
colormap (myColorScale);
colormap jet;
daspect ([1 1 1]);
axis tight;
colorbar;

figure;
imagesc (single (denoised_disc));
title('Image denoised using discontinuity-adaptive prior');
colormap (myColorScale);
colormap jet;
daspect ([1 1 1]);
axis tight;
colorbar;

% cd assignmentImageDenoising/;
save('../results/denoised_quad.mat',"denoised_quad");
save('../results/denoised_disc.mat',"denoised_disc");
save('../results/denoised_huber.mat',"denoised_huber");

%% Part D
%%% Objective Function (negative log likelihood) vs iterations

%%% MRF prior: Quadratic function
best_alpha = 0.9602;

%Setting the last argument = 1 enables plotting the objective function
denoised_quad = Rician_Quad_Grad_Descent(imageNoisy,best_alpha,30,1);

%%% MRF prior: Huber function
best_alpha = 0.9997;
best_gamma = 1.6975e-04;

%Setting the last argument = 1 enables plotting the objective function
denoised_huber = Rician_Huber_Grad_Descent(imageNoisy,[best_alpha,best_gamma],30,1);

%%% MRF prior: Discontinuity-Adaptive function
best_alpha = 0.9825;
best_gamma = 9.7881;

%Setting the last argument = 1 enables plotting the objective function
denoised_disc = Rician_Disc_Grad_Descent(imageNoisy,[best_alpha,best_gamma],30,1);