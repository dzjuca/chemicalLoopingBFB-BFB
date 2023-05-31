function kinetic = kineticFcn(C_gas, C_solid, T, Global, id)
% -------------------------------------------------------------------------
    % kineticFcn function 
    % ----------------------------| input |--------------------------------
    %        C_gas = matrix with the concentrations for ...
    %                each gaseous specie                          [mol/cm3]
    %      C_solid = matrix with the concentrations for ...
    %                each solid specie                            [mol/cm3]
    %           T = phase temperature                                   [K]
    %      Global = constant values structure                            []
    %          id = species|reaction identifier                          []
    % ----------------------------| output |-------------------------------
    %     kinetic = reaction rate of each species               [mol/cm3 s]                   
% -------------------------------------------------------------------------
    index1  = Global.n1;
    kinetic = zeros(index1,1);
    data    = Global.carrier;
% -------------------------------------------------------------------------
    for  i = 1:index1 

        C_gas_z   = C_gas(i,:);
        C_solid_z = C_solid(i,:); 
        T_z       = T(i);
% -------------------------------------------------------------------------
        if     strcmp(id,'O2')
                kinetic(i,1) = R_O2_Fcn(C_gas_z,C_solid_z,T_z,data);

        elseif strcmp(id,'N2')
                kinetic(i,1) = 0.0;

        elseif strcmp(id,'Ni') 
                kinetic(i,1) = R_Ni_Fcn(C_gas_z,C_solid_z,T_z,data);
          
        elseif strcmp(id,'NiO')
                kinetic(i,1) = R_NiO_Fcn(C_gas_z,C_solid_z,T_z,data);

        elseif strcmp(id,'Al2O3')
                kinetic(i,1) = 0.0;
           
        else
            disp('CineticaFcn.m error')
        end 
% -------------------------------------------------------------------------
    end                     
% ------------------------------------------------------------------------- 
end
