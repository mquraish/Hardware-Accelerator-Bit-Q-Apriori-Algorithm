function [L, P]=Bit_Q_Apriori(Bs, Bb, count,n)

for i=1:numel(Bs)
        Count(i)=OneCount(Bs{i}); %done in hardware
    end
    L{1}=[];
    P{1}=[];
    m=1;
    for i=1:numel(Count)
        if Count(i)>=count
        L{1}{m} = Bs{i};  % generate 1 frequent bitset
        P{1}{m} = Bb{i};  % generate 1 frequent binary bits
        m=m+1;
        end
    end    
 k=2;
 
 while numel(L{k-1})>1
    p=0; 
    Ck=[];
    for i=1:numel(L{k-1})
         for j=1:numel(L{k-1})
             p=p+1;
             if i==j
                 C{k}{p}=0;
                 CB{k}{p}=0;
             else
             C{k}{p}=(bitand(bin2dec(L{k-1}(j)), bin2dec(L{k-1}(i)))); %new bitset = and of previous bitsets
             CB{k}{p}=(bitor(bin2dec(P{k-1}(j)), bin2dec(P{k-1}(i)))); %new binary bits = or of previous binary bits
             end
         end 
    end

     Ck = cell2mat(C{k});
     CBk =cell2mat(CB{k});
     for i=1:length(Ck)
         merged{k}{i,1}=[Ck(i) CBk(i)];
     end
     
[Ck,CBk]=DeleteDuplicate(merged{k});     
    
     m=1;
     flag=0;
     for r=1:length(Ck)
         if OneCount(dec2bin(Ck(r),n))>=count
             L{k}{m}=dec2bin(Ck(r),n);
             P{k}{m}=dec2bin(CBk(r),7);
             m=m+1;
             flag=1;
         end      
     end
   if flag==0
      break;
   end
    k=k+1;
end 
L=L{k-1};
P=P{k-1};