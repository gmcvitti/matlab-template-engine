function tf = issubfield(S,FIELD)
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
SUBFIELD = strsplit(FIELD,'.');
if numel(SUBFIELD) == 1
    tf = isfield(S,FIELD);
    return;    
end
tf = true;
for i = 2:numel(SUBFIELD)    
    S = S.(SUBFIELD(i-1));
    if ~isfield(S,SUBFIELD(i))
        tf = false;
        break;
    end
end
end