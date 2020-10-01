classdef Lexer < handle
    %TOKENIZER Summary of this class goes here
    %   Detailed explanation goes here
    
    properties
        template (1,1) string;
        encapsulation (1,1) TemplateEngine.Encapsulation = TemplateEngine.Encapsulation();
    end
          
    methods
        function lexer = Lexer(template)
            %TOKENIZER Construct an instance of this class
            %   Detailed explanation goes here 
            arguments
                template (1,1) string
            end 
            
            lexer.template = template;
        end
                
        
        function token = nextToken(lexer)
            %METHOD1 Summary of this method goes here
            %   Detailed explanation goes here
            
            arguments
                lexer (1,1) TemplateEngine.Lexer
            end
            
            if strlength(lexer.template) == 0
               token = string.empty();
               return;
            end
            
            
            switch true
                case startsWith(lexer.template,TemplateEngine.TokenTypes.getPattern("LOOP"))
                    token = extractToken(lexer,"LOOP");                
                
                case startsWith(lexer.template,TemplateEngine.TokenTypes.getPattern("CONDITION"))
                    token = extractToken(lexer,"CONDITION"); 
                    
                case startsWith(lexer.template,TemplateEngine.TokenTypes.getPattern("END"))
                    token = extractToken(lexer,"END"); 
                    
                case startsWith(lexer.template,TemplateEngine.TokenTypes.getPattern("COMMENT"))
                    token = extractToken(lexer,"COMMENT"); 
                    
                case startsWith(lexer.template,TemplateEngine.TokenTypes.getPattern("VALUE"))
                    token = extractToken(lexer,"VALUE"); 
                    
                case startsWith(lexer.template,TemplateEngine.TokenTypes.getPattern("NEWLINE"))
                    token = extractToken(lexer,"NEWLINE"); 
                    
                case startsWith(lexer.template,TemplateEngine.TokenTypes.getPattern("TEXT"))
                    token = extractToken(lexer,"TEXT"); 
                    
            end
                                              
            
        end
        
        function token = extractToken(lexer,type) 
            arguments
                lexer (1,1) TemplateEngine.Lexer
                type (1,1) TemplateEngine.TokenTypes
            end
            
            str = extract(lexer.template,TemplateEngine.TokenTypes.getPattern(type,lexer.encapsulation));
            str = str(1);
            token = TemplateEngine.Token(type,TemplateEngine.TokenTypes.getData(type,str,lexer.encapsulation),str);
            lexer.template = extractAfter(lexer.template,str);
            
        end
        
    end
end
