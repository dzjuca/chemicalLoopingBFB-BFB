function mb_dp = denseMassBalanceFcn(u, Tbed, Global)
% -------------------------------------------------------------------------
% -------------------------------------------------------------------------
% --------------------| constants values |---------------------------------
    index1  = Global.n1;
% ---------- bubble - ubFcn.m ---------------------------------------------
    ub    = Global.fDynamics.ub;
    db    = Global.fDynamics.db;
    us    = Global.fDynamics.us;
    ue    = Global.fDynamics.ue;
    alpha = Global.fDynamics.alpha;
% --------------------| Boundary Conditions Dense Phase |------------------
    [gas.bubble, C_g_b]   = bc_dp_gb_Fcn (u, Global); 
    [gas.emulsion, C_g_e] = bc_dp_ge_Fcn (u, Global); 
    [solid, C_s_w, C_s_e] = bc_dp_swe_Fcn(u, Global); 
% ---------- concentrations dense phase vector ----------------------------
    g1b = gas.bubble.g1b;   
    g2b = gas.bubble.g2b;   

    g1e = gas.emulsion.g1e; 
    g2e = gas.emulsion.g2e; 

    s1w = solid.wake.s1w;   
    s2w = solid.wake.s2w;   
    s3w = solid.wake.s3w;

    s1e = solid.emulsion.s1e; 
    s2e = solid.emulsion.s2e; 
    s3e = solid.emulsion.s3e;

% -------------------------------------------------------------------------
    C_gs_dp.C_g_b = C_g_b; C_gs_dp.C_g_e = C_g_e;
    C_gs_dp.C_s_w = C_s_w; C_gs_dp.C_s_e = C_s_e;
% --------------------| Mass Balance - Gas - Bubble & Wake Phase | --------
    g1.g_b = g1b; 
    g1.g_e = g1e;
    g2.g_b = g2b; 
    g2.g_e = g2e;

    s1.s_w = s1w;
    s1.s_e = s1e;
    s2.s_w = s2w;
    s2.s_e = s2e;
    s3.s_w = s3w;
    s3.s_e = s3e;

    id_1 = 'FGBurbuja'; id_2 = 'FGas';
    g1bt = massBalanceFcn(g1, C_gs_dp, Tbed, alpha, ub, db, ... 
                          Global, id_1, id_2, 'O2');
    g2bt = massBalanceFcn(g2, C_gs_dp, Tbed, alpha, ub, db, ...
                          Global, id_1, id_2, 'N2');
% --------------------| Mass Balance - Gas - Emulsion Phase |--------------
    id_1 = 'FGEmulsion'; 
    g1et = massBalanceFcn(g1, C_gs_dp, Tbed, alpha, [ub,ue], db, ... 
                          Global, id_1, id_2, 'O2');
    g2et = massBalanceFcn(g2, C_gs_dp, Tbed, alpha, [ub,ue], db, ... 
                          Global, id_1, id_2, 'N2');
% --------------------| Mass Balance - Solid - Wake Phase |----------------
    id_1 = 'FSEstela'; id_2 = 'FSolido';
    s1wt = massBalanceFcn(s1, C_gs_dp, Tbed, alpha, ub, db, ...
                          Global, id_1, id_2, 'Ni');
    s2wt = massBalanceFcn(s2, C_gs_dp, Tbed, alpha, ub, db, ... 
                          Global, id_1, id_2, 'NiO');
    s3wt = massBalanceFcn(s3, C_gs_dp, Tbed, alpha, ub, db, ... 
                          Global, id_1, id_2, 'Al2O3');
% --------------------| Mass Balance - Solid - Emulsion Phase |------------
    id_1 = 'FSEmulsion'; 
    s1et = massBalanceFcn(s1, C_gs_dp, Tbed, alpha, [ub,us], db, ...
                          Global, id_1, id_2, 'Ni');
    s2et = massBalanceFcn(s2, C_gs_dp, Tbed, alpha, [ub,us], db, ...
                          Global, id_1, id_2, 'NiO');
    s3et = massBalanceFcn(s3, C_gs_dp, Tbed, alpha, [ub,us], db, ...
                          Global, id_1, id_2, 'Al2O3');

% --------------------| Boundary Conditions 2 |----------------------------
% ---------- z = 0 gas - bubble & wake phase ------------------------------
    g1bt(1) = 0; g2bt(1) = 0; 
% ---------- z = 0 gas - emulsion phase -----------------------------------
    g1et(1) = 0; g2et(1) = 0; 
% ---------- z = 0 solid - wake & emulsion phases -------------------------
    s1wt(1) = s1et(1); 
    s2wt(1) = s2et(1); 
    s3wt(1) = s3et(1);
% ---------- z = Zg solid - wake & emulsion phase -------------------------
    s1et(index1) = s1wt(index1); 
    s2et(index1) = s2wt(index1);
    s3et(index1) = s3wt(index1);
% --------------------| Temporal Variation Vector dudt |-------------------
    mb_dp.ut = [g1bt; g2bt; g1et; g2et; ...
                s1wt; s2wt; s3wt; s1et; s2et; s3et];
    mb_dp.C_gs_dp = C_gs_dp;
% -------------------------------------------------------------------------
end