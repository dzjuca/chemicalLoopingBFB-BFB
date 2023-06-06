function Global = fuelReactorDataFcn(Global)
% -------------------------------------------------------------------------
    % fuelReactorDataFcn function 
    % ----------------------------| input |--------------------------------
    % ----------------------------| output |-------------------------------          
% -------------------------------------------------------------------------
    TEMPERATURE_FUEL_REACTOR = 800 + 273.15;%Temp. of air reactor       [K]
    
    MOLAR_FLOW = 10; %                                              [mol/H]
    RATIO_O2 = 0.21; % ratio of O2 in the air                           [%]
    RATIO_N2 = 0.79; % ratio of N2 in the air                           [%]

    MASS_FLOW = 3.0;    %                                            [kg/h]
    RATIO_NI  = 0.18;   % ratio of Ni in the solid                      [%]
    RATIO_NIO = 0.00;   % ratio of NiO in the solid                     [%]
    RATIO_AL2O3 = 0.82; % ratio of Al2O3 in the solid                   [%]

    W_DP = 300.0; % catalyst weight in the dense phase                  [g]
    W_LP = 0.000; % catalyst weight in the lean phase                   [g]
% ----------| Reactor 2 Fuel Reactor |-------------------------------------
    Global.fuelReactor.T_FR       = TEMPERATURE_FUEL_REACTOR;
    Global.fuelReactor.gen        = 2; % gas species number           [#]
    Global.fuelReactor.sen        = 3; % solid species number         [#]
    Global.fuelReactor.Num_sp_dp  = 10;% number of species            [#] 
    Global.fuelReactor.Num_sp_lp  = 0; % number of species            [#]
    Global.fuelReactor.n1         = 40;% mesh points number           [#] 
    Global.fuelReactor.n2         = 0; % mesh points number           [#]
    Global.fuelReactor.nt = Global.fuelReactor.n1 + Global.fuelReactor.n2; 
% ----------| Flow rate and concentration of species |---------------------
% ----- total feed flow in the reactor's bottom ---------------------------
    g_molFlow   = (MOLAR_FLOW/3600);   % 0.010782;                  [mol/s]
    g_volFlow   = g_molFlow*22.4*1000; %                            [cm3/s]
    g_O2_r      = RATIO_O2;            % ratio                          [%]
    g_N2_r      = RATIO_N2;            % ratio                          [%]
    g_O2_c      = g_O2_r*g_molFlow/g_volFlow;%                 [mol O2/cm3]   
    g_N2_c      = g_N2_r*g_molFlow/g_volFlow;%                 [mol N2/cm3]        
% -------------------------------------------------------------------------
    Global.fuelReactor.streamGas.composition.O2  = g_O2_c; %      [mol/cm3]
    Global.fuelReactor.streamGas.composition.N2  = g_N2_c; %      [mol/cm3]
    Global.fuelReactor.streamGas.molarFlow  = g_molFlow;   %        [mol/s]
    Global.fuelReactor.streamGas.volumeFlow = g_volFlow;   %        [cm3/s]
% -------------------------------------------------------------------------
    s_mFlow   = (MASS_FLOW/3.6); %                                    [g/s]
    s_Ni_c    = RATIO_NI;        %                                [gNi/g-c]
    s_NiO_c   = RATIO_NIO;       %                               [gNiO/g-c]
    s_Al2O3_c = RATIO_AL2O3;     %                             [gAl2O3/g-c]
    s_molFlow = s_mFlow*s_Ni_c/Global.streamSolid.mmass.Ni   + ...
                s_mFlow*s_NiO_c/Global.streamSolid.mmass.NiO + ...
                s_mFlow*s_Al2O3_c/Global.streamSolid.mmass.Al2O3;                                  
    Global.fuelReactor.streamSolid.composition.Ni    = s_Ni_c;    %[gNi/g-c]
    Global.fuelReactor.streamSolid.composition.NiO   = s_NiO_c;  %[gNiO/g-c]
    Global.fuelReactor.streamSolid.composition.Al2O3 = s_Al2O3_c; % [gAl2O3/g-c]
    Global.fuelReactor.streamSolid.massFlow   = s_mFlow;          %    [g/s]
    Global.fuelReactor.streamSolid.molarFlow  = s_molFlow;        %  [mol/s]
% ---------- reactor constant data  ---------------------------------------
    Global.fuelReactor.rID_dp = 4.0;% internal diameter dense p.       [cm]
    Global.fuelReactor.rID_lp = 4.0;% internal diameter lean p.        [cm]
    Global.fuelReactor.H_dp = 23.0; % bed height                       [cm]
    Global.fuelReactor.H_lp = 0.00; % bed height                       [cm]
    Global.fuelReactor.H_t  = 94.0; % reactor height                   [cm]

    Global.fuelReactor.Area_dp = pi*(Global.fuelReactor.rID_dp/2)^2; %[cm2]
    Global.fuelReactor.Area_lp = pi*(Global.fuelReactor.rID_lp/2)^2; %[cm2]
    Global.fuelReactor.z_dp    = linspace(0,                        ...
                                Global.fuelReactor.H_dp,            ...
                                Global.fuelReactor.n1)';     % dp_mesh [cm]
    Global.fuelReactor.z_lp    = linspace(Global.fuelReactor.H_dp,  ...
                                Global.fuelReactor.H_t,             ...
                                Global.fuelReactor.n2)';     % lp_mesh [cm]
% -------------------------------------------------------------------------
    Global.fuelReactor.W_dp = W_DP;  % catalyst weight                  [g]
    Global.fuelReactor.W_lp = W_LP;  % catalyst weight                  [g]
    Global.fuelReactor.W_t  = W_DP + W_LP;  % catalyst weight           [g]
% ---------- fluid Dynamics -----------------------------------------------
    Global.fuelReactor.fDynamics.usg0  = ...
    g_volFlow/(Global.fuelReactor.Area_dp);%  [cm/s]
    Global.fuelReactor.fDynamics.fw  = 0.15;  % fraction-wake in bubbles []
    Global.fuelReactor.fDynamics.Emf = 0.45;  % minimum fluid. porosity  []
    Global.fuelReactor.fDynamics.a_u0  = 7;   %                       [s-1]
    Global.fuelReactor.fDynamics.f_d   = 0.3; %                          []
    Global.fuelReactor.fDynamics.Pe_ax = 6;   % Axial Peclet Number      []
% -------------------------------------------------------------------------
end