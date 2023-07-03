function ut = pdeFcn(t,u,Global)
% -------------------------------------------------------------------------
    % pdeFcn function define the EDOs for the numerical solution with 
    % the method of lines
    % ----------------------------| input |--------------------------------
    %       t = interval of integration, specified as a vector
    %       u = time-dependent terms, specified as a vector
    %  Global = constant values structure 
    % ----------------------------| output |-------------------------------
    %      ut =  time-dependent terms variation, specified as a vector
    % ---------------------------------------------------------------------
% --------------------| constants values |---------------------------------

    ncall = Global.iterations;
    Tbed_airReactor (1:Global.airReactor.n1, 1) = Global.airReactor.T;
    Tbed_fuelReactor(1:Global.fuelReactor.n1,1) = Global.fuelReactor.T;

% --------------------| Variables Initial Configuration |------------------
% ---------- non-negative values check ------------------------------------

    u(u < 0) = 0;

    n_AR = Global.airReactor .n1*Global.airReactor .Num_sp_dp;
    n_FR = Global.fuelReactor.n1*Global.fuelReactor.Num_sp_dp;


    u_AR = u(1:n_AR);
    u_FR = u(n_AR + 1:n_AR + n_FR);

% --------------------| Fluidized Bed |------------------------------------ 
% -------------------------------------------------------------------------
    
mb_airReactor  = denseMassBalanceFcn(u_AR, Tbed_airReactor,  ...
                                     'airReactor', Global);
mb_fuelReactor = denseMassBalanceFcn(u_FR, Tbed_fuelReactor, ...
                                     'fuelReactor', Global);

% --------------------| Temporal Variation Vector dudt |-------------------
    ut = [mb_airReactor.ut; mb_fuelReactor.ut];
% --------------------| Number Calls To pdeFcn |---------------------------
    disp([ncall.getNcall, t]);
    ncall.incrementNcall();
% --------------------| pdeFcn - End |-------------------------------------
end 