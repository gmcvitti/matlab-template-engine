classdef Encapsulation < handle
    %ENCAPSULATION Summary of this class goes here
    %   Detailed explanation goes here
    
    properties (SetAccess = private)  
        value (1,2) pattern = pattern(["{{","}}"]);
        expression (1,2) pattern = pattern(["{{#","}}"]);
        comment (1,2) pattern = pattern(["{{!--","--}}"]);
    end
    
    methods
        
        function setValue(encapsulation,pat)
            
            arguments
                encapsulation (1,1) TemplateEngine.Encapsulation
                pat (1,2) pattern
            end
            
            assert(pat(1) ~= encapsulation.expression(1),"Value encapsulation must be unique");
            assert(pat(1) ~= encapsulation.comment(1),"Value encapsulation must be unique");
            encapsulation.value = pat;
        end   
        
        function setExpression(encapsulation,pat)
            
            arguments
                encapsulation (1,1) TemplateEngine.Encapsulation
                pat (1,2) pattern
            end
            
            assert(pat(1) ~= encapsulation.value(1),"Value encapsulation must be unique");
            assert(pat(1) ~= encapsulation.comment(1),"Value encapsulation must be unique");
            encapsulation.expression = pat;
        end  
        
        function setComment(encapsulation,pat)
            
            arguments
                encapsulation (1,1) TemplateEngine.Encapsulation
                pat (1,2) pattern
            end
            
            assert(pat(1) ~= encapsulation.value(1),"Value encapsulation must be unique");
            assert(pat(1) ~= encapsulation.expression(1),"Value encapsulation must be unique");
            encapsulation.comment = pat;
        end  
        
    end
end

