function X = conversionFcn(C_NiO, C_NiO_o)
% -------------------------------------------------------------------------

    if C_NiO > C_NiO_o, C_NiO = C_NiO_o; end

    X = (C_NiO_o - C_NiO)/C_NiO_o;

    if C_NiO_o == 0, X = 0; end

% -------------------------------------------------------------------------

end