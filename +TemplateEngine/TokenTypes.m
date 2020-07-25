classdef TokenTypes
    %TOKENTYPES Summary of this class goes here
    %   Detailed explanation goes here
    
    enumeration
        TEXT
        EXPRESSION
    end
    
    methods
        function [inner,outer] = getRegExpStr(obj)
            
            switch obj
                case "TEXT"
                    inner = ".*";
                    outer = ".*";
                case "EXPRESSION"     
                    outer = "\{\{.+\}\}";
                    inner = "(?<=\{\{).+(?=\}\})";
                    
                otherwise            
                    error("Invalid tokentype");
            end
            
        end        
    end
end

