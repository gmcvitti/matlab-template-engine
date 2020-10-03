classdef Engine < handle
    %ENGINE Summary of this class goes here
    %   Detailed explanation goes here
    
    properties        
        templateStr (1,1) string = "";        
        lexer (1,1) TemplateEngine.Lexer = TemplateEngine.Lexer("");
        tokens (1,:) TemplateEngine.Token = TemplateEngine.Token.empty();
        renderTree (1,1) digraph = digraph();
    end
    
    properties
        outputStr (1,1) string = "";        
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
            engine.outputStr = "";            
            engine.renderGraph(1,data);
            
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
            
            if engine.tokens(node).type == "END"
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

                otherwise
                    nodeN = node+1;
                    
            end
            
            
            engine.renderTree = engine.renderTree.addedge(node,nodeN,1);
            node = buildGraph(engine,nodeN);
            
            
        end
        
        
        function displayGraph(engine)
            h = engine.renderTree.plot('EdgeLabel',engine.renderTree.Edges.Weight); 
            
            for i = 1:numel(engine.tokens)
                if engine.tokens(i).type == "NEWLINE"
                    labelnode(h,i,"\n");  
                else
                    labelnode(h,i,engine.tokens(i).str);
                end
            end
        end
        
        
        function [node,data] = renderGraph(engine,node,data)
            
            arguments
                engine (1,1) TemplateEngine.Engine
                node (1,1) double      
                data (1,1) struct
            end
            
            token = engine.tokens(node);
            
            if token.type ~= "END" && (outdegree(engine.renderTree,node) == 0)
                return;
            end            
            
            switch token.type
                case "LOOP"
                    fieldStr = token.data.array;
                    assert(TemplateEngine.issubfield(data,fieldStr),"Not a member of data.");  
                    fields = cellstr(strsplit(fieldStr,"."));
                    
                    array = getfield(data,fields{:});
                    
                    eid = outedges(engine.renderTree,node);
                    
                    for i = 1:numel(array)
                        loopdata = data;
                        loopdata.(token.data.element) = array(i);
                        node = engine.renderTree.Edges(eid(1),1).EndNodes(2);
                        renderGraph(engine,node,loopdata);
                    end
                    
                    node = engine.renderTree.Edges(eid(2),1).EndNodes(2);
                    [node,data] = renderGraph(engine,node,data);
                                        
                case "CONDITION"
                    fieldStr = token.data.cond;
                    assert(TemplateEngine.issubfield(data,fieldStr),"Not a member of data.");  
                    fields = cellstr(strsplit(fieldStr,"."));
                    
                    tf = getfield(data,fields{:});
                    assert(islogical(tf),"Must be logical");
                    
                    eid = outedges(engine.renderTree,node);
                    
                    if tf
                        node = engine.renderTree.Edges(eid(1),1).EndNodes(2);
                        renderGraph(engine,node,data);
                    end
                                        
                    node = engine.renderTree.Edges(eid(2),1).EndNodes(2);
                    [node,data] = renderGraph(engine,node,data);
                    
                case "TEXT"
                    engine.outputStr = engine.outputStr + token.data.text;
                    
                    eid = outedges(engine.renderTree,node);
                    node = engine.renderTree.Edges(eid,1).EndNodes(2);
                    [node,data] = renderGraph(engine,node,data);
                    
                case "VALUE"
                    fieldStr = token.data.value;
                    assert(TemplateEngine.issubfield(data,fieldStr),"Not a member of data.");  
                    fields = cellstr(strsplit(fieldStr,"."));
                    engine.outputStr = engine.outputStr + string(getfield(data,fields{:}));  
                    
                    eid = outedges(engine.renderTree,node);
                    node = engine.renderTree.Edges(eid,1).EndNodes(2);
                    [node,data] = renderGraph(engine,node,data);
                    
                case "NEWLINE"
                    engine.outputStr = engine.outputStr + newline;
                    
                    eid = outedges(engine.renderTree,node);
                    node = engine.renderTree.Edges(eid,1).EndNodes(2);
                    [node,data] = renderGraph(engine,node,data);                
                    
                case "COMMENT"
                    eid = outedges(engine.renderTree,node);
                    node = engine.renderTree.Edges(eid,1).EndNodes(2);
                    [node,data] = renderGraph(engine,node,data);
                    
                case "END"
                    
            end
            
            
        end
        
        
    end
end

