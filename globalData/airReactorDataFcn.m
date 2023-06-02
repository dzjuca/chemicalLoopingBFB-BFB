function Global = airReactorDataFcn(Global)
% -------------------------------------------------------------------------
    % airReactorDataFcn function 
    % ----------------------------| input |--------------------------------
    % ----------------------------| output |-------------------------------            
% -------------------------------------------------------------------------
    MOLAR_FLOW = 10; %                                              [mol/H]
    RATIO_O2 = 0.21; % ratio of O2 in the air                           [%]
    RATIO_N2 = 0.79; % ratio of N2 in the air                           [%]

    MASS_FLOW = 3.0;    %                                            [kg/h]
    RATIO_NI  = 0.18;   % ratio of Ni in the solid                      [%]
    RATIO_NIO = 0.00;   % ratio of NiO in the solid                     [%]
    RATIO_AL2O3 = 0.82; % ratio of Al2O3 in the solid                   [%]
% ----------| Reactor 1 Air Reactor  |-------------------------------------
    Global.airReactor.gen        = 2; % gas species number              [#]
    Global.airReactor.sen        = 3; % solid species number            [#]
    Global.airReactor.Num_sp_dp  = 10;% number of species               [#] 
    Global.airReactor.Num_sp_lp  = 0; % number of species               [#]
    Global.airReactor.n1         = 40;% mesh points number              [#] 
    Global.airReactor.n2         = 0; % mesh points number              [#]
    Global.airReactor.nt = Global.airReactor.n1 + Global.airReactor.n2; 
% ----------| Flow rate and concentration of species |---------------------
% ----- total feed flow in the reactor's bottom ---------------------------
    g_molFlow   = (MOLAR_FLOW/3600);   % 0.010782;                  [mol/s]
    g_volFlow   = g_molFlow*22.4*1000; %                            [cm3/s]
    g_O2_r      = RATIO_O2;            % ratio                          [%]
    g_N2_r      = RATIO_N2;            % ratio                          [%]
    g_O2_c      = g_O2_r*g_molFlow/g_volFlow;%                 [mol O2/cm3]   
    g_N2_c      = g_N2_r*g_molFlow/g_volFlow;%                 [mol N2/cm3]        
    % ---------------------------------------------------------------------
    Global.airReactor.streamGas.composition.O2  = g_O2_c; %       [mol/cm3]
    Global.airReactor.streamGas.composition.N2  = g_N2_c; %       [mol/cm3]
    Global.airReactor.streamGas.molarFlow  = g_molFlow;   %         [mol/s]
    Global.airReactor.streamGas.volumeFlow = g_volFlow;   %         [cm3/s]
% -------------------------------------------------------------------------
    s_mFlow   = (MASS_FLOW/3.6); %                                    [g/s]
    s_Ni_c    = RATIO_NI;        %                                [gNi/g-c]
    s_NiO_c   = RATIO_NIO;       %                               [gNiO/g-c]
    s_Al2O3_c = RATIO_AL2O3;     %                             [gAl2O3/g-c]
    s_molFlow = s_mFlow*s_Ni_c/Global.streamSolid.mmass.Ni   + ...
                s_mFlow*s_NiO_c/Global.streamSolid.mmass.NiO + ...
                s_mFlow*s_Al2O3_c/Global.streamSolid.mmass.Al2O3;                                  
    Global.airReactor.streamSolid.composition.Ni    = s_Ni_c;    %[gNi/g-c]
    Global.airReactor.streamSolid.composition.NiO   = s_NiO_c;  %[gNiO/g-c]
    Global.airReactor.streamSolid.composition.Al2O3 = s_Al2O3_c; % [gAl2O3/g-c]
    Global.airReactor.streamSolid.massFlow   = s_mFlow;          %    [g/s]
    Global.airReactor.streamSolid.molarFlow  = s_molFlow;        %  [mol/s]

% ---------- reactor constant data  ---------------------------------------
    Global.airReactor.reactor.rID_dp = 4;% internal diameter dense p.  [cm]
    Global.airReactor.reactor.rID_lp = 4;% internal diameter lean p.   [cm]

    %%%%% te quedas aqui
    Global.reactor.bHeight = 23; % bed height                          [cm]
    Global.reactor.rHeight = 94; % reactor height                    [cm]
    Global.reactor.rArea1  = pi*(Global.reactor.rID/2)^2; % area    [cm2]
    Global.reactor.z1      = linspace(0,                       ...
                                Global.reactor.bHeight,      ...
                                Global.n1)'; % mesh                [cm]
    Global.reactor.z2      = linspace(Global.reactor.bHeight,  ...
                                    Global.reactor.rHeight,  ...
                                    Global.n2)'; % mesh2           [cm]
% -------------------------------------------------------------------------
end
