function [KWE] = KWEFcn(db, reactorType, Global)
% -------------------------------------------------------------------------
    % KWEFcn - function allows to obtain the solid exchange coefficient 
    % between wake-emulsion [s-1]
    % ----------------------------| inlet |--------------------------------
    %        db = bubble diameter                                  f(z)[cm]
    % reactorType = airReactor | fuelReactor
    %    Global = constants structure
    %       umf = minimum fluidization velocity                      [cm/s]
    %      usg0 = initial superficial gas velocity                   [cm/s]
    %         n = mesh points number                                    [#]
    % ----------------------------| outlet |-------------------------------
    %       KWE = solid exchange coefficient between wake-emulsion    [s-1]  
% -------------------------------------------------------------------------

    umf    = Global.(reactorType).fDynamics.umf; 
    usg0   = Global.(reactorType).fDynamics.usg0; 
    n1     = Global.(reactorType).n1;

% -------------------------------------------------------------------------

    factor = usg0/umf;
    KWE    = zeros(n1,1);
    
% -------------------------------------------------------------------------     
    if     factor <= 3
        for j = 1:n1
            KWE(j) = 100*0.075*(usg0 - umf)/(umf*db(j));
            if db(j) == 0, KWE(j) = 0; end
        end                            
    elseif factor > 3
        for j = 1:n1
            KWE(j) = (100*0.15/db(j));
            if db(j) == 0, KWE(j) = 0; end
        end
    else
        disp('Error - Inconsistencia en KWEFcn.m')
    end
% -------------------------------------------------------------------------    
end