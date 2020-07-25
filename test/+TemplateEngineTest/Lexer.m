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
        
        function LexerValueAndTextToken(testCase)
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
        
        
        
        
    end
end

