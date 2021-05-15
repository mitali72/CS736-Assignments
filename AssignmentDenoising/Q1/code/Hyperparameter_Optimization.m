load('/Users/thomasmacbookair/Desktop/CS736/Assignment-Image-Denoising/data/assignmentImageDenoisingPhantom.mat')

%% Optimizing Parameters of Rician Noise Model & Quadratic Prior

running_rrmse = RRMSE(imageNoiseless,imageNoisy);
disp(running_rrmse)

rq_rrmse = @(alpha)RRMSE(imageNoiseless,Rician_Quad_Grad_Descent(imageNoisy,alpha,30,0));
[best_alpha, best_rrmse] = fminbnd(rq_rrmse,0,1);

disp('Best alpha')
disp(best_alpha)
disp('Corresponding RRMSE')
disp(best_rrmse)

%% Optimizing Parameters of Rician Noise Model & Huber Prior

running_rrmse = RRMSE(imageNoiseless,imageNoisy);
disp(running_rrmse)

rh_rrmse = @(params)RRMSE(imageNoiseless,Rician_Huber_Grad_Descent(imageNoisy,params,30,0));
[best_params, best_rrmse] = patternsearch(rh_rrmse,[0.5,1],[],[],[],[],[0,0],[1,100]);

disp('Best alpha')
disp(best_params(1))
disp('Best gamma')
disp(best_params(2))
disp('Corresponding RRMSE')
disp(best_rrmse)

%% Optimizing Parameters of Rician Noise Model & Discontinuity-Adaptive Prior

running_rrmse = RRMSE(imageNoiseless,imageNoisy);
disp(running_rrmse)

rd_rrmse = @(params)RRMSE(imageNoiseless,Rician_Disc_Grad_Descent(imageNoisy,params,30,0));
[best_params, best_rrmse] = patternsearch(rd_rrmse,[0.5,1],[],[],[],[],[0,0],[1,10]);

disp('Best alpha')
disp(best_params(1))
disp('Best gamma')
disp(best_params(2))
disp('Corresponding RRMSE')
disp(best_rrmse)
