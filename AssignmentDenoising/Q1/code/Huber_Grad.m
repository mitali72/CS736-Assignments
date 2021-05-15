function grad = Huber_Grad(u,gamma)
%HUBER_GRAD 

if abs(u) <= gamma
    grad = u;
else
    grad = gamma*sign(u);
end

end

