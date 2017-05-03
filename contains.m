function b=contains(a,str)
b=[];
for i=1:numel(a)
    if strcmp(a(i),str)==1
        b=[b;i];
        
    end 
end