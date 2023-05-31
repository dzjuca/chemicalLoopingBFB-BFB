function S = JPatternFcn(Global)
% -------------------------------------------------------------------------
  % Sparsity pattern of the Jacobian matrix based on a numerical evaluation
  % Note: the reference to the ODE routine (two places below) should be 
  % edited to specify the current ODE routine.
  %
  % Set independent, dependent variables for the calculation 
  % of the sparsity pattern
% -------------------------------------------------------------------------

  Num_esp_1 = Global.Num_esp_1;
  Num_esp_2 = Global.Num_esp_2;
  index1  = Global.n1;
  index2  = Global.n2;
  tbase   = 0;

  for i = 1:(index1*Num_esp_1 + index2*Num_esp_2)
    ybase(i) = 0.5;
  end
  ybase = ybase';
%


pdeModel = @(t,u)pdeFcn(t,u,Global);



% Compute the corresponding derivative vector
      ytbase = pdeModel(tbase,ybase);
         fac = []; 
      thresh = 1e-16;
  vectorized = 'on';
   [Jac,fac] = numjac(pdeModel,tbase,ybase,ytbase,thresh,fac,vectorized);
%
% Replace nonzero elements by "1" (so as to create a "0-1" map of the 
% Jacobian matrix) 
           S = spones(sparse(Jac));
% Compute the percentage of non-zero elements
  [njac,mjac] = size(S);
      ntotjac = njac*mjac;
     non_zero = nnz(S);
  non_zero_percent = non_zero/ntotjac*100;
%% --- PENDIENTE REVISAR ESTA PARTE - PROBLEMAS CON TITULO Y LATEX ---------
    ss = 'Patron\;de\;dispersion\;Jacobiana\;';
  stat = sprintf('%sno-ceros%d(%.3f%s)',...
                 ss,non_zero,non_zero_percent,'\%');         
  Tit1 = strcat('$',stat,'$');
% -------------------------------------------------------------------------
% ---------- Plot the map -------------------------------------------------
% Map of the Num_esp - ODE system
   fig1 = figure;
          hold on
          set(fig1,'Units','centimeters',       ...
                   'PaperPosition',[0 0 15 15], ...
                   'PaperSize', [15,15]);
% -------------------------------------------------------------------------
   spy(S);
   xlabel('$variables\;dependientes$',          ...
         'FontSize',16,'interpreter','Latex');
   ylabel('$ecuaciones\;semi-discretas$',       ...
         'FontSize',16,'interpreter','Latex');
%     title(Tit1,'interpreter','Latex','FontSize',8);
%    title(stat,'interpreter','Latex',);
  set(gca,'FontSize',14,'XGrid','on','YGrid','on',...
          'Box','on','TickLabelInterpreter','latex')  
  hold off
  print(fig1,'-dpdf','-r500','MATRIZ_EJ')
  close all
% -------------------------------------------------------------------------
  end