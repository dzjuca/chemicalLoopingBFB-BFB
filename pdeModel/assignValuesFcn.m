function varargout = assignValuesFcn(u, Global, id)

    sen = Global.sen;
    gen = Global.gen;
    n1   = Global.n1;
    n2   = Global.n2;


    if strcmp(id,'gas_bubble')
        index_1   = gen;
        index_2   = n1;
        u_x       = u((1):(n1*gen));
        varargout = cell(1, index_1);

    elseif strcmp(id,'gas_emulsion')
        index_1   = gen;
        index_2   = n1;
        u_x       = u((n1*gen + 1):(n1*gen*2));
        varargout = cell(1, index_1);

    elseif strcmp(id,'solid_wake')
        index_1   = sen;
        index_2   = n1;
        u_x       = u((n1*gen*2 + 1):(n1*gen*2 + n1*sen));
        varargout = cell(1, index_1);

    elseif strcmp(id,'solid_emulsion')
        index_1   = sen;
        index_2   = n1;
        u_x       = u((n1*gen*2 + n1*sen + 1):(n1*gen*2 + n1*sen*2));
        varargout = cell(1, index_1);

    elseif strcmp(id,'gas_freeboard')
        index_1   = gen;
        index_2   = n2;
        u_x       = u((n1*gen*2 + n1*sen*2 + 1):(n1*gen*2 + n1*sen*2 + n2*gen));
        varargout = cell(1, index_1);

    elseif strcmp(id,'solid_freeboard')
        index_1   = sen;
        index_2   = n2;
        u_x       = u((n1*gen*2 + n1*sen*2 + n2*gen + 1):(n1*gen*2 + n1*sen*2 + n2*gen + n2*sen));
        varargout = cell(1, index_1);

    end


    for i = 1:index_1

        varargout{i} =  u_x((i - 1)*index_2+1:i*index_2);

    end

end
