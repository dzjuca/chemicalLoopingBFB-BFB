function ut = terminalVelocityFcn(Cgas, T, gasSpecies, Global)
% -------------------------------------------------------------------------
    % terminalVelocityFcn function 
    % ----------------------------| input |--------------------------------
    % ----------------------------| output |-------------------------------            
% -------------------------------------------------------------------------
% --------------------| constants values |---------------------------------
    dp      = Global.carrier.dp;
    rho_s   = Global.carrier.rho_s ;
    g       = Global.g; 
% -------------------------------------------------------------------------
    mu_g    = gasMixViscosityFcn(Cgas, T, gasSpecies, Global);
    rho_g   = gasMixDensityFcn(Cgas, T, gasSpecies, Global);

    ut1 = (dp^2)*(rho_s - rho_g)*g/(18*mu_g);
    ut2 = ((3.03*dp*(rho_s - rho_g)*g)/(rho_g))^(1/2);
    ut3 = ((4/225)*(((dp^3)*((rho_s - rho_g)^2)*(g^2))/(rho_g*mu_g)))^(1/3);

    Re_p_1 = (dp*rho_g*ut1)/mu_g;
    Re_p_2 = (dp*rho_g*ut2)/mu_g;
    Re_p_3 = (dp*rho_g*ut3)/mu_g;

    if (Re_p_1 < 0.4)

        ut = ut1;

    elseif (Re_p_2 >= 0.4 && Re_p_2 < 500)

        ut = ut2;

    elseif (Re_p_3 >= 500 && Re_p_3 <= 2e5)

        ut = ut3;

    else

        ut = ut1;
        disp('Warning: Re_p')
        disp([Re_p_1, Re_p_2, Re_p_3])

    end
% -------------------------------------------------------------------------
end