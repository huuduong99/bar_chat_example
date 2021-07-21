import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class FLChartExample extends StatefulWidget {
  const FLChartExample({Key? key}) : super(key: key);

  @override
  _FLChartExampleState createState() => _FLChartExampleState();
}

class _FLChartExampleState extends State<FLChartExample> {
  final Color leftBarColor = Colors.blue;
  final Color rightBarColor = Colors.green;
  final double width = 15;

  late List<BarChartGroupData> rawBarGroups;
  late List<BarChartGroupData> showingBarGroups;

  int touchedGroupIndex = -1;

  @override
  void initState() {
    super.initState();
    final barGroup1 = makeGroupData(0, 5, 12);
    final barGroup2 = makeGroupData(1, 16, 12);
    final barGroup3 = makeGroupData(2, 18, 5);
    final barGroup4 = makeGroupData(3, 20, 16);
    final barGroup5 = makeGroupData(4, 17, 6);
    final barGroup6 = makeGroupData(5, 19, 1.5);
    final barGroup7 = makeGroupData(6, 10, 1.5);

    final items = [
      barGroup1,
      barGroup2,
      barGroup3,
      barGroup4,
      barGroup5,
      barGroup6,
      barGroup7,
    ];

    rawBarGroups = items;

    showingBarGroups = rawBarGroups;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: _buildBody(),
    );
  }

  PreferredSizeWidget _buildAppBar() {
    return AppBar(
      backgroundColor: const Color(0xFF28A745),
      title: const Text('Tin nhắn, bình luận mới'),
    );
  }

  Widget _buildBody() {
    return AspectRatio(
      aspectRatio: 1,
      child: Card(
        elevation: 0,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
        color: Colors.white,
        child: Padding(
          padding: const EdgeInsets.only(left: 6),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.start,
            mainAxisSize: MainAxisSize.max,
            children: <Widget>[
              _buildTitleChart(),
              const SizedBox(
                height: 38,
              ),
              _buildBodyChart(),
              const SizedBox(
                height: 12,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTitleChart() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.start,
      children: const [
        CircleAvatar(
          radius: 20,
          backgroundColor: Colors.green,
          child: Icon(
            Icons.message,
            size: 20,
          ),
        ),
        SizedBox(
          width: 10,
        ),
        Text(
          'Tin nhắn, bình luận mới',
          style: TextStyle(color: Colors.black, fontSize: 20),
        ),
      ],
    );
  }

  Widget _buildBodyChart() {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: BarChart(
          BarChartData(
            maxY: 20,
            gridData: FlGridData(
              show: true,
              checkToShowHorizontalLine: (value) => value % 4 == 0,
              drawVerticalLine: true,

              getDrawingHorizontalLine: (value) => FlLine(
                color: const Color(0xffe7e8ec),
                strokeWidth: 1,
              ),
            ),
            barTouchData: BarTouchData(
              enabled: true,
              touchTooltipData: BarTouchTooltipData(
                tooltipBgColor: Colors.grey,
                getTooltipItem: _getTooltipItem,
              ),
              touchCallback: _touchCallback,
            ),
            titlesData: FlTitlesData(
              show: true,
              leftTitles: _buildLeftTitles(),
              bottomTitles: _buildBottomTitles(),
            ),
            borderData: FlBorderData(
              show: false,
            ),
            barGroups: showingBarGroups,
          ),
        ),
      ),
    );
  }

  SideTitles _buildLeftTitles() {
    return SideTitles(
      showTitles: true,
      getTextStyles: (value) => const TextStyle(
          color: Color(0xff7589a2), fontWeight: FontWeight.bold, fontSize: 14),
      margin: 20,
      reservedSize: 14,
      getTitles: (value) {
        if (value == 0) {
          return '0K';
        }
        if (value == 4) {
          return '4K';
        } else if (value == 8) {
          return '8K';
        } else if (value == 12) {
          return '12K';
        }
        else if (value == 16) {
          return '16K';
        } else if (value == 20) {
          return '20K';
        } else {
          return '';
        }
      },
    );
  }

  SideTitles _buildBottomTitles() {
    return SideTitles(
      showTitles: true,
      getTextStyles: (value) => const TextStyle(
          color: Color(0xff7589a2), fontWeight: FontWeight.bold, fontSize: 14),
      margin: 20,
      getTitles: (double value) {
        switch (value.toInt()) {
          case 0:
            return '11/7';
          case 1:
            return '12/7';
          case 2:
            return '13/7';
          case 3:
            return '14/7';
          case 4:
            return '15/7';
          case 5:
            return '16/7';
          case 6:
            return '17/7';
          default:
            return '';
        }
      },
    );
  }

  BarTooltipItem _getTooltipItem(BarChartGroupData group, int groupIndex,
      BarChartRodData rod, int rodIndex) {
    String weekDay;
    switch (group.x.toInt()) {
      case 0:
        weekDay = '11/7';
        break;
      case 1:
        weekDay = '12/7';
        break;
      case 2:
        weekDay = '13/7';
        break;
      case 3:
        weekDay = '14/7';
        break;
      case 4:
        weekDay = '15/7';
        break;
      case 5:
        weekDay = '16/7';
        break;
      case 6:
        weekDay = '17/7';
        break;
      default:
        throw Error();
    }
    return BarTooltipItem(
      weekDay + '\n',
      const TextStyle(
        color: Colors.white,
        fontWeight: FontWeight.bold,
        fontSize: 18,
      ),
      children: <TextSpan>[
        TextSpan(
          text: (rod.y - 1).toString(),
          style: const TextStyle(
            color: Colors.yellow,
            fontSize: 16,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }

  void _touchCallback(BarTouchResponse response) {
    if (response.spot == null) {
      setState(() {
        touchedGroupIndex = -1;
        showingBarGroups = List.of(rawBarGroups);
      });
      return;
    }
    touchedGroupIndex = response.spot?.touchedBarGroupIndex ?? 0;

    setState(() {
      if (response.touchInput is PointerExitEvent ||
          response.touchInput is PointerUpEvent) {
        touchedGroupIndex = -1;
        showingBarGroups = List.of(rawBarGroups);
      } else {
        showingBarGroups = List.of(rawBarGroups);
        if (touchedGroupIndex != -1) {
          var sum = 0.0;
          for (final rod in showingBarGroups[touchedGroupIndex].barRods) {
            sum += rod.y;
          }
          final avg = sum / showingBarGroups[touchedGroupIndex].barRods.length;

          showingBarGroups[touchedGroupIndex] =
              showingBarGroups[touchedGroupIndex].copyWith(
            barRods: showingBarGroups[touchedGroupIndex].barRods.map((rod) {
              return rod.copyWith(y: avg);
            }).toList(),
          );
        }
      }
    });
  }

  BarChartGroupData makeGroupData(int x, double y1, double y2) {
    return BarChartGroupData(barsSpace: 4, x: x, barRods: [
      BarChartRodData(
        y: y1,
        colors: [leftBarColor],
        width: width,
        borderRadius: BorderRadius.zero,
      ),
      BarChartRodData(
        y: y2,
        colors: [rightBarColor],
        width: width,
        borderRadius: BorderRadius.zero,
      ),
    ]);
  }
}
