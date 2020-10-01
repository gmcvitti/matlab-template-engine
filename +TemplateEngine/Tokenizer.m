classdef Tokenizer < handle
    %TOKENIZER Summary of this class goes here
    %   Detailed explanation goes here
    
    properties
        template (1,1) string;
        encapsulation (1,1) TemplateEngine.Encapsulation;
    end
          
    methods
        function tokenizer = Tokenizer(encapsulation)
            %TOKENIZER Construct an instance of this class
            %   Detailed explanation goes here
            arguments
                encapsulation (1,1) TemplateEngine.Encapsulation = TemplateEngine.Encapsulation();
            end
            
            tokenizer.encapsulation = encapsulation;   
        end
        
        
        function addTemplate(tokenizer,template)
            arguments
                tokenizer (1,1) TemplateEngine.Tokenizer
                template (1,1) string
            end            
            
            tokenizer.template = template;            
        end        
        
        
        function token = nextToken(tokenizer)
            %METHOD1 Summary of this method goes here
            %   Detailed explanation goes here
            
            if strlength(tokenizer.template) == 0
               token = string.empty();
               return;
            end
            
            
            switch true
                case startsWith(tokenizer.template,tokenizer.expression)
                    
                    token = extract(tokenizer.template,tokenizer.expression);
                    token = token(1);                            
                    tokenizer.template = extractAfter(tokenizer.template,token);
                
                case startsWith(tokenizer.template,tokenizer.value)
                    
                    token = extract(tokenizer.template,tokenizer.value);
                    token = token(1);                            
                    tokenizer.template = extractAfter(tokenizer.template,token);
                    
                case startsWith(tokenizer.template,tokenizer.newline)                    
                    
                    token = extract(tokenizer.template,tokenizer.newline);
                    token = token(1);                            
                    tokenizer.template = extractAfter(tokenizer.template,token);
                    
                case startsWith(tokenizer.template,tokenizer.text)
                    
                    token = extract(tokenizer.template,tokenizer.text);
                    token = token(1);                            
                    tokenizer.template = extractAfter(tokenizer.template,token);
                    
            end
                                              
            
        end
        
        
        
        function pat = expression(tokenizer)
            pat = ...
                tokenizer.encapsulation.expression(1) + ...
                wildcardPattern(1,inf,"Except",tokenizer.encapsulation.expression(2)) + ...
                tokenizer.encapsulation.expression(2);  
        end
        
        function pat = value(tokenizer)
            pat = ...
                tokenizer.encapsulation.value(1) + ...
                wildcardPattern(1,inf,"Except",tokenizer.encapsulation.value(2)) + ...
                tokenizer.encapsulation.value(2);
        end
        
        function pat = text(tokenizer)
            exceptPat = pattern(tokenizer.encapsulation.value(1)|tokenizer.encapsulation.expression(1)|newline);
            pat = ...
                asManyOfPattern(wildcardPattern(1,inf,"Except",exceptPat));
        end
        
        function pat = newline(tokenizer)
            pat = pattern(newline);
        end
        
        
    end
end

