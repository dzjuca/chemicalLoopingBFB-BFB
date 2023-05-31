classdef Iterations < handle
    properties (Access = public)
        ncall
    end
    
    methods (Access = private)
        function obj = Iterations()
            % Constructor privado
            obj.ncall = 1;
        end
    end
    
    methods (Static)
        function singleObj = getInstance()
            % Devuelve la única instancia de la clase
            persistent localObj
            if isempty(localObj) || ~isvalid(localObj)
                localObj = Iterations();
            end
            singleObj = localObj;
        end
    end
    
    methods
        function incrementNcall(obj)
            % Incrementa la propiedad someProperty en 1
            obj.ncall = obj.ncall + 1;
        end
        
        function dispNcall(obj)
            % Muestra el valor de someProperty
            disp(obj.ncall)
        end

        function ncallValue = getNcall(obj)

            ncallValue = obj.ncall;

        end

        function ncallReset(obj)

            obj.ncall = 1;

        end
    end
end
