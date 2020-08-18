function render()

templateStr = "Hello World {{ value }} ?";
topData = struct("value","Geoff");


lexer = TemplateEngine.Lexer(templateStr);
i = 1;

token = lexer.nextToken();
        
while true
    token = [token;lexer.nextToken()];
    i = i+1;
    if isempty(token)
        break;
    end    
end

end