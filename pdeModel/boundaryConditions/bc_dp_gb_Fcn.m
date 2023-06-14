function [bubble, C_g_b] = bc_dp_gb_Fcn(u, reactorType, Global)
% -------------------------------------------------------------------------
    % bc_dp_gb_Fcn function 
    % ----------------------------| input |--------------------------------
    % ----------------------------| output |-------------------------------
% -------------------------------------------------------------------------

    id_g_b        = 'gas_bubble'; 
    gasSpecies    = Global.(reactorType).gasSpecies;
    n1            = Global.(reactorType).n1;
    gen           = Global.(reactorType).gen;
    out           = cell(1, gen);
    [out{:}]      = assignValuesFcn(u, reactorType, Global, id_g_b);
    variable_name = cell(1, gen);
    C_g_b         = zeros(n1, gen);

% -------------------------------------------------------------------------

    for i = 1:gen

        out{i}(1,1) = ...
        Global.(reactorType).streamGas.composition.(gasSpecies{i}); 

        variable_name{i}          = sprintf('g%db', i);
        bubble.(variable_name{i}) = out{i};
        C_g_b(:, i)               = out{i};

    end

% -------------------------------------------------------------------------
end