classdef Tokenizer < handle
    %TOKENIZER Summary of this class goes here
    %   Detailed explanation goes here
    
    properties
        template (1,1) string = "";
    end
    
    properties
        tokens (1,:) string = string.empty();
        pos (1,1) double = 1;
    end
    
    properties
        exprEncapsulation = ["{{#","}}"];
        valueEncapsulation = ["{{","}}"];   
    end
    
    methods
        function tokenizer = Tokenizer(template)
            %TOKENIZER Construct an instance of this class
            %   Detailed explanation goes here
            arguments
                template (1,1) string
            end            
            
            tokenizer.template = template;
        end
        
   
        
        
        
        function token = nextToken(tokenizer)
            %METHOD1 Summary of this method goes here
            %   Detailed explanation goes here
            
            localTemplate = extractAfter(tokenizer.template,tokenizer.pos-1); 
            
            switch true
                case startsWith(localTemplate,tokenizer.expression)
                    
                    token = extract(localTemplate,tokenizer.expression);
                    token = token(1);                    
                    tokenizer.pos = tokenizer.pos + strlength(token); 
                
                case startsWith(localTemplate,tokenizer.value)
                    
                    token = extract(localTemplate,tokenizer.value);
                    token = token(1);                    
                    tokenizer.pos = tokenizer.pos + strlength(token);
                    
                case startsWith(localTemplate,newline)                    
                    
                    token = extract(localTemplate,newline);
                    token = token(1);                    
                    tokenizer.pos = tokenizer.pos + strlength(token);
                    
                case startsWith(localTemplate,tokenizer.text)
                    
                    token = extract(localTemplate,tokenizer.text);
                    token = token(1);                    
                    tokenizer.pos = tokenizer.pos + strlength(token);
                    
            end
                                              
            
        end
        
        
        
        function pat = expression(tokenizer)
            pat = ...
                tokenizer.exprEncapsulation(1) + ...
                wildcardPattern(1,inf,"Except",tokenizer.exprEncapsulation(2)) + ...
                tokenizer.exprEncapsulation(2);  
        end
        
        function pat = value(tokenizer)
            pat = ...
                tokenizer.valueEncapsulation(1) + ...
                wildcardPattern(1,inf,"Except",tokenizer.valueEncapsulation(2)) + ...
                tokenizer.valueEncapsulation(2);
        end
        
        function pat = text(tokenizer)
            exceptPat = pattern(tokenizer.valueEncapsulation(1)|tokenizer.exprEncapsulation(1)|newline);
            pat = ...
                asManyOfPattern(wildcardPattern(1,inf,"Except",exceptPat));
        end
        
        
        
    end
end

