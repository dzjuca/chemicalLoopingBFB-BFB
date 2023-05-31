function mb_dp = leanMassBalanceFcn(u, C_gs_dp, Tbed, Global)    
% -------------------------------------------------------------------------        
% --------------------| Boundary Conditions Lean Phase |-------------------
    [gas, C_g]   = bc_lp_g_Fcn(u, C_gs_dp, Global);
    [solid, C_s] = bc_lp_s_Fcn(u, C_gs_dp, Global);
% ---------- concentrations Lean phase vector -----------------------------
    C_gs_lp.C_g = C_g;
    C_gs_lp.C_s = C_s;
% --------------------| Mass Balance - Gas   - Freeboard Phase |-----------
    f1g = gas.f1g; f2g = gas.f2g; f3g = gas.f3g; 
    f4g = gas.f4g; f5g = gas.f5g; f6g = gas.f6g; 
% --------------------| Mass Balance - Solid - Freeboard Phase |-----------
    f1s = solid.f1s; f2s = solid.f2s; f3s = solid.f3s;
% --------------------| Mass Balance - Gas   - Freeboard Phase |-----------
    f1gt = (- lr_mbrhs1Fcn(f1g, C_gs_lp, Tbed, Global, 'g_lp')        ... 
            + lr_mbrhs2Fcn(f1g, Global)                                 ...
            + lr_mbrhs3Fcn(C_gs_lp, Tbed, Global, 'g_lp', 'CH4_lp'));

    f2gt = (- lr_mbrhs1Fcn(f2g, C_gs_lp, Tbed, Global, 'g_lp')        ...
            + lr_mbrhs2Fcn(f1g, Global)                                 ...
            + lr_mbrhs3Fcn(C_gs_lp, Tbed, Global, 'g_lp', 'CO2_lp'));   

    f3gt = (- lr_mbrhs1Fcn(f3g, C_gs_lp, Tbed, Global, 'g_lp')        ...
            + lr_mbrhs2Fcn(f1g, Global)                                 ...
            + lr_mbrhs3Fcn(C_gs_lp, Tbed, Global, 'g_lp', 'CO_lp'));

    f4gt = (- lr_mbrhs1Fcn(f4g, C_gs_lp, Tbed, Global, 'g_lp')        ...
            + lr_mbrhs2Fcn(f1g, Global)                                 ...
            + lr_mbrhs3Fcn(C_gs_lp, Tbed, Global, 'g_lp', 'H2_lp'));

    f5gt = (- lr_mbrhs1Fcn(f5g, C_gs_lp, Tbed, Global, 'g_lp')        ...
            + lr_mbrhs2Fcn(f1g, Global)                                 ...
            + lr_mbrhs3Fcn(C_gs_lp, Tbed, Global, 'g_lp', 'H2O_lp'));

    f6gt = (- lr_mbrhs1Fcn(f6g, C_gs_lp, Tbed, Global, 'g_lp')        ...
            + lr_mbrhs2Fcn(f1g, Global)                                 ...
            + lr_mbrhs3Fcn(C_gs_lp, Tbed, Global, 'g_lp', 'N2_lp'));
% --------------------| Mass Balance - Solid - Freeboard Phase |-----------
    f1st = (- lr_mbrhs1Fcn(f1s, C_gs_lp, Tbed, Global, 's_lp')        ... 
            + lr_mbrhs3Fcn(C_gs_lp, Tbed, Global, 's_lp', 'NiO_lp'));

    f2st = (- lr_mbrhs1Fcn(f2s, C_gs_lp, Tbed, Global, 's_lp')        ...
            + lr_mbrhs3Fcn(C_gs_lp, Tbed, Global, 's_lp', 'Ni_lp'));

    f3st = (- lr_mbrhs1Fcn(f3s, C_gs_lp, Tbed, Global, 's_lp')        ...
            + lr_mbrhs3Fcn(C_gs_lp, Tbed, Global, 's_lp', 'C_lp'));
% -------------------------------------------------------------------------

    mb_dp.ut = [f1gt; f2gt; f3gt; f4gt; f5gt; f6gt; f1st; f2st; f3st];
    mb_dp.C_gs_lp = C_gs_lp;
    
% -------------------------------------------------------------------------
end