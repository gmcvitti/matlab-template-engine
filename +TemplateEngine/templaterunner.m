
%PREPROCESSOR Summary of this function goes here
%   Detailed explanation goes here

T = TemplateEngine.TemplateEngine();

T.l = "Hello World";
T.l = "Maybe Works";

for i = 1:15
T.l = "   " + i + ". Entry"; 
end

T.l = "end";


T.render()