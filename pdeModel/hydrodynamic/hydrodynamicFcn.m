function Global = hydrodynamicFcn(Global)
% --------------------------------------------------------------------------
    T     = Global.Tbed;
    Cgas  = [Global.streamGas.composition.N2, ... 
            Global.streamGas.composition.O2]; 
% --------------------------------------------------------------------------
    Emf   = EmfFcn(Global);
    umf   = umfFcn(Cgas, T, Global);
    ut    = terminalVelocityFcn(Cgas, T, Global);
    db    = bubbleDiameterFcn(umf, Global);
    ub    = bubbleVelocityFcn(umf, db, Global);
    alpha = alphaFcn(ub, umf, Global);
    us    = solidBedVelocityFcn(ub, alpha, Global);
    ue    = emulsionBedVelocityFcn(us, umf, Emf, Global);
% --------------------------------------------------------------------------
    Global.fDynamics.Emf   = Emf;
    Global.fDynamics.umf   = umf;
    Global.fDynamics.ut    = ut;
    Global.fDynamics.db    = db;
    Global.fDynamics.ub    = ub;
    Global.fDynamics.alpha = alpha;
    Global.fDynamics.us    = us;
    Global.fDynamics.ue    = ue;
% --------------------------------------------------------------------------
end