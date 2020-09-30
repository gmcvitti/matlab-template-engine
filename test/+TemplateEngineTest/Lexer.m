classdef Lexer < matlab.unittest.TestCase
    %TLEXER Summary of this class goes here
    %   Detailed explanation goes here
    
    methods (Test)
        function LexerEmptyString(testCase)
            
            str = "";
            lexer = TemplateEngine.Lexer(str);
            testCase.verifyEmpty(lexer.nextToken());
            
        end
        
        function LexerTextOnlyToken(testCase)
            str = "Hello World";
            lexer = TemplateEngine.Lexer(str);
            
            token = lexer.nextToken();
            testCase.verifyClass(token,"TemplateEngine.Token");
            testCase.verifyEqual(token.type,TemplateEngine.TokenTypes.TEXT);
            testCase.verifyEqual(token.data.text,"Hello World");
            testCase.verifyEqual(token.length,uint64(11));
            testCase.verifyEmpty(lexer.nextToken());
            
        end
        
        function LexerValueOnlyToken(testCase)
            str = "{{ value }}";
            lexer = TemplateEngine.Lexer(str);
            
            token = lexer.nextToken();
            testCase.verifyClass(token,"TemplateEngine.Token");
            testCase.verifyEqual(token.type,TemplateEngine.TokenTypes.VALUE);
            testCase.verifyEqual(token.data.value,"value");
            testCase.verifyEqual(token.length,uint64(11));
            testCase.verifyEmpty(lexer.nextToken());
            
        end
        
        function LexerTextThenValueToken(testCase)
            str = "Hello {{ value }}";
            lexer = TemplateEngine.Lexer(str);
            
            token = lexer.nextToken();
            
            testCase.verifyEqual(token.type,TemplateEngine.TokenTypes.TEXT);
            testCase.verifyEqual(token.data.text,"Hello ");
            testCase.verifyEqual(token.length,uint64(6));
            
            token = lexer.nextToken();
            
            testCase.verifyEqual(token.type,TemplateEngine.TokenTypes.VALUE);
            testCase.verifyEqual(token.data.value,"value");
            testCase.verifyEqual(token.length,uint64(11));
                             
            testCase.verifyEmpty(lexer.nextToken());
            
        end
        
        function LexerValueThenTextToken(testCase)
            str = "{{ value }} world";
            lexer = TemplateEngine.Lexer(str);
            
            token = lexer.nextToken();
            
            testCase.verifyEqual(token.type,TemplateEngine.TokenTypes.VALUE);
            testCase.verifyEqual(token.data.value,"value");
            testCase.verifyEqual(token.length,uint64(11));
            
            token = lexer.nextToken();
            
            testCase.verifyEqual(token.type,TemplateEngine.TokenTypes.TEXT);
            testCase.verifyEqual(token.data.text," world");
            testCase.verifyEqual(token.length,uint64(6));
                                        
            testCase.verifyEmpty(lexer.nextToken());
            
        end
        
        function LexerLoopOnlyToken(testCase)
            str = "{{# foreach one in many }}";
            lexer = TemplateEngine.Lexer(str);
            
            token = lexer.nextToken();
            testCase.verifyClass(token,"TemplateEngine.Token");
            testCase.verifyEqual(token.type,TemplateEngine.TokenTypes.LOOP);
            testCase.verifyEqual(token.data.element,"one");
            testCase.verifyEqual(token.data.array,"many");
            testCase.verifyEqual(token.length,uint64(26));
            testCase.verifyEmpty(lexer.nextToken());
            
        end
        
        function LexerEndOnlyToken(testCase)
            str = "{{#  end }}";
            lexer = TemplateEngine.Lexer(str);
            
            token = lexer.nextToken();
            testCase.verifyClass(token,"TemplateEngine.Token");
            testCase.verifyEqual(token.type,TemplateEngine.TokenTypes.END);            
            testCase.verifyEqual(token.length,uint64(11));
            testCase.verifyEmpty(lexer.nextToken());
            
            str = "{{#end }}";
            lexer = TemplateEngine.Lexer(str);
            
            token = lexer.nextToken();
            testCase.verifyClass(token,"TemplateEngine.Token");
            testCase.verifyEqual(token.type,TemplateEngine.TokenTypes.END);            
            testCase.verifyEqual(token.length,uint64(9));
            testCase.verifyEmpty(lexer.nextToken());
            
        end
        
        function LexerCondOnlyToken(testCase)
            str = "{{# if true }}";
            lexer = TemplateEngine.Lexer(str);
            
            token = lexer.nextToken();
            testCase.verifyClass(token,"TemplateEngine.Token");
            testCase.verifyEqual(token.type,TemplateEngine.TokenTypes.CONDITIONAL);
            testCase.verifyEqual(token.data.condition,"true");
            testCase.verifyEqual(token.length,uint64(14));
            testCase.verifyEmpty(lexer.nextToken());
            
        end
        
        
        function LexerNewlineOnlyToken(testCase)
            str = newline;
            lexer = TemplateEngine.Lexer(str);
            
            token = lexer.nextToken();
            testCase.verifyClass(token,"TemplateEngine.Token");
            testCase.verifyEqual(token.type,TemplateEngine.TokenTypes.NEWLINE);
            testCase.verifyEmpty(fieldnames(token.data));            
            testCase.verifyEqual(token.length,uint64(1));
            testCase.verifyEmpty(lexer.nextToken());
        end
        
        
        function LexerValueThenEndToken(testCase)
            str = "{{value}}{{#end}}";
            lexer = TemplateEngine.Lexer(str);
            
            token = lexer.nextToken();
            
            testCase.verifyEqual(token.type,TemplateEngine.TokenTypes.VALUE);
            testCase.verifyEqual(token.data.value,"value");
            testCase.verifyEqual(token.length,uint64(9));
            
            token = lexer.nextToken();
            
            testCase.verifyEqual(token.type,TemplateEngine.TokenTypes.END);
            testCase.verifyEqual(token.length,uint64(8));
                                        
            testCase.verifyEmpty(lexer.nextToken());
            
        end
        
        
        
        
        
        
        
        
    end
end

