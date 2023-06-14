function [emulsion, C_g_e] = bc_dp_ge_Fcn(u, reactorType, Global)
% -------------------------------------------------------------------------
    % bc_dp_ge_Fcn function 
    % ----------------------------| input |--------------------------------
    % ----------------------------| output |-------------------------------
% -------------------------------------------------------------------------

    id_g_e        = 'gas_emulsion';
    gasSpecies    = Global.(reactorType).gasSpecies;
    n1            = Global.(reactorType).n1;
    gen           = Global.(reactorType).gen;
    out           = cell(1, gen);
    [out{:}]      = assignValuesFcn(u, reactorType, Global, id_g_e);
    variable_name = cell(1, gen);
    C_g_e         = zeros(n1, gen);

% -------------------------------------------------------------------------

    for i = 1:gen

        out{i}(1,1) = ...
        Global.(reactorType).streamGas.composition.(gasSpecies{i}); 

        variable_name{i}            = sprintf('g%de', i);
        emulsion.(variable_name{i}) = out{i};
        C_g_e(:, i)                 = out{i};

    end

% -------------------------------------------------------------------------
end