function vary_outputs()
input_stocks = [1e-9 0 0 0 0 0]; % Chemical compounds concentraion in order of CPT_11, SN_38, SN_38G, APC, NPC, and Excreted Material
%CPT_11, SN_38, SN_38G, APC, NPC
%CPT has to be non zero
input_variables = [2e-3 1 1 .014583333]; %Enzyme concentration and excretion rate in order of Esterase, CYP3A, UGT, Excr. rate
%Esterase, CYP3A, UGT, Excr. rate
input_dose = .240; %mg
dose_rate = 240;
simlen = 240; %hours
%SN38_out = zeros(1,10);
clf;
hold on
figure(1)
init_val = .001;
max_vals = zeros(1,10);
for i = 1:10
    input_variables(1) = init_val;
    init_val = init_val + .001;
    outputs = runModel(input_stocks,input_variables,input_dose,dose_rate,simlen);
    Times = transpose(outputs(:,1));
    CPT_11 = transpose(outputs(:,2));
    SN_38 = transpose(outputs(:,3));
    SN_38G = transpose(outputs(:,4));
    APC = transpose(outputs(:,5));
    NPC = transpose(outputs(:,6));
    excr = transpose(outputs(:,7));

    max_CPT = max(CPT_11);
    max_SN = max(SN_38);
    max_APC = max(APC);
    max_NPC = max(NPC);

    total_toxicity = max_SN + (1/250)*(max_CPT+max_APC+max_NPC)
    max_vals(i) = total_toxicity;
end

plot(max_vals);

%figure(2);
%plot(Times,CPT_11,'m');
%plot(Times,SN_38,'r');
%plot(Times,SN_38G,'b');
%plot(Times,APC,'g');
%plot(Times,NPC,'c');
%plot(Times,excr,'k');

%for i=0:9
%    input_variables(1) = i;
%    outputs = runModel(input_stocks,input_variables,input_dose,dose_rate,simlen);
%        
%    SN38 = transpose(outputs(:,3));
%    SN38_out(i+1) = max(SN38);
%end

%plot(SN38_out);
end

    