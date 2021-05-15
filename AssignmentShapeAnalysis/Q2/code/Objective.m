function obj = Objective(S1, S2, s, R)
%OBJECTIVE 

S1_trans = R*S1;

S1_trans = s.*S1_trans;

S = (S2 - S1_trans).^2;
obj = sum(S, 'all');

end