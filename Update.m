function [ res ] = Update( doseCPT, variables, stocks)
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here


stockflows(1) = -stocks(1)*variables(2)*.0027 *(1-(stocks(4)/stocks(1))) - stocks(1) * (variables(1)*.0027) - stocks(1)*variables(4);

stockflows(4) = stocks(1)*variables(2)*.0027 *(1-(stocks(4)/stocks(1))) - stocks(4)*variables(4);

stockflows(5) = stocks(1)*(variables(2)*.0027) - stocks(5)*(variables(1)*.0027) - stocks(5)*variables(4);

stockflows(2) = stocks(1) * (variables(1)*.0027) + stocks(5)*(variables(1)*.0027) - variables(3)*(stocks(2)*.0027) - stocks(2)*variables(4);

stockflows(3) = variables(3)*(stocks(2)*.0027) - stocks(3)*variables(4);

stockflows(6) = stocks(1)*variables(4) + stocks(4)*variables(4) + stocks(5)*variables(4) + stocks(2)*variables(4) + stocks(3)*variables(4);

for i = 1:length(stocks)
    if i == 1
        stocks(i) = doseCPT + stocks(i) +stockflows(i);
    else
        stocks(i) = stocks(i) +stockflows(i);
    end
end

res = stocks

end

