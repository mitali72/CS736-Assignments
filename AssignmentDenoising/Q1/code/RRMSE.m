function out = RRMSE(A, B)
%Calculates the RRMSE between two images

abs_A = abs(A);
abs_B = abs(B);

C = abs_A.^2;
D = (abs_A - abs_B).^2;

Z = sum(D, 'all')/sum(C, 'all');
out = sqrt(Z);

end

