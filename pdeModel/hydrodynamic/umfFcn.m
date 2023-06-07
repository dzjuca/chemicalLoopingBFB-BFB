function umf = umfFcn(Cgas, T, gasSpecies, fluidizedType, Global)
% -------------------------------------------------------------------------
    % umfFcn - function to calculate the minimal fluiditation velocity
    % ----------------------------| input |--------------------------------
    %  Global = constant values structure 
    %      dp =  the diameter of the carrier particles                 [cm]
    % ----------------------------| output |-------------------------------
    %     umf =  the minimal fluiditation velocity                   [cm/s]
    % ---------------------------------------------------------------------
% --------------------| constants values |---------------------------------
    dp      = Global.carrier.dp;
    phi     = Global.carrier.sphericity;
    rho_s   = Global.carrier.rho_s ;
    g       = Global.g;               
% -------------------------------------------------------------------------
    mu_g    = gasMixViscosityFcn(Cgas, T, gasSpecies, Global);
    rho_g   = gasMixDensityFcn  (Cgas, T, gasSpecies, Global);
    Emf     = EmfFcn(fluidizedType, Global);
% --------------------| Reynolds Particle |--------------------------------
    umf_1   = (((phi*dp)^2)/(150))*((rho_s - rho_g)*g/(mu_g))*((Emf^3)/(1 - Emf));
    % ---------------------------------------------------------------------
    umf_2   = (((phi*dp)/(1.75))*((rho_s - rho_g)*g/(rho_g))*(Emf^3))^(1/2);
% -------------------------------------------------------------------------
    Re_p_mf_1 = reynoldsParticleFcn(rho_g, dp, umf_1, mu_g);
    Re_p_mf_2 = reynoldsParticleFcn(rho_g, dp, umf_2, mu_g);
% -------------------------------------------------------------------------
    if (Re_p_mf_1 < 20)
        umf = umf_1;
    elseif(Re_p_mf_2 > 1000)
        umf = umf_2;
    else
        umf = umf_1;
        disp('The minimal fluiditation velocity is not < 20 or > 1000');
    end
% -------------------------------------------------------------------------
end