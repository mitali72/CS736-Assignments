clear;
load('../data/brainMRIslice.mat');

Y = brainMRIsliceNoisy;
Noiseless = brainMRIsliceOrig;
%% Quadratic MRF

[best_alpha_quad,~] = Grid_Search(Y,Noiseless,"Quadratic");
disp('Quadratic penalty');
eg = ['Best Alpha: ',num2str(best_alpha_quad)];
disp(eg);

[denoised_quad,obj] = Gradient_Descent(Y,best_alpha_quad,0,"Quadratic",1);
figure;
imshow(denoised_quad);
figure;
plot(obj);

% alpha = 0.997
%% Discontinuity-adaptive Huber Penalty function

[best_alpha_huber,best_gamma_huber] = Grid_Search(Y,Noiseless,"Huber");
disp('Huber penalty');
eg = ['Best gamma: ',num2str(best_gamma_huber),' ; Best Alpha: ',num2str(best_alpha_huber)];
disp(eg);

[denoised_huber,obj] = Gradient_Descent(Y,best_alpha_huber,best_gamma_huber,"Huber",1);
figure;
imshow(denoised_huber);
figure;
plot(obj);

% gamma=0.00017, alpha = 1,0.1426

%% Discontinuity-adaptive penalty function

[best_alpha_adap,best_gamma_adap] = Grid_Search(Y,Noiseless,"Adaptive");
disp('Discontinuity Adaptive penalty');
eg = ['Best gamma: ',num2str(best_gamma_adap),' ; Best Alpha: ',num2str(best_alpha_adap)];
disp(eg);

[denoised_adap,obj] = Gradient_Descent(Y,best_alpha_adap,best_gamma_adap,"Adaptive",1);
figure;
imshow(denoised_adap);
figure;
plot(obj);

%gamma = 0.000165, alpha = 1
%%

file = 'best_params.mat';
save(file,'best_alpha_quad','best_alpha_huber','best_gamma_huber','best_alpha_adap','best_gamma_adap');