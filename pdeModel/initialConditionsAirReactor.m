function u = initialConditionsAirReactor(Global)
% -------------------------------------------------------------------------  
% initial conditions function
    % ----------------------------| into |---------------------------------
    %           n = mesh point number                                    []
    %     Num_esp = number of species                                    []
    % ----------------------------| out |----------------------------------
    %           u = initial conditions vector
% -------------------------------------------------------------------------  
    n1     = Global.n1;
    n2     = Global.n2;
    N2o    = Global.streamGas.composition.N2;
    O2o    = Global.streamGas.composition.O2;
    % NiOo   = Global.streamSolid.composition.NiO;
    NiOo   = 1e-10;
    Nio    = Global.streamSolid.composition.Ni;
    Al2O3o = Global.streamSolid.composition.Al2O3;
% ----------------------------| dense phase |------------------------------
% ---------- gas species - Bubble & Wake phases----------------------------
    g1b = zeros(n1,1);   g2b = zeros(n1,1); 
% ---------- gas species - Emulsion phase ---------------------------------
    g1e = zeros(n1,1);   g2e = zeros(n1,1);  
% ---------- solid specie - Wake phase ------------------------------------
    s1w = zeros(n1,1);   s2w = zeros(n1,1); s3w = zeros(n1,1);
% ---------- solid specie - Emulsion phase --------------------------------
    s1e = zeros(n1,1);   s2e = zeros(n1,1); s3e = zeros(n1,1);
% ----------------------------| freboard phase |---------------------------
% ---------- gas species - freboard phase ---------------------------------
% ---------- solid species - freboard phase -------------------------------
% -------------------------------------------------------------------------
% ----------------------------| dense phase |------------------------------
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
% ---------- u1 = CH4 freboard phase  -------------------------------------
% -------------------------------------------------------------------------

    u = [g1b; g2b; g1e; g2e; s1w; s2w; s3w; s1e; s2e; s3e];
   
end