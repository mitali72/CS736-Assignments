function out = Huber_Function(x,gamma)
%HUBER_FUNCTION 
u = abs(x);

if u <= gamma
    out = 0.5 * u^2;
else
    out = gamma*u - 0.5*gamma^2;
end

end

