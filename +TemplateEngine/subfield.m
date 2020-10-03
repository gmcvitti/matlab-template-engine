function value = subfield(S,FIELD)
%ISSUBFIELD Determine if FIELD is valid in struct S
%   Determine if the specified FIELD or nested FIELD is present in the
%   given structure.
%
%   A.b.c.d = 1;
%   issubfield(A,"b.c.d")       % TRUE
%   issubfield(A,"b")           % TRUE
%   issubfield(A,"b.c.d.e")     % FALSE
%   issubfield(A,"f")           % FALSE
arguments
    S (1,1) struct
    FIELD (1,1) string
end

if ~TemplateEngine.issubfield(S,FIELD)
    error("Not subfield");
    
end

SUBFIELDS = strsplit(FIELD,'.');
value = S;
for SUBFIELD = SUBFIELDS
    value = value.(SUBFIELD);
end

end