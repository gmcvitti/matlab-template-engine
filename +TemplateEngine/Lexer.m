classdef Lexer < handle
    %LEXER Summary of this class goes here
    %   Detailed explanation goes here
    
    properties
       templateStr (1,1) string
       templateStrPos (1,1) uint64 = 1;
       tokens (1,:) TemplateEngine.Token
    end   
     
    
    methods
        function lexer = Lexer(templateStr)
            %LEXER Construct an instance of this class
            %   Detailed explanation goes here
            lexer.templateStr = templateStr;            
        end
        
        function token = nextToken(lexer)
            
            arguments
                lexer (1,1) TemplateEngine.Lexer
            end
            
            if lexer.templateStrPos == strlength(lexer.templateStr)
                token = TemplateEngine.Token.empty(0);
                return;
            end
                                                   
            candidateTokens = [...
                lexer.nextCandidateToken("LOOP");...
                lexer.nextCandidateToken("CONDITIONAL");...
                lexer.nextCandidateToken("COMMENT");...
                lexer.nextCandidateToken("END");...
                lexer.nextCandidateToken("VALUE");...
                lexer.nextCandidateToken("TEXT")];                      
                       
            [~,idx] = min([candidateTokens.pos]);
            
            token = candidateTokens(idx);
            
            lexer.templateStrPos = lexer.templateStrPos + token.length;
            
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
                token = TemplateEngine.Token(tokenType,data(1),...
                    startPos(1)+lexer.templateStrPos-1,1+endPos(1)-startPos(1));
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

