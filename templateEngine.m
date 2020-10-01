
%% String Array
A = "Hello {{A}}, " + ...
    "{{# for x = X}}" + newline + ...
    "{{#if B}}" + ...
    "{{  x.a  }}" + ...
    "{{#end}}" + newline + ...
    "{{#for y = Y}}" + ...
    "{{y}}" + ...
    "{{#end}}" + ...
    "{{#end}}!";


% Lexer
lexer = TemplateEngine.Lexer(A);

% Assemble Token List
tokens = TemplateEngine.Token.empty();
for i = 1:25
    token = lexer.nextToken();
    if isempty(token)
        break;
    else
        tokens(end+1) = token;
    end  
end   



%% Data
data = struct(...
    "A","world",...
    "X",["A","B","C"],...
    "B",true,...
    "Y",["D","E"]);



%% Sort Nodes
node = TemplateEngine.Node(tokens);


