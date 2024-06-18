


import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import '../../Models/TestResultModel.dart';
class DepresionGraph extends StatefulWidget {
   List<TestResultModel> depressionhistory ;
  DepresionGraph({required this.depressionhistory});
  @override
  _DepresionGraphState createState() => _DepresionGraphState();
}

class _DepresionGraphState extends State<DepresionGraph> {
  late TooltipBehavior _tooltipBehavior;

  @override
  void initState() {
    _tooltipBehavior = TooltipBehavior(
      color: Colors.white,
      enable: true,
      // Using builder to create custom content for tooltips
      builder: (dynamic data, dynamic point, dynamic series, int pointIndex, int seriesIndex) 
      {
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text('${data.level_of_depression}'),
        );
      },
    );
   
    super.initState();
  }

  @override
  Widget build(BuildContext context) 
  {
     if (widget.depressionhistory.length == 1) {
      final singlePoint = widget.depressionhistory.first;
      widget.depressionhistory.add(TestResultModel(timestamp: singlePoint.timestamp, total_score: singlePoint.total_score,level_of_depression: singlePoint.level_of_depression)); // Add dummy second point
    }
    return Container(
      height: 400,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30),
        color: Colors.grey.withOpacity(.1),
      ),
      child: SfCartesianChart(
        primaryXAxis: CategoryAxis(),
        title: ChartTitle(text: 'Depression test'),
        tooltipBehavior: _tooltipBehavior,
        series: <LineSeries<TestResultModel, String>>[
          LineSeries<TestResultModel, String>(
            color: Color(0xff9A89FF).withOpacity(.7),
            width: 4,
            dataSource: widget.depressionhistory,
            xValueMapper: (TestResultModel depressionhistory, _) => depressionhistory.timestamp!,
            yValueMapper: (TestResultModel depressionhistory, _) => depressionhistory.total_score,
            dataLabelMapper: (TestResultModel depressionhistory, _) => depressionhistory.level_of_depression
          )
        ],
      ),
    );
  }
}
