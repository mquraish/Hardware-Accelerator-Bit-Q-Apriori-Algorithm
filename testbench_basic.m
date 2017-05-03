%% 
clc;
clear;

n=10;  %number of transactions, also number of bits

%read excel file Bit_Q.xlsx to get data

[~,patient] = xlsread('Bit_Q.xlsx', 'B2:B11');
QR = xlsread('Bit_Q.xlsx', 'C2:C11')';
RT= xlsread('Bit_Q.xlsx', 'D2:D11');


%find out the transactions where certain attributes occured
k_p1=contains(patient,'P1');
k_p2=contains(patient,'P2');
k_QR_low = find(QR<0.39);
k_QR_med = find(QR>=0.39 & QR<0.61);
k_QR_high = find(QR>=0.61);
k_RT_1=find(RT<3.9);
k_RT_2=find(RT>=3.9 & RT<5);
k_RT_3=find(RT>=5 & RT<6);
k_RT_4=find(RT>=6);

Bs = cell(1,9);
%calculate the bitset of the attributes using the Bit_set funtion
bitset_p1=Bit_set(k_p1,n);
bitset_p2=Bit_set(k_p2,n);

bitset_QR_low=Bit_set(k_QR_low,n);
bitset_QR_med=Bit_set(k_QR_med,n);
bitset_QR_high=Bit_set(k_QR_high,n);

bitset_RT_1=Bit_set(k_RT_1,n);
bitset_RT_2=Bit_set(k_RT_2,n);
bitset_RT_3=Bit_set(k_RT_3,n);
bitset_RT_4=Bit_set(k_RT_4,n);

%original bitset for all attributes
Bs = {bitset_p1; bitset_p2; bitset_QR_low; bitset_QR_med; bitset_QR_high; bitset_RT_1;bitset_RT_2;bitset_RT_3;bitset_RT_4};

%binary bits are hard coded
Bb = {'0100000';'1000000';'0001000';'0010000';'0011000';'0000001';'0000010';'0000011';'0000100'};

%for basic architecture we constrain the data to 3
Bs = {bitset_p1;bitset_QR_low; bitset_RT_4};
Bb = {'0100000';'1000000';'0001000'};

%minimum support count
count=2;

%converting input to deciamal as matlab binary are character vectors
t=[0:2]'*10/1e6;
for i=1:numel(Bs)
    Bs1(i)=bin2dec(Bs{i});
end
Bs1=Bs1';

At.time = t;
At.signals.values = Bs1;
At.signals.dimensions = 1;

%%

BlockName = 'Basic_Architecture';
set_param([BlockName '/From Workspace'],'VariableName','At');
set_param([BlockName '/To Workspace'],'VariableName','yt');
set_param([BlockName '/To Workspace'],'SaveFormat',['Structure With Time']);


%%
% verification of output.
[L, P]= Bit_Q_Apriori(Bs, Bb, count,n);
Algorithm_output=bin2dec(L);

%As hardware output has zeroes and other in between values, we cannot
%compare directly. check the yt from workspace to match the outputs.
