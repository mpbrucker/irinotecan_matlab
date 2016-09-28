function [ res ] = Update(doseCPT, variables, stocks)

% CYP3A and UGT should be binary values - 0 or 1; this converts their
% presence into a rate based on experimental data.
CYP3A_rate = 2.7e-3;
UGT_rate = .1;
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here
%stocks = [0 0 0 0 0 0]; % Chemical compounds concentraion in order of CPT_11, SN_38, SN_38G, APC, NPC, and Excreted Material
%CPT_11, SN_38, SN_38G, APC, NPC
%CPT has to be non zero

%variables = [10 3 35 .014583333]; %Enzyme concentration and excretion rate in order of Esterase, CYP3A, UGT, Excr. rate
%Esterase, CYP3A, UGT, Excr. rate

%d(CPT)/dt = doseCPT - (CPT*CYP3A Rate*(1-(APC/CPT11))-(CPT*Esterase)-(CPT*Excretion Rate)
%Peak CPT-11 should 1.47 mg
stockflows(1) = doseCPT - (stocks(1)*(variables(2)*CYP3A_rate)*(1-(stocks(4)/stocks(1)))) - (stocks(1) * variables(1)) - (stocks(1)*variables(4));

%d(APC)/dt = (CPT*CYP3A Rate*(1-(APC/CPT11)) - (APC*Excretion Rate)
%Peak APC should be 77.9 ug
stockflows(4) = (stocks(1)*(variables(2)*CYP3A_rate)*(1-(stocks(4)/stocks(1)))) - stocks(4)*variables(4);

%d(NPC)/dt = (CPT*CYP3A Rate) - (NPC*Esterase) - (NPC*Excretion Rate)
% Peak NPC should be 29.6 ug
stockflows(5) = stocks(1)*(variables(2)*CYP3A_rate) - (stocks(5)*variables(1)*25) - (stocks(5)*variables(4));

%d(SN-38)/dt = (CPT*CE) + (NPC*CE) - (SN-38*UGT Rate) - (SN-38*Excretion Rate)
% Peak SN-38 should be 19.6 ug
stockflows(2) = (stocks(1) * variables(1)) + (stocks(5)*variables(1)) - (variables(3)*stocks(2)*UGT_rate) - (stocks(2)*variables(4));

% d(SN-38G)/dt = (SN-38*UGT Rate) - (SN-38G*Excretion Rate)
% Peak SN-38G should be .284 mg
stockflows(3) = (variables(3)*stocks(2)*UGT_rate*2) - (stocks(3)*variables(4));

% d(Excreted Material)/dt = (All stocks*Excretion Rate)
stockflows(6) = (stocks(1)+stocks(2)+stocks(3)+stocks(4)+stocks(5))*variables(4);

for i = 1:length(stocks)
    stocks(i) = stocks(i) + stockflows(i);
end

res = stocks;

end

