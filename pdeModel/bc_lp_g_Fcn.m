function [gas, C_g] = bc_lp_g_Fcn(u, C_gs_dp, Global)

    id_g_f  = 'gas_freeboard'; 
% -------------------------------------------------------------------------

    Emf = Global.fDynamics.Emf;
    fw  = Global.fDynamics.fw;
    A   = Global.reactor.rArea1; 
    n1  = Global.n1;

% -------------------------------------------------------------------------

    [ub,db,us,ue,alpha]= ubFcn(Global);

    C_gb_dp_i = C_gs_dp.C_g_b;
    C_ge_dp_i = C_gs_dp.C_g_e;

    F_gb_dp_i = C_gb_dp_i.*ub.*A.*(alpha + alpha.*fw.*Emf);
    F_ge_dp_i = C_ge_dp_i.*ue.*A.*(1 - alpha - alpha.*fw).*Emf;
    F_g_dp_i  = F_gb_dp_i + F_ge_dp_i;
    Q_g_dp_i  = sum(F_g_dp_i,2).*22.4.*1000;
    C_g_dp_i  = F_g_dp_i./Q_g_dp_i;

% ---------- gas freeboard phase ------------------------------------------

    [f1g, f2g, f3g, f4g, f5g, f6g] = assignValuesFcn(u, Global, id_g_f);

% -------------------------------------------------------------------------
    f1g(1) = C_g_dp_i(n1,1);
    f2g(1) = C_g_dp_i(n1,2);
    f3g(1) = C_g_dp_i(n1,3);
    f4g(1) = C_g_dp_i(n1,4);
    f5g(1) = C_g_dp_i(n1,5);
    f6g(1) = C_g_dp_i(n1,6);

    gas.f1g = f1g; 
    gas.f2g = f2g; 
    gas.f3g = f3g; 
    gas.f4g = f4g; 
    gas.f5g = f5g; 
    gas.f6g = f6g;

    C_g = [f1g, f2g, f3g, f4g, f5g, f6g];
    
% -------------------------------------------------------------------------
end