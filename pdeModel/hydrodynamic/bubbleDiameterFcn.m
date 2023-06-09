function db = bubbleDiameterFcn(umf, reactorType, Global)
% -------------------------------------------------------------------------
    % bubbleDiameterFcn function 
    % ----------------------------| input |--------------------------------
    % ----------------------------| output |-------------------------------            
% -------------------------------------------------------------------------    

    
    Ac   = Global.(reactorType).Area_dp;
    Di   = Global.(reactorType).rID_dp; 
    usg0 = Global.(reactorType).fDynamics.usg0;
    z1   = Global.(reactorType).z_dp; 
    g    = Global.g;

    dbo = (3.77*(usg0 - umf)^2)/g;  
    dbm = 0.652*(Ac*(usg0-umf))^(0.4);
    db  = dbm-(dbm-dbo).*exp(-0.3.*z1./Di);

% -------------------------------------------------------------------------
end