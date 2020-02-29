function HessianProbabilityGrid(dataArray, estCv, estCsDivCv)
    % 控制Y轴坐标上限
    MAX_Y = max(dataArray);
    MAX_Y = ceil(MAX_Y / 10^floor(log10(MAX_Y))) * 10^floor(log10(MAX_Y));

    % 定义坐标函数
    axisProb = [0.001, 0.01:0.01:0.1, 0.2:0.1:1, 1.2:0.2:2, 3:1:20, 22:2:80, 81:1:98, 98.2:0.2:99, 99.1:0.1:99.9]; %横坐标的值
    axisX = norminv(axisProb / 100, 0, 1);
    axisX = axisX - axisX(1);

    % 纵向划分线
    xLabel = [0.001 0.01 0.1 0.2 0.333 0.5 1 2 3 5 10 20 25 30 40 50 60 70 75 80 85 90 95 97 99 99.9 100];
    xTick = norminv(xLabel / 100, 0, 1);
    xTick = xTick - xTick(1);

    for i = 1:1:size(xTick, 2)
        line([xTick(i), xTick(i)], [0, MAX_Y]);
    end

    % 横向划分线
    for i = MAX_Y / 10:MAX_Y / 10:MAX_Y
        line([0, axisX(end)], [i, i]);
    end

    % 绘制坐标格纸
    h = findobj('type', 'axes');
    % 去掉x,y轴的刻度，并设置x,y轴的上下界
    set(h, 'xtick', [], 'ytick', [], 'xlim', [0, axisX(end)], 'ylim', [0, MAX_Y]);
    % 横坐标的值
    xLabel = [0.001 0.01 0.1 0.2 0.333 0.5 1 2 3 5 10 20 25 30 40 50 60 70 75 80 85 90 95 97 99 99.9 100];
    xTick = norminv(xLabel / 100, 0, 1);
    xTick = xTick - xTick(1);
    % 重新设置坐标轴的刻度
    set(h, 'Xtick', xTick);
    set(h, 'XticklabeL', {0.001 0.01 0.1 0.2 0.3 0.5 1 2 3 5 10 20 25 30 40 50 60 70 75 80 85 90 95 97 99 99.9 100});
    set(h, 'Ytick', 0:MAX_Y / 10:MAX_Y);
    set(h, 'YticklabeL', {0:MAX_Y / 10:MAX_Y});
    % 对x,y轴进行标注
    xlabel('P(％)');
    ylabel('Qm(m^3/s)');
    hold on;

    % 原始数据处理
    sortedData = sort(dataArray, 'descend'); % 排序后的数据
    EX = mean(dataArray);
    expProb = [1:length(sortedData)] / (length(sortedData) + 1);
    % 实际数据横坐标的值
    dataX = norminv(expProb, 0, 1);
    dataX = dataX - norminv(0.00001, 0, 1);
    % 绘制实际数据散点图
    scatter(dataX, sortedData, 'k');
    hold on;

    % 绘制理论曲线
    estCs = estCsDivCv * estCv;
    % 估计的P-III型曲线参数
    P3_alpha = 4 / estCs^2;
    P3_beta = 2 / (EX * estCv * estCs);
    P3_a0 = EX * (1 - 2 * estCv / estCs);
    % 估计的gamma函数参数
    gamma_alpha = P3_alpha;
    gamma_beta = 1 / P3_beta;
    theoryY = gaminv((100 - xLabel) / 100, gamma_alpha, gamma_beta) + P3_a0; % 注意超过制概率和不及制概率
    plot(xTick, theoryY, 'k');
    hold on;
    % grid on;
end
