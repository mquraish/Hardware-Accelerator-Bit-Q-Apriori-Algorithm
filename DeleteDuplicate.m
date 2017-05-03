function [A B]=DeleteDuplicate(x)

x1 = cellfun(@(y)y(:)', x, 'UniformOutput',0);
x2 = cell2mat(x1);
x3 = unique(x2,'rows');
x4 = num2cell(x3,1);
A=x4{1};
B=x4{2};

end