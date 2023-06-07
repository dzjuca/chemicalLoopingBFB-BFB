function Emf = EmfFcn(fluidizedType, Global)
% -------------------------------------------------------------------------
    % EmfFcn function 
    % ----------------------------| input |--------------------------------
    % ----------------------------| output |-------------------------------            
% -------------------------------------------------------------------------

% -------------------------------------------------------------------------
  if strcmp(fluidizedType, 'BFB')

    Emf = 0.45;

  elseif strcmp(fluidizedType, 'PC')

    phi = Global.carrier.sphericity;
    Emf = (1/(14*phi))^(1/3);

  elseif strcmp(fluidizedType, 'FF')

    phi = Global.carrier.sphericity;
    Emf = (1/(14*phi))^(1/3);

  end
    
% -------------------------------------------------------------------------
end