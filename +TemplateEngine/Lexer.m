classdef Lexer < handle
    %LEXER Summary of this class goes here
    %   Detailed explanation goes here
    
    properties
       templateStr (1,1) string
       templatePos (1,1) double = 0;
    end   
     
    
    methods
        function lexer = Lexer(templateStr)
            %LEXER Construct an instance of this class
            %   Detailed explanation goes here
            lexer.templateStr = templateStr;            
        end
        
        function token = nextToken(lexer)
            %NEXTTOKEN Summary of this method goes here
            %   Detailed explanation goes here
            
            % End of String
            if lexer.templatePos == strlength(lexer.templateStr)
                token = [];
                return;
            end   
            
            % Get the Remaining Template String         
            str = extractAfter(lexer.templateStr,lexer.templatePos);
            
            
            % Get next complete token excluding TEXT
            token = [];
            tokenPos = inf;
                                    
            for tokenType = string(enumeration("TemplateEngine.TokenTypes"))'   
                
                if tokenType == "TEXT"                    
                    continue;
                end                  
                        
                expression = TemplateEngine.TokenTypes.(tokenType).getExpression();
                [startPos,endPos,data] = regexp(str,expression,"start","end","names","once");
                
                if isempty(startPos)
                    continue;
                end
                
                if startPos < tokenPos
                    tokenPos = startPos;
                    token = TemplateEngine.Token(...
                        tokenType,data,...
                        lexer.templatePos+startPos,endPos-startPos+1);
                end                        
            end 
            
                        
            % Return Text Token If Text Preceeds Other Tokens
            if tokenPos == inf                
                data = struct("text",str);
                token = TemplateEngine.Token("TEXT",data,lexer.templatePos+1,strlength(str));
            elseif tokenPos > 1
                data = struct("text",extractBefore(str,tokenPos));
                token = TemplateEngine.Token("TEXT",data,lexer.templatePos+1,tokenPos-1);
            end            
                        
            % Update Position in Lexer
            lexer.templatePos = lexer.templatePos + token.length;            
        end
        

    end
end

