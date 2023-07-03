function RH3 = mbrhs3Fcn(alpha, db, ub, CiBW, CiE, CTBW, Tbe, ...
                         reactorType, Global, caracter1, caracter2)
% -------------------------------------------------------------------------
    % mbrhs3Fcn - function allows to obtain the third term (Right Hand 
    % Side) of the mass balance model
    % ----------------------------| inlet |--------------------------------
    %     alpha = fraction of bubbles in bed                           f(z)
    %        db = bubble diameter                                      f(z)
    %        ub = bubbles velocity                              f(z) [cm/s]
    %      CiBW = concentration (i species) bubble & wake phases       f(z)
    %       CiE = concentration (i species) emulsion phases            f(z)
    %      CTBW = a vector with all concentrations species - bubble & wake
    % reactorType = airReactor | fuelReactor
    %    Global = constants structure
    % caracter1 = phase identifier (Gas,Solid)
    % caracter2 = species identifier (CH4,CO2, ...)
    % ----------------------------| outlet |-------------------------------
    %       RH3 = right-hand side term-3   [mol/cm3-s] [gSolid/g-carrier-s] 
% -------------------------------------------------------------------------

    fw      = Global.(reactorType).fDynamics.fw;
    Emf     = Global.(reactorType).fDynamics.Emf; 
    Dcat    = Global.carrier.rho_s;

% -------------------------------------------------------------------------

    if    strcmp(caracter1,'FGas')

            temporal = (alpha + alpha*fw*Emf).*(CiBW - CiE);
            KBE      = KBEFcn(db, ub, CTBW, Tbe, reactorType, ...
                         Global, caracter2);
            RH3      = KBE.*temporal;

    elseif strcmp(caracter1,'FSolido')

            temporal = Dcat*alpha*fw*(1 - Emf).*(CiBW - CiE);
            KWE      = KWEFcn(db, reactorType, Global);
            RH3      = KWE.*temporal;

    else

            disp('Error - Ingresar un caracter correcto RH2Fcn.m')
            
    end

% -------------------------------------------------------------------------   
end