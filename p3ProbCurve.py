import matplotlib.pyplot as plt
import numpy as np
import probscale
import math

from scipy.stats import pearson3

plt.rcParams['font.sans-serif'] = ['Sarasa Gothic CL']


def p3ProbScatter(data, yLogScale=False, probLeftLim=0.1, probRightLim=99.9, show=False):
    """
    该函数用于绘制水文数据的散点图
    data                输入的原始水文数据，建议使用np.array类
    yLogScale=False     y轴是否对数化显示，默认关闭
    probLeftLim=0.1     x轴，概率起始点，默认为0.1%
    probRightLim=99.9   x轴，概率结束点，默认为99.9%
    show=False          是否立即显示，默认不显示
    fig， ax            返回图形和坐标轴对象
    """

    # 创建单幅
    fig, ax = plt.subplots()

    # 自适应Y轴上限，最高位向上取整
    MAX_Y = max(data)
    MAX_Y = math.ceil(MAX_Y / 10 ** math.floor(math.log10(MAX_Y))
                      ) * 10 ** math.floor(math.log10(MAX_Y))

    # 设置y轴的范围，以及是否对数化显示
    ax.set_ylim(0, MAX_Y)
    if yLogScale == True:
        ax.set_yscale('log')

    # 设置x轴的范围，参数应该直接为百分数
    # 比如50%，直接传入50
    ax.set_xlim(probLeftLim, probRightLim)
    ax.set_xscale('prob')

    # 对数据进行降序排序，并计算经验频率
    sortedData = np.sort(data)[::-1]
    expProb = np.arange(1, len(sortedData) + 1) / (len(sortedData)+1) * 100

    # 绘制散点图
    plt.scatter(expProb, sortedData, label='经验概率点')

    if show == True:
        plt.show()

    # 返回图像，轴
    return fig, ax


def p3Stat(data):
    """
    该函数用于统计数据的数学期望Ex，变差系数Cv，偏态系数Cs
    """

    # 数学期望
    Ex = np.average(data)
    # 模比系数
    K = data / Ex
    # 变差系数
    Cv = np.sqrt(np.sum((K-1)**2) / (len(data) - 1))
    # 偏态系数
    Cs = np.sum((K - 1)**3)/((len(data) - 3) * Cv**3)

    return Ex, Cv, Cs


def p3ProbPlot(Ex, Cv, Cs, show=False):
    """
    该函数用于绘制P3曲线
    Ex          曲线的数学期望
    Cv          曲线的变差系数
    Cs          曲线的偏态系数
    show=False  是否显示图像，默认不显示
    """

    # 获取理论曲线的控制点
    x = np.linspace(0.1, 99.9, 1000)
    theoryY = (pearson3.ppf(1 - x / 100, Cs) * Cv + 1) * Ex

    # 绘制理论曲线
    plt.plot(x, theoryY, 'r-', lw=2, label='理论频率曲线')

    plt.legend()

    if show == True:
        plt.show()


# 测试例子
data = np.array([778, 752, 709, 697, 650, 649, 644, 642, 623, 616, 612, 605, 575,
                 573, 558, 551, 541, 526, 526, 521, 519, 510, 508, 506, 494, 486,
                 480, 477, 472, 461, 442, 420, 415, 410, 398, 395, 382, 379, 376,
                 370, 368, 359, 350, 349, 341, 337, 336, 315, 315, 292])

statResult = p3Stat(data)
print(statResult)
p3ProbScatter(data)
p3ProbPlot(statResult[0], statResult[1], 2 * statResult[1])
plt.grid(True)
plt.show()
