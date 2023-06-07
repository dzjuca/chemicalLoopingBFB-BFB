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
        
        % te quedas aqui
        ut    = terminalVelocityFcn(Cgas, T, Global);
        db    = bubbleDiameterFcn(umf, Global);
        ub    = bubbleVelocityFcn(umf, db, Global);
        alpha = alphaFcn(ub, umf, Global);
        us    = solidBedVelocityFcn(ub, alpha, Global);
        ue    = emulsionBedVelocityFcn(us, umf, Emf, Global);
    
    elseif strcmp(fluidizedType, 'PC')

    elseif strcmp(fluidizedType, 'FF')

    end


% -------------------------------------------------------------------------
    Global.fDynamics.Emf   = Emf;
    Global.fDynamics.umf   = umf;
    Global.fDynamics.ut    = ut;
    Global.fDynamics.db    = db;
    Global.fDynamics.ub    = ub;
    Global.fDynamics.alpha = alpha;
    Global.fDynamics.us    = us;
    Global.fDynamics.ue    = ue;
% -------------------------------------------------------------------------

% -------------------------------------------------------------------------
% -------------------------------------------------------------------------
end