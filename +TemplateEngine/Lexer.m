classdef Lexer < handle
    %LEXER Summary of this class goes here
    %   Detailed explanation goes here
    
    properties
       templateStr (1,1) string = "";
       position (1,1) uint64 = 0;
    end   
     
    
    methods
        function obj = Lexer(templateStr)
            %LEXER Construct an instance of this class
            %   Detailed explanation goes here
            obj.templateStr = templateStr;            
        end
        
        function token = nextToken(obj)
            %METHOD1 Summary of this method goes here
            %   Detailed explanation goes here
            
            % Return Empty if at end
            if strlength(obj.templateStr) <= obj.position
                token = [];
                return;
            end
            
            % Find Next Tokem            
            str = extractAfter(obj.templateStr,obj.position);
            
            token = [];
            tokenPos = strlength(str);
                                    
            for tokenType = string(enumeration("TemplateEngine.TokenTypes"))'   
                
                if tokenType == "TEXT"
                    continue;
                end                  
                        
                [startPos,endPos,data] = regexp(...
                    str,TemplateEngine.TokenTypes.(tokenType).getExpression(),...
                    "start","end","names","once");
                
                if isempty(startPos)
                    continue;
                end
                
                if startPos < tokenPos
                    tokenPos = startPos;
                    token = TemplateEngine.Token(...
                        TemplateEngine.TokenTypes.(tokenType),data,...
                        obj.position+startPos,endPos-startPos+1);
                end                        
            end 
            
            % Return Text Token If Text Preceeds Other Tokens
            if tokenPos > 1                
                data = struct("text",extractBetween(str,1,tokenPos,"Boundaries","inclusive"));
                
                token = TemplateEngine.Token(...
                        TemplateEngine.TokenTypes.TEXT,data,...
                        obj.position+1,tokenPos-1);
            end            
            
            % Update Position in Lexer
            obj.position = obj.position + token.length;            
        end
        

    end
end

