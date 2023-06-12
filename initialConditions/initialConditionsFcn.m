function u0 = initialConditionsFcn(Global)
% -------------------------------------------------------------------------
    % initialConditionsFcn function 
    % ----------------------------| input |--------------------------------
    % ----------------------------| output |-------------------------------            
% ------------------------------------------------------------------------- 

    u0_airReactor  = initialConditionsAirReactorFcn(Global);
    u0_fuelReactor = initialConditionsFuelReactorFcn(Global);

    u0 = [u0_airReactor; u0_fuelReactor];

% ------------------------------------------------------------------------- 
end