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
            engine.renderTree = digraph();
            engine.renderTree = engine.renderTree.addnode(numel(engine.tokens));                
                    
            engine.buildGraph(1);
            
            
            
            
            
        end
        
        function render(engine,data)
            arguments
                engine (1,1) TemplateEngine.Engine
                data (1,1) struct
            end
            
            % How to render the built template object
            
        end
        
        
        function node = buildGraph(engine,node)
            arguments
                engine (1,1) TemplateEngine.Engine
                node (1,1) double                
            end
            disp(node)
            
            if node == numel(engine.tokens)
                return; % Last Node
            end
            
            if engine.tokens(node+1).type == "END"
                return
            end
            
            switch engine.tokens(node).type
                case "LOOP"
                    engine.renderTree = engine.renderTree.addedge(node,node+1,2);
                    nodeN = buildGraph(engine,node+1);
                    nodeN = nodeN+1;
                                        
                case "CONDITION"    
                    engine.renderTree = engine.renderTree.addedge(node,node+1,2);
                    nodeN = buildGraph(engine,node+1); 
                    nodeN = nodeN+1;
                    
%                 case "TEXT"
%                     node = buildGraph(engine,node);
%                 case "VALUE"
%                     node = buildGraph(engine,node);
%                 case "NEWLINE"
%                     node = buildGraph(engine,node);
%                 case "COMMENT"
%                     node = buildGraph(engine,node);
%                 case "END"
%                     node = buildGraph(engine,node);
                otherwise
                    nodeN = node+1;
                    
            end
            
            
            engine.renderTree = engine.renderTree.addedge(node,nodeN,1);
            node = buildGraph(engine,nodeN);
            
            
        end
        
    end
end

