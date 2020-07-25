classdef ValueToken < TemplateEngine.Token
    %TOKEN Summary of this class goes here
    %   Detailed explanation goes here
    
    properties
        value (1,1) string
    end
    
    methods
        function obj = ValueToken(originalStr,position,length,value)
            %TOKEN Construct an instance of this class
            %   Detailed explanation goes here
            obj = obj@TemplateEngine.Token(originalStr,position,length);
            obj.value = value;  
        end 
        
    end
end

