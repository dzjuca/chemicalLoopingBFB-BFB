function PPT = partialPressureFcn(C_gas)
    % -------------------------------------------------------------------------
        % partialPressureFcn - is a function that calculates the 
        % partial pressure
        % ----------------------------| input |--------------------------------
        %   C_gas = the concentration of the species in the reactor   [kmol/m3]
        % ----------------------------| output |-------------------------------
        %   PPT =  the partial pressure of the species in the reactor     [bar]
    % -------------------------------------------------------------------------
    
        C_CH4 = C_gas(1); 
        C_CO2 = C_gas(2); 
        C_CO  = C_gas(3); 
        C_H2  = C_gas(4); 
        C_H2O = C_gas(5); 
        C_N2  = C_gas(6);  

        C_gas_suma = sum(C_gas);
    
    % -------------------------------------------------------------------------
    
        if C_gas_suma == 0

                    PCH4 = 0.0; PCO2 = 0.0; PCO = 0.0;
                    PH2 = 0.0; PH2O = 0.0; PN2 = 0.0;                  
                    PPT = [PCH4,PCO2,PCO,PH2,PH2O,PN2];

        elseif isnan(C_gas)

                    PCH4 = C_CH4/C_gas_suma; 
                    PCO2 = C_CO2/C_gas_suma; 
                    PCO  = C_CO/ C_gas_suma;
                    PH2  = C_H2/ C_gas_suma;  
                    PH2O = C_H2O/C_gas_suma; 
                    PN2  = C_N2/ C_gas_suma;   

                    PPT = [PCH4,PCO2,PCO,PH2,PH2O,PN2];
                    disp('CT = NaN CineticaFcn.m')
        else
                    PCH4 = C_CH4/C_gas_suma; 
                    PCO2 = C_CO2/C_gas_suma; 
                    PCO  = C_CO/ C_gas_suma;
                    PH2  = C_H2/ C_gas_suma; 
                    PH2O = C_H2O/C_gas_suma; 
                    PN2  = C_N2/ C_gas_suma;  
                                     
                    PPT = [PCH4,PCO2,PCO,PH2,PH2O,PN2];
        end
    
    % -------------------------------------------------------------------------
    end