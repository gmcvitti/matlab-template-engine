classdef Engine < handle
    %ENGINE Summary of this class goes here
    %   Detailed explanation goes here
    
    properties        
        templateStr (1,1) string = "";        
        lexer (1,1) TemplateEngine.Lexer = TemplateEngine.Lexer("");
        tokens (1,:) TemplateEngine.Token = TemplateEngine.Token.empty();
        renderTree (1,1) digraph = digraph();
    end
      
        
    methods
        function engine = Engine(templateStr)
            
            arguments
                templateStr (1,1) string                
            end
            
            engine.templateStr = templateStr;
            engine.lexer = TemplateEngine.Lexer(templateStr);
        end
        
        function build(engine)
            arguments
                engine (1,1) TemplateEngine.Engine
            end            
            
            % Clear previous tokens
            engine.tokens = TemplateEngine.Token.empty();            
            
            % Tokenize the Template Str 
            engine.lexer = TemplateEngine.Lexer(engine.templateStr);
            
            try
                while true
                    token = engine.lexer.nextToken();
                    if isempty(token)
                        break;
                    end                                     
                    engine.tokens(end+1) = token;
                end
            
            catch ME
                
                
            end     
            
            % Construct DiGraph
            engine.renderTree = engine.renderTree.addnode(numel(engine.tokens));                
                    
            
            
            
            
            
            
        end
        
        function render(engine,data)
            arguments
                engine (1,1) TemplateEngine.Engine
                data (1,1) struct
            end
            
            % How to render the built template object
            
        end
        
        
        function tokens = buildGraph(engine,tokens)
            arguments
                engine (1,1) TemplateEngine.Engine
                tokens (1,:) TemplateEngine.Token                
            end
            
            engine.renderTree = engine.renderTree.addnode(1);
            
            
            
            
            node.token = tokens(1);
            
            
            if numel(tokens) == 1
                return;
            else
                tokens = tokens(2:end);
            end
            
            if tokens(1).type == "END"
                return;
            end            
                     
            switch node.token.type
                case "LOOP"
                    [node.child,tokens] = TemplateEngine.Node(tokens);  
                    [node.next,tokens] = TemplateEngine.Node(tokens);
                case "CONDITION"    
                    [node.child,tokens] = TemplateEngine.Node(tokens);  
                    [node.next,tokens] = TemplateEngine.Node(tokens);
                case "TEXT"
                    [node.next,tokens] = TemplateEngine.Node(tokens);
                case "VALUE"
                    [node.next,tokens] = TemplateEngine.Node(tokens);
                case "NEWLINE"
                    [node.next,tokens] = TemplateEngine.Node(tokens);
                case "COMMENT"
                    [node.next,tokens] = TemplateEngine.Node(tokens);
                case "END"
                    [node.next,tokens] = TemplateEngine.Node(tokens);
            end
              
            
        end
        
    end
end

