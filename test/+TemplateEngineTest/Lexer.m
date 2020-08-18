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
            testCase.verifyEqual(token.length,11);
            testCase.verifyEmpty(lexer.nextToken());
            
        end
        
        function LexerValueOnlyToken(testCase)
            str = "{{ value }}";
            lexer = TemplateEngine.Lexer(str);
            
            token = lexer.nextToken();
            testCase.verifyClass(token,"TemplateEngine.Token");
            testCase.verifyEqual(token.type,TemplateEngine.TokenTypes.VALUE);
            testCase.verifyEqual(token.data.value,"value");
            testCase.verifyEqual(token.length,11);
            testCase.verifyEmpty(lexer.nextToken());
            
        end
        
        function LexerTextThenValueToken(testCase)
            str = "Hello {{ value }}";
            lexer = TemplateEngine.Lexer(str);
            
            token = lexer.nextToken();
            
            testCase.verifyEqual(token.type,TemplateEngine.TokenTypes.TEXT);
            testCase.verifyEqual(token.data.text,"Hello ");
            testCase.verifyEqual(token.length,6);
            
            token = lexer.nextToken();
            
            testCase.verifyEqual(token.type,TemplateEngine.TokenTypes.VALUE);
            testCase.verifyEqual(token.data.value,"value");
            testCase.verifyEqual(token.length,11);
                             
            testCase.verifyEmpty(lexer.nextToken());
            
        end
        
        function LexerValueThenTextToken(testCase)
            str = "{{ value }} world";
            lexer = TemplateEngine.Lexer(str);
            
            token = lexer.nextToken();
            
            testCase.verifyEqual(token.type,TemplateEngine.TokenTypes.VALUE);
            testCase.verifyEqual(token.data.value,"value");
            testCase.verifyEqual(token.length,11);
            
            token = lexer.nextToken();
            
            testCase.verifyEqual(token.type,TemplateEngine.TokenTypes.TEXT);
            testCase.verifyEqual(token.data.text," world");
            testCase.verifyEqual(token.length,6);
                                        
            testCase.verifyEmpty(lexer.nextToken());
            
        end
        
        function LexerLoopOnlyToken(testCase)
            str = "{{# for one = many }}";
            lexer = TemplateEngine.Lexer(str);
            
            token = lexer.nextToken();
            testCase.verifyClass(token,"TemplateEngine.Token");
            testCase.verifyEqual(token.type,TemplateEngine.TokenTypes.LOOP);
            testCase.verifyEqual(token.data.element,"one");
            testCase.verifyEqual(token.data.array,"many");
            testCase.verifyEqual(token.length,21);
            testCase.verifyEmpty(lexer.nextToken());
            
        end
        
        function LexerEndOnlyToken(testCase)
            str = "{{#  end }}";
            lexer = TemplateEngine.Lexer(str);
            
            token = lexer.nextToken();
            testCase.verifyClass(token,"TemplateEngine.Token");
            testCase.verifyEqual(token.type,TemplateEngine.TokenTypes.END);            
            testCase.verifyEqual(token.length,11);
            testCase.verifyEmpty(lexer.nextToken());
            
        end
        
        function LexerCondOnlyToken(testCase)
            str = "{{# if true }}";
            lexer = TemplateEngine.Lexer(str);
            
            token = lexer.nextToken();
            testCase.verifyClass(token,"TemplateEngine.Token");
            testCase.verifyEqual(token.type,TemplateEngine.TokenTypes.CONDITIONAL);
            testCase.verifyEqual(token.data.condition,"true");
            testCase.verifyEqual(token.length,14);
            testCase.verifyEmpty(lexer.nextToken());
            
        end
        
        
    end
end

