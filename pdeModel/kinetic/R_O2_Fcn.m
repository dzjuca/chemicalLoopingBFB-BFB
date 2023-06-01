function rO2 = R_O2_Fcn(C_gas, C_solid, T, data)

    r   = reactionKineticFcn(C_gas, C_solid, T, data);
    rO2 = -r;
    
end