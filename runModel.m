% Returns a simlen x 7 matrix containing time values, 
function res = runModel(stocks, variables, doseCPT, DoseRate, simlen)
clf;
hold on;
stock_vals = zeros(simlen,7);
dilution = 6.125e-3; % Conversion from irinotecan dosage to amount of CPT-11
%stocks = [.1 0 0 0 0 0]; % Chemical compounds concentraion in order of CPT_11, SN_38, SN_38G, APC, NPC, and Excreted Material
%CPT_11, SN_38, SN_38G, APC, NPC
%CPT has to be non zero

%variables = [10 3 35 .014583333]; %Enzyme concentration and excretion rate in order of Esterase, CYP3A, UGT, Excr. rate
%Esterase, CYP3A, UGT, Excr. rate

%doseCPT = 360; %mg

%simlen = 300; %hours

for i = 1:simlen
    if (mod(i-1,DoseRate) == 0)
        stocks = Update(doseCPT*dilution, variables, stocks);
    else
        stocks = Update(0, variables, stocks);
    end
    stock_vals(i,1) = i;
    for j=2:7
        stock_vals(i,j) = stocks(j-1);
    end
end
res = stock_vals;
end