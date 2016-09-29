function vary_outputs()
input_stocks = [1e-9 0 0 0 0 0]; % Chemical compounds concentraion in order of CPT_11, SN_38, SN_38G, APC, NPC, and Excreted Material
%CPT_11, SN_38, SN_38G, APC, NPC
%CPT has to be non zero
input_variables = [2e-3 1 1 .03]; %Enzyme concentration and excretion rate in order of Esterase, CYP3A, UGT, Excr. rate
%Esterase, CYP3A, UGT, Excr. rate
input_dose = .240; %mg
dose_rate = 240;
simlen = 240; %hours
%SN38_out = zeros(1,10);
clf;
hold on
outputs = runModel(input_stocks,input_variables,input_dose,dose_rate,simlen);
Times = transpose(outputs(:,1));
CPT_11 = transpose(outputs(:,2)) ./ 586.678;
SN_38 = transpose(outputs(:,3)) ./ 392.404;
SN_38G = transpose(outputs(:,4)) ./ 568.529;
APC = transpose(outputs(:,5)) ./ 311.646;
NPC = transpose(outputs(:,6)) ./ 518.56;
excr = transpose(outputs(:,7));

total_SN = sum(SN_38);
total_CPT = sum(CPT_11);
total_APC = sum(APC);
total_NPC = sum(NPC);

total_toxicity = total_SN + (1/250)*(total_CPT + total_APC + total_NPC)
plot(Times,CPT_11,'m');
plot(Times,SN_38,'r');
plot(Times,SN_38G,'b');
plot(Times,APC,'g');
plot(Times,NPC,'c');
%plot(Times,excr,'k');
xlabel('Time (hrs)');
ylabel('Amount in body (g)');
title('Concentration of CPT-11 components in the body over time');

legend('CPT-11 Concentration','SN-38 Concentration','SN-38G Concentration','APC Concentration','NPC Concentration','Excreted Material');
%for i=0:9
%    input_variables(1) = i;
%    outputs = runModel(input_stocks,input_variables,input_dose,dose_rate,simlen);
%        
%    SN38 = transpose(outputs(:,3));
%    SN38_out(i+1) = max(SN38);
%end

%plot(SN38_out);
end

    