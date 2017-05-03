function b=Bit_set(k,n)
b=0;
for i=1:length(k)
b=bitset(b,n+1-k(i),1);
end
b=dec2bin(b,n);
        
    
     