function [solid, C_s_w, C_s_e] = bc_dp_swe_Fcn(u, Global)
    
    index1 = Global.n1;
    id_s_w = 'solid_wake';    
    id_s_e = 'solid_emulsion';

% ---------- solid - wake phase -------------------------------------------
    [s1w, s2w, s3w] = assignValuesFcn(u, Global, id_s_w);
% ---------- solid - emulsion phase ---------------------------------------
    [s1e, s2e, s3e] = assignValuesFcn(u, Global, id_s_e);
% ---------- z = 0 solid - wake & emulsion phases -------------------------
    s1w(1) = s1e(1); 
    s2w(1) = s2e(1); 
    s3w(1) = s3e(1);
% ---------- z = Zg solid - wake & emulsion phases ------------------------
    s1e(index1) = s1w(index1); 
    s2e(index1) = s2w(index1);
    s3e(index1) = s3w(index1);

    wake.s1w = s1w; 
    wake.s2w = s2w; 
    wake.s3w = s3w;

    emulsion.s1e = s1e; 
    emulsion.s2e = s2e; 
    emulsion.s3e = s3e;

    solid.wake     = wake; 
    solid.emulsion = emulsion;

    C_s_w = [s1w, s2w, s3w];
    C_s_e = [s1e, s2e, s3e];
% -------------------------------------------------------------------------
end