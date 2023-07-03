function RH1 = mbrhs1Fcn(alpha, ubes, Ci, reactorType, Global, caracter)
% -------------------------------------------------------------------------
    % mbrhs1Fcn - function allows to obtain the first term (Right Hand 
    % Side) of the mass balance model
    % ----------------------------| inlet |--------------------------------
    %    alpha    = fraction of bubbles in bed                         f(z)
    %     ubes    = velocity (gas-bubble/gas-emulsion/solid)           f(z)
    %       Ci    = species concentrations                             f(z)
    % reactorType = airReactor | fuelReactor
    %   Global    = constants structure
    % caracter    = phase identifier (Gas,Solid,Bubble,Emulsion)
    % ----------------------------| outlet |-------------------------------
    %      RH1 = right-hand side term-1    [mol/cm3-s] [gSolid/g-carrier-s]  
% -------------------------------------------------------------------------
    fw   = Global.(reactorType).fDynamics.fw;
    Emf  = Global.(reactorType).fDynamics.Emf; 
    Dcat = Global.carrier.rho_s;
    z_dp = Global.(reactorType).z_dp;
    xl   = z_dp(1);
    xu   = z_dp(end);
    n1   = Global.(reactorType).n1;
% -------------------------------------------------------------------------
    if     strcmp(caracter,'FGBurbuja')
            temporal = (alpha+alpha*fw*Emf).*ubes.*Ci;
                 RH1 = dss012(xl,xu,n1,temporal, 1);
                %RH1 = dss020(xl,xu,n,temporal, 1)';
                %RH1 = dss004(xl,xu,n,temporal)';
    elseif strcmp(caracter,'FGEmulsion')
            temporal = (1-alpha-alpha*fw)*Emf.*ubes.*Ci;
                 RH1 = dss012(xl,xu,n1,temporal, 1);
                %RH1 = dss020(xl,xu,n,temporal, 1)';
                %RH1 = dss004(xl,xu,n,temporal)';
    elseif strcmp(caracter,'FSEstela')
            temporal = Dcat*(1-Emf)*alpha*fw.*ubes.*Ci;
                 %RH1 = dss012(xl,xu,n,temporal, 1);
                  RH1 = dss020(xl,xu,n1,temporal, 1)';
                 %RH1 = dss004(xl,xu,n,temporal)';
    elseif strcmp(caracter,'FSEmulsion')
            temporal = (1-alpha-alpha*fw)*(1-Emf)*Dcat.*ubes.*Ci;
                 %RH1 = dss012(xl,xu,n,temporal, -1);
                 RH1 = dss020(xl,xu,n1,temporal, -1)';
                 %RH1 = dss004(xl,xu,n,temporal)';
    else
            disp('Error - The caracter in the mbrhs1Fcn.m is not correct')
    end
% -------------------------------------------------------------------------
end