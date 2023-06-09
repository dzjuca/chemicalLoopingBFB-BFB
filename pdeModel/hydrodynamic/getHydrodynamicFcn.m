function Global = getHydrodynamicFcn(fluidizedType, reactorType, Global)
% -------------------------------------------------------------------------
    % getHydrodynamicFcn function 
    % ----------------------------| input |--------------------------------
    % ----------------------------| output |-------------------------------            
% -------------------------------------------------------------------------
% -------------------------------------------------------------------------
    if strcmp(fluidizedType, 'BFB')

% -------------------------------------------------------------------------
        T          = Global.(reactorType).T;
        gasSpecies = Global.(reactorType).gasSpecies;
            [~, n] = size(gasSpecies);
            Cgas   = zeros(1, n);

            for i = 1:n

            Cgas(1, i) =  ...
            Global.(reactorType).streamGas.composition.(gasSpecies{i});

            end
% -------------------------------------------------------------------------
        Emf   = EmfFcn(fluidizedType, Global);
        umf   = umfFcn(Cgas, T, gasSpecies, fluidizedType, Global);
        ut    = terminalVelocityFcn(Cgas, T, gasSpecies, Global);
        db    = bubbleDiameterFcn(umf, reactorType, Global);
        ub    = bubbleVelocityFcn(umf, db, reactorType, Global);
        alpha = alphaFcn(ub, umf, reactorType, Global);
        us    = solidBedVelocityFcn(ub, alpha, reactorType, Global);
        ue    = emulsionBedVelocityFcn(us, umf, Emf);
    
    elseif strcmp(fluidizedType, 'PC')

    elseif strcmp(fluidizedType, 'FF')

    end
% -------------------------------------------------------------------------
    Global.(reactorType).fDynamics.Emf   = Emf;
    Global.(reactorType).fDynamics.umf   = umf;
    Global.(reactorType).fDynamics.ut    = ut;
    Global.(reactorType).fDynamics.db    = db;
    Global.(reactorType).fDynamics.ub    = ub;
    Global.(reactorType).fDynamics.alpha = alpha;
    Global.(reactorType).fDynamics.us    = us;
    Global.(reactorType).fDynamics.ue    = ue;
% -------------------------------------------------------------------------
end