classdef Token
    %TOKEN Summary of this class goes here
    %   Detailed explanation goes here
    
    properties 
        type (1,1) TemplateEngine.TokenTypes;
        data (1,1) struct;    
        pos (1,1) uint64;
        length (1,1) uint64;
    end
    
    methods
        function token = Token(type,data,pos,length)
            
            arguments
                type (1,1) TemplateEngine.TokenTypes;
                data (1,1) struct; 
                pos (1,1) uint64;
                length (1,1) uint64;
            end
                        
            token.type = type;
            token.data = data;
            token.pos = pos;
            token.length = length;
        end  
    end
    
    
    
end

