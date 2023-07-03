function KBE = KBEFcn( db, ub ,CTBW ,Tbed, reactorType, Global ,caracter2 ) 
% -------------------------------------------------------------------------
    % KBEFcn - function allows to obtain the gas exchange coefficient 
    % between bubble-emulsion [s-1]
    % ----------------------------| inlet |--------------------------------
    %        db = bubble diameter                                  f(z)[cm]
    %        ub = bubbles velocity                              f(z) [cm/s]
    %      CTBW = a vector with all concentrations species - bubble & wake
    % reactorType = airReactor | fuelReactor
    %    Global = constants structure
    % caracter2 = species identifier (CH4,CO2, ...)
    %        zg = height for each mesh point                       f(z)[cm]
    %     SIGMA = Potentials for each compound - LENNARD-JONES          [A]
    %        EK =                                                       [K]
    %         T = Temperatura                                           [K]
    %         P = Pressure                                            [bar]
    %     MMASS = molar mass vector                                 [g/mol]
    %         g = standard acceleration of gravity                  [cm/s2]
    %       umf = minimum fluidization velocity                      [cm/s]
    %       Emf = minimum fluidization porosity                         [ ]
    % ----------------------------| outlet |-------------------------------
    %       KBE = gas exchange coefficient between bubble-emulsion    [s-1]
% -------------------------------------------------------------------------


    umf    = Global.(reactorType).fDynamics.umf; 
    Emf    = Global.(reactorType).fDynamics.Emf; 
    flds   = Global.(reactorType).gasSpecies;
    SIGMA  = Global.MassBalance.SIGMA;
    MASS   = Global.MassBalance.mmass;
    EK     = Global.MassBalance.EK;
    P      = Global.P;
    g      = Global.g;

% continuar desde aqui % XXXXXXXXXXXX==========================================> desde aquí
% -------------------------------------------------------------------------

    index1 = Global.(reactorType).gen;     %            number of compounds
    index2 = Global.(reactorType).n1;      %   number of points in the mesh
    kbc    = zeros(index2,1);
    kce    = zeros(index2,1);
    KBE    = zeros(index2,1);

% -------------------------------------------------------------------------
    for k = 1:index2
        CTij   = CTBW(k,1:index1);
        for nn = 1:index1
            if CTij(nn) < 0, CTij(nn) = 0; end
        end
        CT = sum(CTij); 
        T  = Tbed(k,1);
        if CT == 0
            kbc(k) = 0;
            kce(k) = 0;
        elseif isnan(CT)
            kbc(k) = 0; 
            kce(k) = 0;
            disp('KBE (NaN) en RH3Fcn.m')    
        elseif CT > 0
% ---------- constants values - Neufield, et al. (1972) -------------------
            A = 1.06036; B = 0.15610; 
            C = 0.19300; D = 0.47635; 
            E = 1.03587; F = 1.52996; 
            G = 1.76474; H = 3.89411;
% ---------- diffusion coefficient calculate [cm2/s] ----------------------
            Eij     = [];
            SIGMAij = [];
            MASSij  = [];
            Xij     = [];
            for i = 1:index1
                for j = 1:index1
                    if i~=j
                    Eij_temp = (EK.(flds{i})*EK.(flds{j}))^(0.5);          %EK.(flds{1})
                        Eij = [Eij;Eij_temp];
                SIGMAij_temp = ((SIGMA.(flds{i})+SIGMA.(flds{j}))/2);
                    SIGMAij = [SIGMAij;SIGMAij_temp];
                MASSij_temp = 2*((1/MASS.(flds{i}))+(1/MASS.(flds{j})))^(-1);
                        MASSij = [MASSij;MASSij_temp];
                    Xij_temp = CTij(j)/CT;
                        Xij = [Xij;Xij_temp];
                    end
                end
            end
            Eij     = reshape(Eij,index1-1,index1);
            SIGMAij = reshape(SIGMAij,index1-1,index1);
            MASSij  = reshape(MASSij,index1-1,index1);
            Xij     = reshape(Xij,index1-1,index1);
            TAST    = T./Eij;
            OMEGA   = (A./((TAST).^(B)))+(C./exp(D*TAST))+(E./exp(F*TAST))+...
                    (G./exp(H*TAST));
            Dij     = (0.00266*(T)^(3/2))./(P*MASSij.^(1/2).*SIGMAij.^2.*OMEGA);
            [id1,id2] = size(Xij);
            Yij       = zeros(id1,id2);
            for l = 1:id2
                for m = 1:id1
                %       Yij(m,l) = (Xij(m,l))/(sum(Xij(:,l)));
                tem_sum = sum(Xij(:,l));
                    if tem_sum == 0
                        Yij(m,l) = 0;
                    else
                        Yij(m,l) = (Xij(m,l))/tem_sum;
                    end
                end
            end       
                suma = (sum(Yij./Dij, 1));
                Dif_ij = zeros(1,index1);
            for  nn = 1:index1
                if suma(nn) == 0
                    Dif_ij(nn) = 0;
                else
                    Dif_ij(nn) = (suma(nn))^-1;
                end
            end
% ---------- gas exchange coefficient between bubble-emulsion claculate ---

% XXXXXXXXXXXX==========================================> pendiente comprobar que funciones con todos los compuestos

            try
                M   = containers.Map(flds,Dif_ij);
                Dif = M(caracter2);
            
            catch exception

                disp('Error in KBEFcn:The compound (caracter2) not exist');
                disp(exception.message);

            end

            kbc(k) = 4.5*(umf/db(k))+5.85*((Dif^(0.5)*g^(0.25))/(db(k)^(5/4)));
            kce(k) = 6.78*(Emf*Dif*ub(k)/db(k)^(3))^(1/2);
            factor = (1/kbc(k))+(1/kce(k));
            KBE(k) = (factor)^-1;
        else
            disp('Error KBE en RH3Fcn.m')
        end 
    end 
% -------------------------------------------------------------------------
end 
    
    