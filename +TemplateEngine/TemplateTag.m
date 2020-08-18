classdef TemplateTag
    %TEMPLATETAG Summary of this class goes here
    %   Detailed explanation goes here
    
    enumeration
        TEXT
        VALUE
        LOOP
        CONDITIONAL
        END
        COMMENT        
    end
    
    methods
        function expression = getExpression(obj)
            
            switch obj
                case "TEXT"
                    expression = ".*";
                case "VALUE"     
                    expression = "\{\{\s*(?<value>\w+)\s*\}\}"; 
                case "COMMENT"
                    expression = "\{\{\\!\-\-.*\-\-\}\}";
                case "CONDITIONAL"
                    expression = "\{\{\#\s*if\s+(?<condition>\w+)\s*\}\}";
                case "LOOP"
                    expression = "\{\{\#\s*for\s+(?<element>\w+)\s*\=\s*(?<array>\w+)\s*\}\}";  
                case "END"
                    expression = "\{\{\#\s*end\s*\}\}";
                otherwise            
                    error("Invalid tokentype");
            end
            
        end        
    end
end

