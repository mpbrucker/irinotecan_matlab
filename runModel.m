function res = runModel(stocks, variables, doseCPT, DoseRate, simlen)
clf;
hold on;
%stocks = [.1 0 0 0 0 0]; % Chemical compounds concentraion in order of CPT_11, SN_38, SN_38G, APC, NPC, and Excreted Material
%CPT_11, SN_38, SN_38G, APC, NPC
%CPT has to be non zero

%variables = [10 3 35 .014583333]; %Enzyme concentration and excretion rate in order of Esterase, CYP3A, UGT, Excr. rate
%Esterase, CYP3A, UGT, Excr. rate

%doseCPT = 360; %mg

%simlen = 300; %hours

for i = 1:simlen
    if isInteger((i-1)/DoseRate)
        stocks = Update(doseCPT, variables, stocks)
    else
        stocks = Update(0, variables, stocks)
    end
    plot(i, stocks(1), 'ko', 'MarkerSize', 6)
    plot(i, stocks(2), 'ro', 'MarkerSize', 6)
    plot(i, stocks(3), 'bo', 'MarkerSize', 6)
    plot(i, stocks(4), 'go', 'MarkerSize', 6)
    plot(i, stocks(5), 'mo', 'MarkerSize', 6)
    %plot(i, stocks(6), 'co', 'MarkerSize', 6)
end
res = 0;
end