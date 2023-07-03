function mb_dp = denseMassBalanceFcn(u, Tbed, reactorType, Global)
% -------------------------------------------------------------------------
% -------------------------------------------------------------------------
% --------------------| constants values |---------------------------------
    n1           = Global.(reactorType).n1;
    gen          = Global.(reactorType).gen;
    sen          = Global.(reactorType).sen;
    gasSpecies   = Global.(reactorType).gasSpecies;
    solidSpecies = Global.(reactorType).solidSpecies;
% ---------- bubble - ubFcn.m ---------------------------------------------
    ub    = Global.(reactorType).fDynamics.ub;
    db    = Global.(reactorType).fDynamics.db;
    us    = Global.(reactorType).fDynamics.us;
    ue    = Global.(reactorType).fDynamics.ue;
    alpha = Global.(reactorType).fDynamics.alpha;
% --------------------| Boundary Conditions Dense Phase |------------------
    [gas.bubble, C_g_b]   = bc_dp_gb_Fcn (u, reactorType, Global); 
    [gas.emulsion, C_g_e] = bc_dp_ge_Fcn (u, reactorType, Global); 
    [solid, C_s_w, C_s_e] = bc_dp_swe_Fcn(u, reactorType, Global); 
% -------------------------------------------------------------------------
    C_gs_dp.C_g_b = C_g_b; C_gs_dp.C_g_e = C_g_e;
    C_gs_dp.C_s_w = C_s_w; C_gs_dp.C_s_e = C_s_e;
% ---------- concentrations dense phase vector ----------------------------
    
    gb_fn   = fieldnames(gas.bubble);
    ge_fn   = fieldnames(gas.emulsion);
    sw_fn   = fieldnames(solid.wake);
    se_fn   = fieldnames(solid.emulsion);
    g_names = cell(1, gen);
    s_names = cell(1, sen);

    gbt = zeros(n1, gen);
    get = zeros(n1, gen);

    swt = zeros(n1, sen);
    set = zeros(n1, sen);
    
    for i = 1:gen
    
        g_b                = gas.bubble.(gb_fn{i});
        g_e                = gas.emulsion.(ge_fn{i});
        g_names{i}         = sprintf('g%d', i);
        gbe.(g_names{i})   = struct('g_b',g_b,'g_e',g_e);

    end
    
    for i = 1:sen
    
        s_w                = solid.wake.(sw_fn{i});
        s_e                = solid.emulsion.(se_fn{i});
        s_names{i}         = sprintf('s%d', i);
        swe.(s_names{i})   = struct('s_w',s_w,'s_e',s_e);
      
    end
% --------------------| Mass Balance - Gas - Bubble & Wake Phase | --------


    id_1 = 'FGBurbuja'; id_2 = 'FGas';

    for i = 1:gen

        gbt(:,i) = massBalanceFcn(gbe.(g_names{i}), C_gs_dp, Tbed,      ...
                                  alpha, ub, db, reactorType,           ...
                                  Global, id_1, id_2, gasSpecies{i});

    end

% --------------------| Mass Balance - Gas - Emulsion Phase |--------------

    id_1 = 'FGEmulsion'; 

    for i = 1:gen

        get(:,i) = massBalanceFcn(gbe.(g_names{i}), C_gs_dp, Tbed,      ...
                                  alpha, [ub,ue], db, reactorType,      ...
                                  Global, id_1, id_2, gasSpecies{i});

    end

% --------------------| Mass Balance - Solid - Wake Phase |----------------

    id_1 = 'FSEstela'; id_2 = 'FSolido';

    for i = 1: sen
        
        swt(:,i) = massBalanceFcn(swe.(s_names{i}), C_gs_dp, Tbed,      ...
                                   alpha, ub, db, reactorType,          ...
                                   Global, id_1, id_2, solidSpecies{i});

    end

% --------------------| Mass Balance - Solid - Emulsion Phase |------------

    id_1 = 'FSEmulsion'; 

    for i = 1:sen
        
        set(:,i) = massBalanceFcn(swe.(s_names{i}), C_gs_dp, Tbed,      ...
                                  alpha, [ub,us], db, reactorType,      ...
                                  Global, id_1, id_2, solidSpecies{i});

    end

% --------------------| Boundary Conditions 2 |----------------------------
% ---------- z = 0 - gas - bubble & wake | emulsion - phases --------------

    for i = 1: gen

        gbt(1, i) = 0;
        get(1, i) = 0;

    end

% ---------- z = 0 - z = Zg - solid - wake | emulsion phases --------------

    for i = 1:sen
    
        swt(1, i)  = set(1, i); 
        set(n1, i) = swt(n1, i); 
    
    end

% --------------------| Temporal Variation Vector dudt |-------------------

    mb_dp.ut      = [gbt(:); get(:); swt(:); set(:)];
    mb_dp.C_gs_dp = C_gs_dp;
    
% -------------------------------------------------------------------------
end

