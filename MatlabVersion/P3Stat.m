function [EX, Cv, Cs] = P3Stat(dataArray)
    % �������ݵĸ������
    EX = mean(dataArray);
    K = dataArray / EX;
    Cv = sqrt(sum((K - 1).^2) / (length(dataArray) - 1));
    Cs = sum((K - 1).^3) / ((length(dataArray) - 3) * Cv^3);
end
