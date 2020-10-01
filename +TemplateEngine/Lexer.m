classdef Lexer < handle
    %LEXER Summary of this class goes here
    %   Detailed explanation goes here
    
    properties
       template (1,1) string
       tokenizer (1,1) TemplateEngine.Tokenizer = TemplateEngine.Tokenizer();
       tokens (1,:) string = string.empty();
       pos (1,1) double = 1;
    end   
     
    
    methods
        function lexer = Lexer(template)
            %LEXER Construct an instance of this class
            %   Detailed explanation goes here
            lexer.template = template; 
        end
        
        
        function tokenize(lexer)            
            
            lexer.tokenizer.addTemplate(lexer.template);            
            while true
                token = lexer.tokenizer.nextToken();
                if isempty(token)
                    return;
                else
                    lexer.tokens(end+1) = token;
                end
            end            
        end     
        
        function token = nextToken(lexer)
            arguments
               lexer (1,1) TemplateEngine.Lexer 
            end
            
            token = lexer.tokens(lexer.pos);
            
            switch true
                case sta  (str,lexer.loopPattern)
                    
                case matches(str,lexer.conditionalPattern)
                
                
                
                otherwise
                    % Error condition
                
                
                
            end                       
            
        end
        
        function pat = patternIdentifier(lexer,type)
            
            arguments
                lexer (1,1) TemplateEngine.Lexer
                type (1,1) TempalteEngine.TokenTypes
            end
            
            switch type
                case "LOOP"
                    pat = ...
                        lexer.tokenizer.exprEncapsulation(1) + ...
                        optionalPattern(whitespacePattern) + ...
                        pattern("for") + whitespacePattern;
                case "CONDITIONAL"
                    pat = ...
                        lexer.tokenizer.exprEncapsulation(1) + ...
                        optionalPattern(whitespacePattern) + ...
                        pattern("if") + whitespacePattern;
                    
            end
        end
        
        
        
        
        
    end
        
        
end

