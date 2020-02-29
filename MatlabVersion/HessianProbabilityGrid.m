function HessianProbabilityGrid(dataArray, estCv, estCsDivCv)
    % ����Y����������
    MAX_Y = max(dataArray);
    MAX_Y = ceil(MAX_Y / 10^floor(log10(MAX_Y))) * 10^floor(log10(MAX_Y));

    % �������꺯��
    axisProb = [0.001, 0.01:0.01:0.1, 0.2:0.1:1, 1.2:0.2:2, 3:1:20, 22:2:80, 81:1:98, 98.2:0.2:99, 99.1:0.1:99.9]; %�������ֵ
    axisX = norminv(axisProb / 100, 0, 1);
    axisX = axisX - axisX(1);

    % ���򻮷���
    xLabel = [0.001 0.01 0.1 0.2 0.333 0.5 1 2 3 5 10 20 25 30 40 50 60 70 75 80 85 90 95 97 99 99.9 100];
    xTick = norminv(xLabel / 100, 0, 1);
    xTick = xTick - xTick(1);

    for i = 1:1:size(xTick, 2)
        line([xTick(i), xTick(i)], [0, MAX_Y]);
    end

    % ���򻮷���
    for i = MAX_Y / 10:MAX_Y / 10:MAX_Y
        line([0, axisX(end)], [i, i]);
    end

    % ���������ֽ
    h = findobj('type', 'axes');
    % ȥ��x,y��Ŀ̶ȣ�������x,y������½�
    set(h, 'xtick', [], 'ytick', [], 'xlim', [0, axisX(end)], 'ylim', [0, MAX_Y]);
    % �������ֵ
    xLabel = [0.001 0.01 0.1 0.2 0.333 0.5 1 2 3 5 10 20 25 30 40 50 60 70 75 80 85 90 95 97 99 99.9 100];
    xTick = norminv(xLabel / 100, 0, 1);
    xTick = xTick - xTick(1);
    % ��������������Ŀ̶�
    set(h, 'Xtick', xTick);
    set(h, 'XticklabeL', {0.001 0.01 0.1 0.2 0.3 0.5 1 2 3 5 10 20 25 30 40 50 60 70 75 80 85 90 95 97 99 99.9 100});
    set(h, 'Ytick', 0:MAX_Y / 10:MAX_Y);
    set(h, 'YticklabeL', {0:MAX_Y / 10:MAX_Y});
    % ��x,y����б�ע
    xlabel('P(��)');
    ylabel('Qm(m^3/s)');
    hold on;

    % ԭʼ���ݴ���
    sortedData = sort(dataArray, 'descend'); % ����������
    EX = mean(dataArray);
    expProb = [1:length(sortedData)] / (length(sortedData) + 1);
    % ʵ�����ݺ������ֵ
    dataX = norminv(expProb, 0, 1);
    dataX = dataX - norminv(0.00001, 0, 1);
    % ����ʵ������ɢ��ͼ
    scatter(dataX, sortedData, 'k');
    hold on;

    % ������������
    estCs = estCsDivCv * estCv;
    % ���Ƶ�P-III�����߲���
    P3_alpha = 4 / estCs^2;
    P3_beta = 2 / (EX * estCv * estCs);
    P3_a0 = EX * (1 - 2 * estCv / estCs);
    % ���Ƶ�gamma��������
    gamma_alpha = P3_alpha;
    gamma_beta = 1 / P3_beta;
    theoryY = gaminv((100 - xLabel) / 100, gamma_alpha, gamma_beta) + P3_a0; % ע�ⳬ���Ƹ��ʺͲ����Ƹ���
    plot(xTick, theoryY, 'k');
    hold on;
    % grid on;
end
