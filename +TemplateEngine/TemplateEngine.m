classdef TemplateEngine < handle
    %TEMPLATEENGINE Summary of this class goes here
    %   Detailed explanation goes here
    
    properties (Access = private)
        template = "";
    end
    
    properties (SetObservable)
        l (1,1) string;
    end
    
    methods
        function templateEngine = TemplateEngine()
            %TEMPLATEENGINE Construct an instance of this class
            %   Detailed explanation goes here
            
            addlistener(templateEngine,'l','PostSet',@templateEngine.update);
        end  
        
        function str = render(templateEngine)
            str = templateEngine.template;
        end
        
    end
    
    methods (Static)
        function update(~,eventData)
            %METHOD1 Summary of this method goes here
            %   Detailed explanation goes here
                        
            eventData.AffectedObject.template = ...
                eventData.AffectedObject.template + eventData.AffectedObject.l + newline;
        end        
    end
end

