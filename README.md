# Pearson-3-Probability-Curve
Analyze and draw Pearson 3 probability curve, using matplotlib, scipy and numpy

使用Python以及matplotlib，scipy和numpy库对数据进行简要的P3曲线分析，
能够计算数据的数学期望EX，变差系数Cv和偏态系数Cs。

## p3Stat()
p3Stat(data)用于统计数据参数，返回数学期望EX，变差系数Cv和偏态系数Cs

## p3ProbScatter()
p3ProbScatter(data, yLogScale=False, probLeftLim=0.1, probRightLim=99.9, show=False)

该函数用于绘制水文数据的散点图
1. data                输入的原始水文数据，建议使用np.array类
2. yLogScale=False     y轴是否对数化显示，默认关闭
3. probLeftLim=0.1     x轴，概率起始点，默认为0.1%
4. probRightLim=99.9   x轴，概率结束点，默认为99.9%
5. show=False          是否立即显示，默认不显示
6. fig， ax            返回图形和坐标轴对象

## p3ProbPlot(Ex, Cv, Cs, show=False)
p3ProbPlot(Ex, Cv, Cs, show=False)

该函数用于绘制P3曲线
1. Ex          曲线的数学期望
2. Cv          曲线的变差系数
3. Cs          曲线的偏态系数
4. show=False  是否显示图像，默认不显示
