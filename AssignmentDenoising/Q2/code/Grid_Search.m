function [best_alpha, best_gamma] = Grid_Search(Y,NoiselessImage,MRF)
    %GRID SEARCH 
    % To find the best parameters
    
    %for quadratic MRF
    alphas = 0.999:0.0001:1;
    %gammas = [0];
    min_rrmse = 1e7;
    %alphas = 0.99:0.001:0.999;
    %alphas = [0.999];
    gammas = 0.00001:0.00001:0.0001;
    w = waitbar(0,'Finding the best parameters');
    for i = 1:size(gammas,2)
        for j = 1:size(alphas,2)
            
            [denoised,~] = Gradient_Descent(Y,alphas(j),gammas(i),MRF,0);
            
            rrmse = RRMSE(NoiselessImage,denoised);
            
            if min_rrmse>rrmse
                best_alpha = alphas(j);
                best_gamma = gammas(i);
                min_rrmse = rrmse;
            end            
            waitbar(((i - 1)*size(alphas,2) + j) / (size(alphas,2)*size(gammas,2)));
        end     
    end
    close(w);  
end

