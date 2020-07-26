classdef Token
    %TOKEN Summary of this class goes here
    %   Detailed explanation goes here
    
    properties
        type (1,1) TemplateEngine.TokenTypes;
        data (1,1) struct;
        position (1,1) double;
        length (1,1) double;        
    end
    
    methods
        function obj = Token(type,data,position,length)
            %TOKEN 
            obj.type = type;
            obj.data = data;
            obj.position = position;
            obj.length = length;
        end  
    end
    
    
    
end

