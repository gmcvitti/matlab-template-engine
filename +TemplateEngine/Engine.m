classdef Engine < handle
    %ENGINE Summary of this class goes here
    %   Detailed explanation goes here
    
    properties
        templateStr (1,1) string = "";
        lexer (1,1) TemplateEngine.Lexer;
    end
      
        
    methods
        function engine = Engine(templateStr)
            
            arguments
                templateStr (1,1) string                
            end
            
            engine.templateStr = templateStr;
            engine.lexer = TemplateEngine.Lexer(engine.templateStr);
        end
        
        function build(engine)
            arguments
                engine (1,1) TemplateEngine.Engine
            end
            
            % How to build template
            
            
        end
        
        function render(engine,data)
            arguments
                engine (1,1) TemplateEngine.Engine
                data (1,1) struct
            end
            
            % How to render the built template object
            
        end
        
        
    end
end

