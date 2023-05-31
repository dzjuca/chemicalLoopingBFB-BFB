function rNiO = R_NiO_Fcn(C_gas, C_solid, T, data)
% -------------------------------------------------------------------------
    r    = reactionKineticFcn(C_gas, C_solid, T, data);
    rNiO = 2*r;
% ------------------------------------------------------------------------- 
end

