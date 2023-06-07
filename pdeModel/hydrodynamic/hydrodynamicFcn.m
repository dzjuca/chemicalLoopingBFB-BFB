function Global = hydrodynamicFcn(Global)
% -------------------------------------------------------------------------
    % hydrodynamicFcn function 
    % ----------------------------| input |--------------------------------
    % ----------------------------| output |-------------------------------            
% -------------------------------------------------------------------------

    TYPE_PROCESS = Global.typeProcess;

    if     strcmp(TYPE_PROCESS, 'BFB-BFB')

        Global = getHydrodynamicFcn('BFB', 'airReactor',  Global);
        Global = getHydrodynamicFcn('BFB', 'fuelReactor', Global);
    
    elseif strcmp(TYPE_PROCESS, 'PC-BFB')

        Global = getHydrodynamicFcn('PC',  'airReactor',  Global);
        Global = getHydrodynamicFcn('BFB', 'fuelReactor', Global);

    elseif strcmp(TYPE_PROCESS, 'FF-BFB')

        Global = getHydrodynamicFcn('FF',  'airReactor',  Global);
        Global = getHydrodynamicFcn('BFB', 'fuelReactor', Global);

    else

        Global = getHydrodynamicFcn('BFB', 'airReactor',  Global);
        Global = getHydrodynamicFcn('BFB', 'fuelReactor', Global);

    end

end