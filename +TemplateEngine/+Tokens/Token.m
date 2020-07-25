classdef Token
    %TOKEN Summary of this class goes here
    %   Detailed explanation goes here
    
    properties
        originalStr (1,1) string;
        position (1,1) uint64;
        length (1,1) uint64;
    end
    
    methods
        function obj = Token(originalStr,position,length)
            %TOKEN Construct an instance of this class
            %   Detailed explanation goes here
            obj.originalStr = originalStr;
            obj.position = position;
            obj.length = length;
        end 
        
    end
end

