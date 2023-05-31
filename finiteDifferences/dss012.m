%DECK DSS012
      function [ux]=dss012(xl,xu,n,u,v)
%...
%...  FUNCTION DSS012 IS AN APPLICATION OF FIRST-ORDER DIRECTIONAL
%...  DIFFERENCING IN THE NUMERICAL METHOD OF LINES.  IT IS INTENDED
%...  SPECIFICALLY FOR THE ANALYSIS OF CONVECTIVE SYSTEMS MODELLED BY
%...  FIRST-ORDER HYPERBOLIC PARTIAL DIFFERENTIAL EQUATIONS WITH THE
%...  SIMPLEST FORM
%...
%...                            U  + V*U  = 0                        (1)
%...                             T      X
%...
%...  THE FIRST FIVE PARAMETERS, XL, XU, N, U AND UX, ARE THE SAME
%...  AS FOR FUNCTIONS DSS002 TO DSS010 AS DEFINED IN THOSE ROUTINES.
%...  THE SIXTH PARAMETER, V, MUST BE PROVIDED TO DSS012 SO THAT THE
%...  DIRECTION OF FLOW IN EQUATION (1) CAN BE USED TO SELECT THE
%...  APPROPRIATE FINITE DIFFERENCE APPROXIMATION FOR THE FIRST-ORDER
%...  SPATIAL DERIVATIVE IN EQUATION (1), U .  THE CONVENTION FOR THE
%...  SIGN OF V IS                         X
%...
%...     FLOW LEFT TO RIGHT                 V GT 0
%...     (I.E., IN THE DIRECTION            (I.E., THE SIXTH ARGUMENT IS
%...     OF INCREASING X)                   POSITIVE IN CALLING DSS012)
%...
%...     FLOW RIGHT TO LEFT                 V LT 0
%...     (I.E., IN THE DIRECTION            (I.E., THE SIXTH ARGUMENT IS
%...     OF DECREASING X)                   NEGATIVE IN CALLING DSS012)
%...
%...  COMPUTE THE SPATIAL INCREMENT, THEN SELECT THE FINITE DIFFERENCE
%...  APPROXIMATION DEPENDING ON THE SIGN OF V IN EQUATION (1).  THE
%...  ORIGIN OF THE FINITE DIFFERENCE APPROXIMATIONS USED BELOW IS GIVEN
%...  AT THE END OF FUNCTION DSS012.
     dx = (xu-xl)/(n-1);
     ux = zeros(n,1);
%...
%...     (1)  FINITE DIFFERENCE APPROXIMATION FOR POSITIVE V
      if v > 0
              ux(1)=(u(2)-u(1))/dx;
              for i=2:n
                 ux(i)=(u(i)-u(i-1))/dx;
              end
      end
%...
%...     (2)  FINITE DIFFERENCE APPROXIMATION FOR NEGATIVE V
      if v < 0
              nm1=n-1;
              for i=1:nm1
                 ux(i)=(u(i+1)-u(i))/dx;
              end
              ux(n)=(u(n)-u(n-1))/dx;
      end
%...
%...  THE BACKWARD DIFFERENCES IN SECTION (1) ABOVE ARE BASED ON THE
%...  TAYLOR SERIES
%...
%...                                  2           3
%...  UI-1 = UI + UI (-dx) + UI  (-dx) + UI  (-dx) + ...
%...                X  1F      2X  2F      3X  3F
%...
%...                                          2
%...  IF THIS SERIES IS TRUNCATED AFTER THE dx  TERM AND THE RESULTING
%...  EQUATION SOLVED FOR U ,  WE OBTAIN IMMEDIATELY
%...                       X
%...
%...  UI  = (UI - UI-1)/dx + O(dx)
%...    X
%...
%...  WHICH IS THE FIRST-ORDER BACKWARD DIFFERENCE USED IN DO LOOP 1.
%...  THE DERIVATIVE U1  IS COMPUTED BY USING THE POINT TO THE RIGHT OF
%...                   X
%...  U1, I.E., U2, SINCE THIS IS THE ONLY POINT AVAILABLE IF FICTITIOUS
%...  POINTS TO THE LEFT OF U1 ARE TO BE AVOIDED.
%...
%...  THE FORWARD DIFFERENCES IN SECTION (2) ABOVE ARE BASED ON THE
%...  TAYLOR SERIES
%...
%...                                  2           3
%...  UI+1 = UI + UI ( dx) + UI  ( dx) + UI  ( dx) + ...
%...                X  1F      2X  2F      3X  3F
%...
%...                                          2
%...  IF THIS SERIES IS TRUNCATED AFTER THE dx  TERM AND THE RESULTING
%...  EQUATION SOLVED FOR U ,  WE OBTAIN IMMEDIATELY
%...                       X
%...
%...  UI  = (UI+1 - UI)/dx + O(dx)
%...    X
%...
%...  WHICH IS THE FIRST-ORDER FORWARD DIFFERENCE USED IN DO LOOP 2.
%...  THE DERIVATIVE UN  IS COMPUTED BY USING THE POINT TO THE LEFT OF
%...                   X
%...  UN (UN-1), SINCE THIS IS THE ONLY POINT AVAILABLE IF FICTITIOUS
%...  POINTS TO THE RIGHT OF UN ARE TO BE AVOIDED.