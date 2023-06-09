function alpha = alphaFcn(ub, umf, reactorType, Global)
% -------------------------------------------------------------------------
    % alphaFcn function 
    % ----------------------------| input |--------------------------------
    % ----------------------------| output |-------------------------------            
% ------------------------------------------------------------------------- 

    usg0 = Global.(reactorType).fDynamics.usg0;
    fw   = Global.(reactorType).fDynamics.fw;
    
% -------------------------------------------------------------------------

    alpha = (usg0 - umf)./(ub - umf - umf.*fw);

% -------------------------------------------------------------------------
end