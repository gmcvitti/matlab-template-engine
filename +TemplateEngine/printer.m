function str = printer(token,data)
%PRINTER Summary of this function goes here
%   Detailed explanation goes here

arguments
    token (1,1) TemplateEngine.Token    
    data (1,1) struct
end


switch token.type
    case "TEXT"
        str = token.data.text;
    case "VALUE"
        str = get
    otherwise
        error("Invalid token type.");
end


end

