classdef Token
    %TOKEN Summary of this class goes here
    %   Detailed explanation goes here
    
    properties 
        type (1,1) TemplateEngine.TokenTypes;
        data (1,1) struct; 
        str (1,1) string;
    end
    
    methods
        function token = Token(type,data,str)
            
            arguments
                type (1,1) TemplateEngine.TokenTypes;
                data (1,1) struct; 
                str (1,1) string;
            end
                        
            token.type = type;
            token.data = data;
            token.str = str;
        end  
    end
    
    
    
end

