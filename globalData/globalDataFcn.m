function Global = globalDataFcn()
% -------------------------------------------------------------------------
      % globalData-function return a structure 'Global' with data constants
% -------------------------------------------------------------------------
% -------------------- | General Data |------------------------------------
      Global.R          = 8.314472e-3;   % Universal Gas Constant [kJ/molK]    
      Global.P          = 1.01325;       % Pressure                   [bar]  
      Global.P_atm      = 1;             % Pressure                   [atm]  
      Global.R_atm      = 0.08206;       % Universal Constant  [atm L/molK]
      Global.Tbed       = (623 + 273.15);% Temperature                  [K]
      Global.g          = 981.0;         % Gravity                  [cm/s2]
      Global.iterations = Iterations.getInstance();% number of iterations
% -------------------------------------------------------------------------
      Global.streamGas.mmass.N2      = 28.0140;  % - N2             [g/mol]
      Global.streamGas.mmass.O2      = 31.9990;  % - O2             [g/mol]
      Global.streamSolid.mmass.Ni    = 58.6934;  % - Ni             [g/mol]
      Global.streamSolid.mmass.NiO   = 74.6920;  % - NiO            [g/mol]
      Global.streamSolid.mmass.Al2O3 = 101.9610; % - Al2O3          [g/mol]
% -------------------------------------------------------------------------
% -------------------------------------------------------------------------
      Global = airReactorDataFcn(Global);
      Global = fuelReactorDataFcn(Global);

% ----------| FIT'S Functions |--------------------------------------------
      data_mu               = load('data_mu.mat');
      [fit_mu_N2, ~]        = muFitFcn(data_mu.T_N2, data_mu.mu_N2);
      [fit_mu_O2, ~]        = muFitFcn(data_mu.T_O2, data_mu.mu_O2);
      Global.fits.mu_p.N2 = fit_mu_N2;%                            [g/cm s]
      Global.fits.mu_p.O2 = fit_mu_O2;%                            [g/cm s]
% ---------- fluid Dynamics -----------------------------------------------
      Global.fDynamics.usg0  = g_volFlow/(Global.reactor.rArea1);%   [cm/s]
      Global.fDynamics.fw    = 0.15;% fraction of wake in bubbles        []
      Global.fDynamics.Emf_1 = 0.45;% minimum fluidization porosity      []
      Global.fDynamics.a_u0  = 7;   %                                 [s-1]
      Global.fDynamics.f_d   = 0.3; %                                    []
      Global.fDynamics.Pe_ax = 6;  % Axial Peclet Number                 []
% ---------- Carrier Data -------------------------------------------------
      Global.carrier.R       = 8.314472;  % Universal Gas Constant [J/molK] 
      Global.carrier.a0      = 1020000;   % specific surface area   [cm2/g]
      Global.carrier.load    = 300;       % catalyst weight             [g]
      Global.carrier.dp          = 0.014; % particle diameter          [cm]
      Global.carrier.bulkDensity = 1.0;   % particle density        [g/cm3]
      Global.carrier.sphericity  = 0.95;  % particle sphericity          []
      Global.carrier.rho_s       = 3.8;   % particle density        [g/cm3]
% ---------- molar mass for each specie -----------------------------------
      Global.MassBalance.mmass.O2 = 31.9990;% - O2                  [g/mol]
      Global.MassBalance.mmass.N2 = 28.0140;% - N2                  [g/mol]
% ---------- Potentials for each compound - LENNARD-JONES -----------------
      Global.MassBalance.SIGMA.O2 = 3.467;% - O2                        [A]
      Global.MassBalance.SIGMA.N2 = 3.798;% - N2                        [A]
      Global.MassBalance.EK.O2    = 106.7;% - O2                        [K]
      Global.MassBalance.EK.N2    = 71.40;% - N2                        [K]
% -------------------------------------------------------------------------
% ---------- thermal conductivity - constant E ---------------------------- 
      Global.E = 1;                  %   E - numeral constant near to 1  []
      Global.k_factor = 0;           %   k - factor correction           [] 
% ---------| viscosity constants data |------------------------------------
% ---------- experimental temperature was used to determine Tc and Pc -----
      Global.Tb.CH4 = 111.66;        % - CH4                            [K] 
      Global.Tb.CO2 = 81.660;        % - CO2                            [K] # pendiente revisar el valor (no existe en las tablas)
      Global.Tb.CO  = 81.660;        % - CO                             [K] 
      Global.Tb.H2  = 20.270;        % - H2                             [K] 
      Global.Tb.H2O = 373.15;        % - H2O                            [K] 
      Global.Tb.N2  = 77.350;        % - N2                             [K] 
% ---------- volume, critical constant for each specie --------------------
      Global.Vc.CH4 = 98.600;        % - CH4                      [cm3/mol]
      Global.Vc.CO2 = 94.070;        % - CO2                      [cm3/mol]
      Global.Vc.CO  = 93.100;        % - CO                       [cm3/mol]
      Global.Vc.H2  = 64.200;        % - H2                       [cm3/mol]
      Global.Vc.H2O = 55.950;        % - H2O                      [cm3/mol]
      Global.Vc.N2  = 90.100;        % - N2                       [cm3/mol]
% ---------- dipole moment for each specie --------------------------------
      Global.Mu.CH4 = 0.00;          % CH4                         [debyes]
      Global.Mu.CO2 = 0.00;          % CO2                         [debyes]
      Global.Mu.CO  = 0.10;          % CO                          [debyes]
      Global.Mu.H2  = 0.00;          % H2                          [debyes]
      Global.Mu.H2O = 1.80;          % H2O                         [debyes]
      Global.Mu.N2  = 0.00;          % N2                          [debyes]
% ---------- molar mass for each specie -----------------------------------


% ---

      Global.MMG.CH4 = 16.0426;      % - CH4                        [g/mol]
      Global.MMG.CO2 = 44.0090;      % - CO2                        [g/mol]
      Global.MMG.CO  = 28.0100;      % - CO                         [g/mol]
      Global.MMG.H2  = 2.01580;      % - H2                         [g/mol]
      Global.MMG.H2O = 18.0148;      % - H2O                        [g/mol]
      Global.MMG.N2  = 28.0140;      % - N2                         [g/mol]
      Global.MMS.NiO = 74.7100;      % - NiO(s)                     [g/mol]  
      Global.MMS.Ni  = 58.7100;      % - Ni(s)                      [g/mol]   
      Global.MMS.C   = 12.0110;      % - C(s)                       [g/mol]   
% ---------- temperature for each specie - critical constant --------------
      Global.Tcr.CH4 = 190.56;       % - CH4                            [K]
      Global.Tcr.CO2 = 304.12;       % - CO2                            [K]
      Global.Tcr.CO  = 132.85;       % - CO                             [K]
      Global.Tcr.H2  = 32.980;       % - H2                             [K]
      Global.Tcr.H2O = 647.14;       % - H2O                            [K]
      Global.Tcr.N2  = 126.20;       % - N2                             [K]
% ---------- pressure for each specie - critical constant -----------------
      Global.Pcr.CH4 = 45.990;       % - CH4                          [bar]
      Global.Pcr.CO2 = 73.740;       % - CO2                          [bar]
      Global.Pcr.CO  = 34.940;       % - CO                           [bar]
      Global.Pcr.H2  = 12.930;       % - H2                           [bar]
      Global.Pcr.H2O = 220.64;       % - H2O                          [bar]
      Global.Pcr.N2  = 33.980;       % - N2                           [bar]
% -------------------------------------------------------------------------
end