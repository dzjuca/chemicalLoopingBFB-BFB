function mb_dp = denseMassBalanceFcn(u, Tbed, reactorType, Global)
% -------------------------------------------------------------------------
% -------------------------------------------------------------------------
% --------------------| constants values |---------------------------------
    index1 = Global.(reactorType).n1;  % =======> borrar
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
    
    gb_fn  = fieldnames(gas.bubble);
    ge_fn  = fieldnames(gas.emulsion);
    sw_fn  = fieldnames(solid.wake);
    se_fn  = fieldnames(solid.emulsion);
    g_name = cell(1, gen);
    s_name = cell(1, sen);
    
    gb = zeros(n1, gen);
    ge = zeros(n1, gen);
    sw = zeros(n1, sen);
    se = zeros(n1, sen);
    
    for i = 1:gen
    
        gb(:,i) = gas.bubble.(gb_fn{i});
        ge(:,i) = gas.emulsion.(ge_fn{i});
      
    end
    
    for i = 1:sen
    
        sw(:,i) = solid.wake.(sw_fn{i});
        se(:,i) = solid.emulsion.(se_fn{i});
      
    end
% --------------------| Mass Balance - Gas - Bubble & Wake Phase | --------

% continuar desde aqui % XXXXXXXXXXXX==========================================> desde aquí


    variable_name = sprintf('variable_%d', i);
    eval([variable_name ' = i^2']);

        % Nombre de la estructura
    structName = 'miEstructura';
    
    % Campo al que deseas acceder
    fieldName = 'ge';
    
    % Valor que deseas asignar
    value = 55;
    
    % Acceder y asignar el valor utilizando setfield()

    eval([ fieldName '= struct(''f'',[3 4],''g'',5);'])
    




    % Crear variables de forma dinámica
    for i = 1:gen

        g_name{i} = sprintf('g%d', i);
        eval([ g_name{i} '= struct(''f'',[3 4],''g'',5);']) % XXXXXXXXXXXX==========================================> desde aquí


    end

    for i = 1:sen

        s_name{i} = sprintf('s%d', i);

    end



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


% continuar desde aqui % XXXXXXXXXXXX==========================================> desde aquí







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