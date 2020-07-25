classdef Token
    %TOKEN Summary of this class goes here
    %   Detailed explanation goes here
    
    properties
        position (1,1) uint64;
        length (1,1) uint64;
        type (1,1) TemplateEngine.TokenTypes;
        data (1,1) struct;
    end
    
    methods
        function obj = Token(type,data,position,length)
            %TOKEN Construct an instance of this class
            %   Detailed explanation goes here
            obj.type = type;
            obj.data = data;
            obj.position = position;
            obj.length = length;
            
        end  
    end
    
    
    
end

