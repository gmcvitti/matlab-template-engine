classdef Lexer
    %LEXER Summary of this class goes here
    %   Detailed explanation goes here
    
    properties
       templateStr (1,1) string = "";
       tokens (1,:) TemplateEngine.Tokens.Token
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
            
            str = extractAfter(obj.templateStr,obj.position);
            
            [startIndex,endIndex] = regexp(...
                str,...
                TemplateEngine.TokenTypes.EXPRESSION.getRegExpStr());       
                        
            
            
            token = TemplateEngine.Token(...
                TemplateEngine.TokenTypes.EXPRESSION,...
                extractBetween(str,startIndex,endIndex));
            
        end
        
        function obj = transformToTokens(obj)
    end
end

