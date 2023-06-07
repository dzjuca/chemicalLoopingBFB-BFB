function mu_g = gasMixViscosityFcn(Cgas, T, gasSpecies, Global)
% -------------------------------------------------------------------------
    % gasMixViscosityFcn function 
    % ----------------------------| input |--------------------------------
    %   Cgas      = vector with concentration for each species    [mol/cm3]
    %   T         = temperature                                         [K]
    %  gasSpecies = cell array with gas species names
    %   Global    = global data structure
    % ----------------------------| output |-------------------------------
    %   mu_g   = gas mix viscosity                                 [g/cm/s]
% -------------------------------------------------------------------------

    [m, n]  = size(Cgas);
    yi_gas  = molarFractionFcn(Cgas);
    M       = Global.streamGas.mmass;
    mum_gas = zeros(m, n);
    
% -------------------------------------------------------------------------
    for i = 1:n

        tmp_1 = zeros(m, n);
        mu_p  = Global.fits.mu_p.(gasSpecies{i})(T);

        for j = 1:n

            tmp_1(:,j) = yi_gas(:,j).*((M.(gasSpecies{i})./M.(gasSpecies{j}))^(1/2));

        end

        mum_gas(:,i) =  yi_gas(:,i).*mu_p./sum(tmp_1, 2);
        
    end
% -------------------------------------------------------------------------
    mu_g = sum(mum_gas, 2);
% -------------------------------------------------------------------------
end