function str = templaterunner()
%PREPROCESSOR Summary of this function goes here
%   Detailed explanation goes here


str = "Hello World {{ value }} from. {{#for a=A }}. then {{#for a=A }} {{ value }}";



% [valueExpression,out] = getValueExpressions(str)

% [loopExpression,out] = getLoopExpressions(str)



[posStart,posEnd,names] = regexp(str,"(?<!\{)\{\{\s*(?<value>\w+)\s*\}\}","start","end","names")




end


%{


function [valueExpression,out] = getValueExpressions(str)

valueRegExpr = "(?<!\{)\{\{\s*(?<value>\w+)\s*\}\}";

[startIdx,endIdx,data,out] = regexp(str,valueRegExpr,"start","end","names","split");

for i = 1:numel(data)
    valueExpression(i) = data(1,i);
    valueExpression(i).pos = [startIdx(i), endIdx(i)];
end

end


function [loopExpression,out] = getLoopExpressions(str)

loopRegExpr = "(?<!\{)\{\{\#\s*for\s+(?<instance>\w+)\s*\=\s*(?<array>\w+)\s*\}\}";

[startIdx,endIdx,data,out] = regexp(str,loopRegExpr,"start","end","names","split");

for i = 1:numel(data)
    loopExpression(i) = struct(...
        "data",data(1,i),...
        "position",[startIdx(i), endIdx(i)]);
end

end






function [token,str] = getToken(str,






end

%}