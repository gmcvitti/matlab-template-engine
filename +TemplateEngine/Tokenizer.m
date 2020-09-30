classdef Tokenizer < handle
    %TOKENIZER Summary of this class goes here
    %   Detailed explanation goes here
    
    properties
        template (1,1) string = "";
        pos (1,1) double = 1;
    end
    
    methods
        function tokenizer = Tokenizer(template)
            %TOKENIZER Construct an instance of this class
            %   Detailed explanation goes here
            tokenizer.template = template;
        end
        
        function str = nextToken(tokenizer)
            %METHOD1 Summary of this method goes here
            %   Detailed explanation goes here
            
            template = extractAfter(tokenizer.template,tokenizer.pos-1);
            
            
        end
    end
end

