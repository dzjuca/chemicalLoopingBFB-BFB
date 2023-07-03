function RH2 = mbrhs2Fcn(alpha, ub, CiBW, CiE, reactorType, Global, ...
                         caracter)
% -------------------------------------------------------------------------
    % mbrhs2Fcn - function allows to obtain the second term (Right Hand 
    % Side)of the mass balance model
    % ----------------------------| inlet |--------------------------------
    %    alpha    = fraction of bubbles in bed                         f(z)
    %       ub    = bubbles velocity                                   f(z)
    %     CiBW    = gas concentration - Burbuja & Estela  phases       f(z)
    %      CiE    = gas concentration - Emulsion phase                 f(z)
    % reactorType = airReactor | fuelReactor
    %   Global    = constants structure
    % caracter    = phase identifier (Gas,Solid)
    % ----------------------------| outlet |-------------------------------
    % RH2 = right-hand side term-2       [  mol/cm3-s] [gSolid/g-carrier-s] 
% -------------------------------------------------------------------------
    fw      = Global.(reactorType).fDynamics.fw;
    Emf     = Global.(reactorType).fDynamics.Emf; 
    Dcat    = Global.carrier.rho_s;
    z_dp    = Global.(reactorType).z_dp;
    n1      = Global.(reactorType).n1;
    xl      = z_dp(1);
    xu      = z_dp(end);
    lambda1 = zeros(n1,1);
    lambda2 = zeros(n1,1);
% -------------------------------------------------------------------------   
    if     strcmp(caracter,'FGas')
        temporal1 = (alpha+alpha*fw*Emf).*ub;
             temporal2 = dss012(xl,xu,n1,temporal1, 1);
            %temporal2 = dss020(xl,xu,n,temporal1, 1)';
            %temporal2 = dss004(xl,xu,n,temporal1)';
        for i = 1:n1
            if      temporal2(i) < 0
                        lambda1(i) = 1;          
                        lambda2(i) = 0;
            elseif temporal2(i) >= 0
                        lambda1(i) = 0;
                        lambda2(i) = 1;
            else
                    disp('Error - Inconsistency in mbrhs2Fcn.m FGas')
            end
        end
        RH2 = (lambda1.*CiBW + lambda2.*CiE).*temporal2;
% -------------------------------------------------------------------------
    elseif strcmp(caracter,'FSolido')
        temporal1 = (1-Emf)*alpha*fw.*ub*Dcat;
            % temporal2 = dss012(xl,xu,n,temporal1, 1);
              temporal2 = dss020(xl,xu,n1,temporal1, 1)';
            % temporal2 = dss004(xl,xu,n,temporal1)';
        for i = 1:n1
            if      temporal2(i) < 0
                        lambda1(i) = 1;
                        lambda2(i) = 0;
            elseif temporal2(i) >= 0
                        lambda1(i) = 0;
                        lambda2(i) = 1;
            else
                    disp('Error - Inconsistency in mbrhs2Fcn.m FGas')
            end
        end
        RH2 = (lambda1.*CiBW + lambda2.*CiE).*temporal2;
% -------------------------------------------------------------------------
    else
        disp('Error - Inconsistency in mbrhs2Fcn.m')
    end
% -------------------------------------------------------------------------
end