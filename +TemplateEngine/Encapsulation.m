classdef Encapsulation < handle
    %ENCAPSULATION Summary of this class goes here
    %   Detailed explanation goes here
    
    properties (SetAccess = private)       
        
        value (1,2) pattern = [...
            pattern("{{") + optionalPattern(whitespacePattern),...
            optionalPattern(whitespacePattern) + pattern("}}")];
        expression (1,2) pattern = [...
            pattern("{{#") + optionalPattern(whitespacePattern),...
            optionalPattern(whitespacePattern) + pattern("}}")];
        comment (1,2) pattern = [...
            pattern("{{!--") + optionalPattern(whitespacePattern),...
            optionalPattern(whitespacePattern) + pattern("--}}")];
        
    end
    
    methods
        
        function setValue(encapsulation,str)
            
            arguments
                encapsulation (1,1) TemplateEngine.Encapsulation
                str (1,2) string
            end
            
            assert(...
                (str(1) ~= encapsulation.expression(1)) || (str(1) ~= encapsulation.comment(1)),...
                "Value encapsulation must be unique");
            encapsulation.value = str;
        end   
        
        function setExpression(encapsulation,str)
            
            arguments
                encapsulation (1,1) TemplateEngine.Encapsulation
                str (1,2) string
            end
            
            assert(...
                (str(1) ~= encapsulation.value(1)) || (str(1) ~= encapsulation.comment(1)),...
                "Expression encapsulation must be unique");
            encapsulation.expression = str;
        end  
        
        function setComment(encapsulation,str)
            
            arguments
                encapsulation (1,1) TemplateEngine.Encapsulation
                str (1,2) string
            end
            
            assert(...
                (str(1) ~= encapsulation.value(1)) || (str(1) ~= encapsulation.expression(1)),...
                "Expression encapsulation must be unique");
            encapsulation.comment = str;
        end  
        
    end
end

