function [bubble, C_g_b] = bc_dp_gb_Fcn(u, Global)
% -------------------------------------------------------------------------
    id_g_b  = 'gas_bubble'; 
    [g1b, g2b ] = assignValuesFcn(u, Global, id_g_b);
% -------------------------------------------------------------------------
    g1b(1) = Global.streamGas.composition.O2; 
    g2b(1) = Global.streamGas.composition.N2; 

    bubble.g1b = g1b; 
    bubble.g2b = g2b; 
% -------------------------------------------------------------------------
    C_g_b = [g1b, g2b];
% -------------------------------------------------------------------------
end