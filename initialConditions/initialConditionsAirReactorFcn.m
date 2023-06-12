function u0 = initialConditionsAirReactorFcn(Global)
% -------------------------------------------------------------------------  
% initialConditionsAirReactorFcn function
    % ----------------------------| into |---------------------------------
    %           n = mesh point number                                    []
    %     Num_esp = number of species                                    []
    % ----------------------------| out |----------------------------------
    %          u0 = air reactor initial conditions vector
% -------------------------------------------------------------------------  

    n1     = Global.airReactor.n1;
    n2     = Global.airReactor.n2;

    N2o    = Global.airReactor.streamGas.composition.N2;
    O2o    = Global.airReactor.streamGas.composition.O2;

    Nio    = Global.airReactor.streamSolid.composition.Ni;
    NiOo   = Global.airReactor.streamSolid.composition.NiO;
    Al2O3o = Global.airReactor.streamSolid.composition.Al2O3;

% ----------------------------| dense phase |------------------------------
% ---------- gas species - Bubble & Wake phases----------------------------
    g1b = zeros(n1,1);   g2b = zeros(n1,1); 
% ---------- gas species - Emulsion phase ---------------------------------
    g1e = zeros(n1,1);   g2e = zeros(n1,1);  
% ---------- solid specie - Wake phase ------------------------------------
    s1w = zeros(n1,1);   s2w = zeros(n1,1); s3w = zeros(n1,1);
% ---------- solid specie - Emulsion phase --------------------------------
    s1e = zeros(n1,1);   s2e = zeros(n1,1); s3e = zeros(n1,1);
% ---------- asing values -------------------------------------------------
% ---------- g1 = O2 bubble & emulsion  -----------------------------------
    g1b(:,1) = O2o;        g1e(:,1) = O2o;     
% ---------- g2 = N2 bubble & emulsion ------------------------------------
    g2b(:,1) = N2o;        g2e(:,1) = N2o;     
% ---------- s1 = Ni wake & emulsion --------------------------------------
    s1w(:,1) = Nio;        s1e(:,1) = Nio; 
% ---------- s2 = NiO wake & emulsion -------------------------------------
    s2w(:,1) = NiOo;       s2e(:,1) = NiOo;   
% ---------- s3 = Al2O3 wake & emulsion -----------------------------------
    s3w(:,1) = Al2O3o;     s3e(:,1) = Al2O3o;     
% ----------------------------| freboard phase |---------------------------
% ---------- gas species - freboard phase ---------------------------------
% ---------- solid species - freboard phase -------------------------------
% ---------- asing values -------------------------------------------------
% -------------------------------------------------------------------------

    u0 = [g1b; g2b; g1e; g2e; s1w; s2w; s3w; s1e; s2e; s3e];

% ------------------------------------------------------------------------- 
end