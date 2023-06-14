function [solid, C_s_w, C_s_e] = bc_dp_swe_Fcn(u, reactorType, Global)

% -------------------------------------------------------------------------
    % bc_dp_swe_Fcn function 
    % ----------------------------| input |--------------------------------
    % ----------------------------| output |-------------------------------
% -------------------------------------------------------------------------

% En este caso se debe introducir la condicion de contorno proveniente del
% otro reactor, esto se deberá hacer con una función similar al concepto de
% patrón singleton, toca de revisar para ver como se le hace dinámico    ===================>> revisar
    
    n1              = Global.(reactorType).n1;
    solidSpecies    = Global.(reactorType).solidSpecies;
    id_s_w          = 'solid_wake';    
    id_s_e          = 'solid_emulsion';
    sen             = Global.(reactorType).sen;
    out_w           = cell(1, sen);
    out_e           = cell(1, sen);
    [out_w{:}]      = assignValuesFcn(u, reactorType, Global, id_s_w);
    [out_e{:}]      = assignValuesFcn(u, reactorType, Global, id_s_e);
    variable_name_w = cell(1, sen);
    variable_name_e = cell(1, sen);
    C_s_w           = zeros(n1, sen);
    C_s_e           = zeros(n1, sen);

% -------------------------------------------------------------------------

    for i = 1:sen

        out_w{i}(1,1)                       = out_e{i}(1,1);
        out_e{i}(n1,1)                      = out_w{i}(n1,1);

        variable_name_w{i}                  = sprintf('s%dw', i);
        variable_name_e{i}                  = sprintf('s%de', i);

        solid.wake.(variable_name_w{i})     = out_w{i};
        solid.emulsion.(variable_name_e{i}) = out_e{i};

        C_s_w(:, i)                         = out_w{i};
        C_s_e(:, i)                         = out_e{i};

    end

% -------------------------------------------------------------------------
end