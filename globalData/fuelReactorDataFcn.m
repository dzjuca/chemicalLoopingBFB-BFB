function Global = fuelReactorDataFcn(Global)
% -------------------------------------------------------------------------
    % fuelReactorDataFcn function 
    % ----------------------------| input |--------------------------------

    % ----------------------------| output |-------------------------------
    %                    
% -------------------------------------------------------------------------
% ----------| Reactor 2 Fuel Reactor |-------------------------------------
    Global.fuelReactor.gen        = 2; % gas species number           [#]
    Global.fuelReactor.sen        = 3; % solid species number         [#]
    Global.fuelReactor.Num_sp_dp  = 10;% number of species            [#] 
    Global.fuelReactor.Num_sp_lp  = 0; % number of species            [#]
    Global.fuelReactor.n1         = 40;% mesh points number           [#] 
    Global.fuelReactor.n2         = 0; % mesh points number           [#]
    Global.fuelReactor.nt = Global.airReactor.n1 + Global.airReactor.n2; 

end