function RH4 = mbrhs4Fcn(alpha, CT, Tbe, reactorType, Global, ...
                         caracter1, caracter2)
% -------------------------------------------------------------------------
    % mbrhs4Fcn - function allows to obtain the fourth term (Right Hand 
    % Side)of the mass balance model
    % ----------------------------| inlet |--------------------------------
    %     alpha = fraction of bubbles in bed                           f(z)                 
    %        CT = a vector with all concentrations species 
    %             - bubble - wake - emulsion                           f(z)
    % reactorType = airReactor | fuelReactor
    %    Global = constants structure
    %       Tbe = temperature in bed|emulsion phase                     [K]
    % caracter1 = phase identifier (Gas,Solid)
    % caracter2 = species identifier (CH4,CO2, ...)
    %        fw = fraction of wake in bubbles                           [ ]
    %       Emf = minimum fluidization porosity                         [ ]
    %      Dcat = catalyst density                              [g-cat/cm3]
    % ----------------------------| outlet |-------------------------------
    %       RH4 = right-hand side term-4                        [mol/cm3.s]
% -------------------------------------------------------------------------

    fw   = Global.(reactorType).fDynamics.fw;
    Emf  = Global.(reactorType).fDynamics.Emf; 
    Dcat = Global.carrier.rho_s;
    
% -------------------------------------------------------------------------
    if     strcmp(caracter1,'FGBurbuja')

        C_gas    = CT.C_g_b;
        C_solid  = CT.C_s_w;
        temporal = Dcat*(1 - Emf)*fw*alpha;
        cinetica = kineticFcn(C_gas, C_solid, Tbe, reactorType,         ...
                              Global, caracter2);
             RH4 = temporal.*cinetica;

    elseif strcmp(caracter1,'FGEmulsion')

        C_gas    = CT.C_g_e;
        C_solid  = CT.C_s_e;
        temporal = Dcat*(1 - alpha - alpha*fw)*(1 - Emf);
        cinetica = kineticFcn(C_gas, C_solid, Tbe, reactorType,         ...
                              Global, caracter2);  
             RH4 = temporal.*cinetica;

    elseif strcmp(caracter1,'FSEstela')

        C_gas    = CT.C_g_b;
        C_solid  = CT.C_s_w;
        temporal = Dcat*(1 - Emf)*fw*alpha;                                   
        cinetica = kineticFcn(C_gas, C_solid, Tbe, reactorType,         ...
                              Global, caracter2);
             RH4 = temporal.*cinetica;

    elseif strcmp(caracter1,'FSEmulsion')
                % continuar desde aqui % XXXXXXXXXXXX==========================================> desde aquí
        C_gas    = CT.C_g_e;
        C_solid  = CT.C_s_e;
        temporal = Dcat*(1 - Emf)*(1 - alpha - alpha*fw);         
        cinetica = kineticFcn(C_gas, C_solid, Tbe, reactorType,         ...
                              Global, caracter2);
             RH4 = temporal.*cinetica; 
                % continuar desde aqui % XXXXXXXXXXXX==========================================> desde aquí
    else

        disp('Error - Inconsistency - mbrhs4Fcn.m')

    end
% -------------------------------------------------------------------------
end