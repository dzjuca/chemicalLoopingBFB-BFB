% -------------------------------------------------------------------------
%                Chemical Looping Process Model
%     Author: Daniel Z. Juca
% ------------------------ | initiation | ---------------------------------
    close all
    clear
    clear Iterations
    clc
    format shortG
% ---------- global constants ---------------------------------------------
    Global = globalDataFcn();
% --------------------------------------------------------------------------
    Global = hydrodynamicFcn(Global);
% --------------------------------------------------------------------------
    NoN  = (1:(Global.n1*Global.Num_esp_1 + Global.n2*Global.Num_esp_2));
% ---------- initial condition --------------------------------------------
    u0   = initialConditions(Global);
% ---------- time simulation (s) ------------------------------------------
    t0   = 0.0; 
    tf   = 1*3600;
    tout = linspace(t0,tf,100)';
% ---------- Implicit (sparse stiff) integration --------------------------
    reltol   = 1.0e-6; abstol = 1.0e-6;  
    options  = odeset('RelTol',reltol,'AbsTol',abstol,'NonNegative',NoN);
    S        = JPatternFcn(Global);
    options  = odeset(options,'JPattern',S); 
    pdeModel = @(t,u)pdeFcn(t,u,Global);
    [t,u]    = ode15s(pdeModel,tout,u0,options);  
% ---------------------------| End Program |-------------------------------