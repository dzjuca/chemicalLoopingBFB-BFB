function r = reactionKineticFcn(C_gas, C_solid, T, data)

%   ko = 0.18;         % [1/s]
    ko = 1.8;         % [1/s]
    R  = data.R*1000;  % [kJ/kmol/K]
    Ea = 7000;         % [kJ/kmol]

    C_O2  = C_gas(1);
    C_Ni  = C_solid(1);
    C_NiO = C_solid(2);

    k = ko*exp(-Ea/R/T);
    r = k*C_O2*(C_Ni/C_NiO)^(2/3);

    r(isinf(r)) = 1e-10;

end