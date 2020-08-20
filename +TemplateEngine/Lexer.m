classdef Lexer < handle
    %LEXER Summary of this class goes here
    %   Detailed explanation goes here
    
    properties
       templateStr (1,1) string
       templateStrPos (1,1) uint64 = 1;
    end   
     
    
    methods
        function lexer = Lexer(templateStr)
            %LEXER Construct an instance of this class
            %   Detailed explanation goes here
            lexer.templateStr = templateStr;       
            lexer.templateStrPos = 1;
        end
        
        function token = nextToken(lexer)
            
            arguments
                lexer (1,1) TemplateEngine.Lexer
            end
            
            if lexer.templateStrPos > strlength(lexer.templateStr)
                token = TemplateEngine.Token.empty(0);
                return;
            end
                                                   
            candidateTokens = [...
                lexer.nextCandidateToken("LOOP");...
                lexer.nextCandidateToken("CONDITIONAL");...
                lexer.nextCandidateToken("COMMENT");...
                lexer.nextCandidateToken("END");...
                lexer.nextCandidateToken("VALUE");...
                lexer.nextCandidateToken("NEWLINE")];                      
                       
            [~,idx] = min([candidateTokens.pos]);            
            
            if isempty(idx)
                text = extractBetween(...
                    lexer.templateStr,...
                    lexer.templateStrPos,strlength(lexer.templateStr),...
                    "Boundaries","inclusive"); 
                data = struct("text",text);
                
                token = TemplateEngine.Token("TEXT",data,...
                    lexer.templateStrPos,strlength(data.text));
                lexer.templateStrPos = lexer.templateStrPos + strlength(lexer.templateStr);
                return;
            end
                        
            if candidateTokens(idx).pos == lexer.templateStrPos
                token = candidateTokens(idx);
                lexer.templateStrPos = lexer.templateStrPos + token.length;
                return;
            end
            
            
            nextClosestToken = candidateTokens(idx);
            startPos = lexer.templateStrPos;
            endPos = nextClosestToken.pos-1;
            
            text = extractBetween(...
                    lexer.templateStr,startPos,endPos,...
                    "Boundaries","inclusive");
            data = struct("text",text);
            
            token = TemplateEngine.Token("TEXT",data,startPos,strlength(text));
            lexer.templateStrPos = endPos + 1;
            
        end
        
                
        function token = nextCandidateToken(lexer,tokenType) 
            
            arguments
                lexer (1,1) TemplateEngine.Lexer
                tokenType (1,1) TemplateEngine.TokenTypes
            end
            
            str = extractBetween(...
                lexer.templateStr,...
                lexer.templateStrPos,strlength(lexer.templateStr),...
                "Boundaries","inclusive");           
                   
            [startPos,endPos,data] = ...
                regexp(str,getExpression(tokenType),"start","end","names","once");
                        
            if isempty(startPos)
                token = TemplateEngine.Token.empty(0);
            else
                token = TemplateEngine.Token(tokenType,data,...
                    startPos+lexer.templateStrPos-1,1+endPos-startPos);
            end
            
        end        
        
        function token = nextCandidateTextToken(lexer,length)
            arguments
                lexer (1,1) TemplateEngine.Lexer
                length (1,1) uint64
            end
            
            if strlength(lexer.templateStr) == lexer.templateStrPos
                token = TemplateEngine.Token.empty(0);
            end
            
            str = extractBetween(...
                lexer.templateStr,...
                lexer.templateStrPos,lexer.templateStrPos+length,...
                "Boundaries","inclusive"); 
            
            data = struct("text",str);
            
            token = TemplateEngine.Token("TEXT",data,lexer.templateStrPos,lexer.templateStrPos+length-1);            
            
        end
        

    end
end

