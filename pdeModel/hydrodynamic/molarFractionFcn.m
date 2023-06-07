function molarFraction = molarFractionFcn(Cgas)
    % -------------------------------------------------------------------------
        % molarFraction function 
        % ----------------------------| input |--------------------------------
        %   Cgas = vector with concentration for each species         [mol/cm3]
        % ----------------------------| output |-------------------------------
        % molarFraction = vector with molar fraction for each species        []
    % -------------------------------------------------------------------------
    
        Cgas_sum      = sum(Cgas, 2);
        [m, n]        = size(Cgas);
        molarFraction = zeros(m,n);
    
        for i = 1:m
    
            if Cgas_sum(i) == 0
    
                molarFraction(i,:) = zeros(1,n);
        
            elseif isnan(Cgas_sum(i))
                        
                molarFraction(i,:) = Cgas(i,:)./Cgas_sum(i);
                disp('Cg = NaN molarFractionFcn.m')
    
            elseif isinf(Cgas_sum(i))
                        
                molarFraction(i,:) = Cgas(i,:)./Cgas_sum(i);
                disp('Cg = Inf molarFractionFcn.m')
            else
        
                molarFraction(i,:) = Cgas(i,:)./Cgas_sum(i);
                
            end
    
        end
    
    % -------------------------------------------------------------------------
    
    end