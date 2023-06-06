function Global = globalDataFcn()
% -------------------------------------------------------------------------
      % globalData-function return a structure 'Global' with data constants
% -------------------------------------------------------------------------
      TYPE_PROCESS      = 'BFB-BFB';% 'BFB-BFB' or 'PC-BFB' or 'FF-BFB''
      GRAVITY             = 981.00;   % Gravity                     [cm/s2]
      PRESSURE_REACTOR    = 1.01325;     %Pressure of air reactor     [bar]
      UNIVERSAL_CONSTANT  = 8.314472e-3; %Universal Gas Cons.     [kJ/molK]
% -------------------- | General Data |------------------------------------
      Global.R             = UNIVERSAL_CONSTANT;   
      Global.P             = PRESSURE_REACTOR;
      Global.P_atm         = 1;          % Pressure                   [atm]  
      Global.R_atm         = 0.08206;    % Universal Constant  [atm L/molK]
      Global.g             = GRAVITY;         
      Global.typeProcess   = TYPE_PROCESS;
      Global.iterations    = Iterations.getInstance();%number of iterations
% -------------------------------------------------------------------------
      Global.streamGas.mmass.N2      = 28.0140;  % - N2             [g/mol]
      Global.streamGas.mmass.O2      = 31.9990;  % - O2             [g/mol]
      Global.streamSolid.mmass.Ni    = 58.6934;  % - Ni             [g/mol]
      Global.streamSolid.mmass.NiO   = 74.6920;  % - NiO            [g/mol]
      Global.streamSolid.mmass.Al2O3 = 101.9610; % - Al2O3          [g/mol]
% ---------- Carrier Data -------------------------------------------------
      Global.carrier.R       = 8.314472;  % Universal Gas Constant [J/molK] 
      Global.carrier.a0      = 1020000;   % specific surface area   [cm2/g]
      Global.carrier.dp          = 0.014; % particle diameter          [cm]
      Global.carrier.bulkDensity = 1.0;   % particle density        [g/cm3]
      Global.carrier.sphericity  = 0.95;  % particle sphericity          []
      Global.carrier.rho_s       = 3.8;   % particle density        [g/cm3]
% -------------------------------------------------------------------------
% ---------- molar mass for each specie -----------------------------------
      Global.MassBalance.mmass.O2 = 31.9990;% - O2                  [g/mol]
      Global.MassBalance.mmass.N2 = 28.0140;% - N2                  [g/mol]
% ---------- Potentials for each compound - LENNARD-JONES -----------------
      Global.MassBalance.SIGMA.O2 = 3.467;% - O2                        [A]
      Global.MassBalance.SIGMA.N2 = 3.798;% - N2                        [A]
      Global.MassBalance.EK.O2    = 106.7;% - O2                        [K]
      Global.MassBalance.EK.N2    = 71.40;% - N2                        [K]
% ----------| FIT'S Functions |--------------------------------------------
      data_mu               = load('data_mu.mat');
      [fit_mu_N2, ~]        = muFitFcn(data_mu.T_N2, data_mu.mu_N2);
      [fit_mu_O2, ~]        = muFitFcn(data_mu.T_O2, data_mu.mu_O2);
      Global.fits.mu_p.N2 = fit_mu_N2;%                            [g/cm s]
      Global.fits.mu_p.O2 = fit_mu_O2;%                            [g/cm s]
% -------------------------------------------------------------------------
      Global = airReactorDataFcn(Global);
      Global = fuelReactorDataFcn(Global);
% -------------------------------------------------------------------------
end