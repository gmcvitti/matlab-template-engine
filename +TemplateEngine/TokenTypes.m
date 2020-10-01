classdef TokenTypes
    %TOKENTYPES Summary of this class goes here
    %   Detailed explanation goes here
    
    enumeration
        TEXT
        VALUE
        LOOP
        CONDITION
        END
        NEWLINE
        COMMENT        
    end
    
    methods (Static)
        
        function pat = getPattern(type,encapsulation)
            
            arguments
                type (1,1) TemplateEngine.TokenTypes
                encapsulation (1,1) TemplateEngine.Encapsulation = TemplateEngine.Encapsulation();
            end
            
            switch type
                case "LOOP"
                    % {{# for x = X }}
                    pat = ...
                        encapsulation.expression(1) + ...
                        optionalPattern(whitespacePattern) + ...
                        pattern("for") + ...
                        whitespacePattern + ...
                        wildcardPattern(1,inf,"Except",(whitespacePattern|pattern("="))) + ...
                        optionalPattern(whitespacePattern) + ...
                        pattern("=") + ...
                        optionalPattern(whitespacePattern) + ...
                        wildcardPattern(1,inf,"Except",(whitespacePattern|encapsulation.expression(2))) + ...
                        optionalPattern(whitespacePattern) + ...
                        encapsulation.expression(2);
                    
                case "CONDITION"
                    % {{# if x }}
                    pat = ...
                        encapsulation.expression(1) + ...
                        optionalPattern(whitespacePattern) + ...
                        pattern("if") + ...
                        whitespacePattern + ...
                        asManyOfPattern(wildcardPattern(1,inf,"Except",(whitespacePattern|encapsulation.expression(2)))) + ...
                        optionalPattern(whitespacePattern) + ...
                        encapsulation.expression(2);
                    
                case "END"
                    % {{# end }}
                    pat = ...
                        encapsulation.expression(1) +...
                        optionalPattern(whitespacePattern) + ...
                        pattern("end") + ...
                        optionalPattern(whitespacePattern) + ...
                        encapsulation.expression(2);
                    
                case "COMMENT"    
                    % {{!-- Anything --}}
                    pat = ...
                        encapsulation.comment(1) +...
                        asManyOfPattern(wildcardPattern(1,inf,"Except",encapsulation.comment(2))) + ...
                        encapsulation.expression(2);
                    
                case "VALUE"
                    % {{ x }}
                    pat = ...
                        encapsulation.value(1) + ...
                        optionalPattern(whitespacePattern) + ...
                        asManyOfPattern(wildcardPattern(1,inf,"Except",(whitespacePattern|encapsulation.value(2)))) + ...
                        optionalPattern(whitespacePattern) + ...
                        encapsulation.value(2);
                    
                case "TEXT"
                    % Hello world
                    exceptPat = pattern((...
                        encapsulation.value(1)|...
                        encapsulation.expression(1)|...
                        encapsulation.comment(1)|...
                        newline));
                    pat = ...
                        asManyOfPattern(wildcardPattern(1,inf,"Except",exceptPat));
                    
                case "NEWLINE"
                    % newline()
                    pat = pattern(newline);
                    
            end
            
            
        end
        
        function data = getData(type,str,encapsulation)
            arguments
                type (1,1) TemplateEngine.TokenTypes
                str (1,1) string
                encapsulation (1,1) TemplateEngine.Encapsulation = TemplateEngine.Encapsulation();
            end
            
            switch type
                case "LOOP"
                    substr = extractBetween(str,...
                        encapsulation.expression(1)+optionalPattern(whitespacePattern)+pattern("for"),...
                        encapsulation.expression(2));
                    substr = erase(substr,whitespacePattern);
                    substr = split(substr,"=");                    
                    data = struct("element",substr(1),"array",substr(2));
                    
                case "CONDITION"
                    substr = extractBetween(str,...
                        encapsulation.expression(1)+optionalPattern(whitespacePattern)+pattern("if"),...
                        encapsulation.expression(2));
                    substr = erase(substr,whitespacePattern);
                    data = struct("cond",substr);
                    
                case "END"
                    % {{# end }}                    
                    data = struct();
                    
                case "COMMENT"    
                    % {{!-- Anything --}}                    
                    data = struct();
                    
                case "VALUE"
                    % {{ x }}
                    substr = extractBetween(str,encapsulation.expression(1),encapsulation.expression(2));
                    substr = erase(substr,whitespacePattern);
                    data = struct("value",substr);
                    
                case "TEXT"
                    % Hello world
                    data = struct("text",str);
                    
                case "NEWLINE"
                    % newline()
                    data = struct("text",newline);
            end
            
        end
        
        
    end
    
end

