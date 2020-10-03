
%% String Array
A = "Hello {{A}}, " + ...
    "{{# for x = X}}" + ...
    "{{#if B}}" + ...
    "{{  x  }}" + newline + ...
    "{{#end}}" + newline + ...
    "{{#for y = Y}}" + ...
    "{{y}}" + ...
    "{{#end}}" + ...
    "{{#end}}!";


% Lexer
lexer = TemplateEngine.Lexer(A);

% Assemble Token List
tokens = TemplateEngine.Token.empty();
while true
    token = lexer.nextToken();
    if isempty(token)
        break;
    else
        tokens(end+1) = token;
    end  
end   


%% Token Cleanup
idx = ones(size(tokens));

for i = 1:numel(tokens)-2
    
    token = tokens(i);

   if token.type == "NEWLINE"
       if tokens(i+1).type == "LOOP" || tokens(i+1).type == "CONDITION" || tokens(i+1).type == "END"
           if tokens(i+2).type == "NEWLINE"
               idx(i) = false;            
           end
       end
   end
end

tokens = tokens(logical(idx));


%% Data
data = struct(...
    "A","world",...
    "X",["A","B","C"],...
    "B",true,...
    "Y",["D","E"]);



%% Sort Nodes
node = TemplateEngine.Node(tokens);





%% 

