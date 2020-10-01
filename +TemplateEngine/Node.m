classdef Node
    %NODE Summary of this class goes here
    %   Detailed explanation goes here
    
    properties
        child (1,:) TemplateEngine.Node
        next (1,:) TemplateEngine.Node
        token (1,:) TemplateEngine.Token = TemplateEngine.Token.empty();
    end
    
    methods
        function [node,tokens] = Node(tokens)
            arguments
                tokens (1,:) TemplateEngine.Token                
            end
            
            persistent nNodes
            if isempty(nNodes)
                nNodes = 0
            else
                nNodes = nNodes + 1
            end
            
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
            
        function str = evaluate(node,data)   
            arguments
                node (1,1) TemplateEngine.Node
                data (1,1) struct
            end
            
            node
            
            str = "";
            
            if isempty(node)
                return;
            end            
            
            switch node.token.type
                
                case "TEXT"
                    str = str + node.token.data.text;
                    
                case "VALUE"
                    str = str + data.(node.token.data.value); 
                
                case "LOOP"
                    for i = 1:numel(data.(node.token.data.array))
                        data.(node.token.data.element) = data.(node.token.data.array)(i);
                        str = str + evaluate(node.child,data);
                    end
                    
                case "CONDITION"
                    if data.(node.token.data.cond)
                        str = str + evaluate(node.child,data);
                    end
                    
                case "END"
                    str = str;
                    
                case "NEWLINE"
                    str = str + newline;
                    
                case "COMMENT"
                    str = str;
                    
            end   
            
            if ~isempty(node.next)
                str = str + evaluate(node.next,data);
            end
            
            
            
        end
        
        
        function displayNodes(node)
            arguments
                node (1,1) TemplateEngine.Node
            end
            
            persistent num 
            if isempty(num)
                num = 1;
            end
            
            persistent depth
            if isempty(depth)
                depth = 0;
            end         
            
            str = pad(string(node.token.type),strlength(string(node.token.type)) + depth*4,'left');     
                            
            disp(str);            
            
            % disp(string(num) + " -- " + string(node.token.type))
            % num = num+1;
                        
            if ~isempty(node.child) 
                depth = depth + 1;
                displayNodes(node.child);
                depth = depth - 1;
            end 
            
            if ~isempty(node.next)                
                displayNodes(node.next);
            end
            
            
        end
        
    end
end

