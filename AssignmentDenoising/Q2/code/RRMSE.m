function rrmse = RRMSE(A,B)
    %RRMSE 
    % A: Noiseless image ; B: Denoised image
    
    Diff = (abs(A)-abs(B)).^2;
    num = sqrt(sum(Diff,'all'));
    denom = sqrt(sum(A.^2,'all'));
    rrmse = num/denom;
end

