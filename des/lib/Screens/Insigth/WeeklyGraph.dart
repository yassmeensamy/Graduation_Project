import 'package:des/Models/WeeklyHistory.dart';
import 'package:des/Models/WeeklyModel.dart';
import 'package:des/cubit/cubit/cubit/weekly_cubit.dart';
import 'package:des/cubit/cubit/insigths_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class WeeklytabsCubit extends Cubit<int> {
  WeeklytabsCubit() : super(0);
  void selectTab(int tabIndex) {
    emit(tabIndex);
  }
}

class WeeklyGraph extends StatelessWidget 
{
  WeeklyHistoryModel weeklyHistory;
  
  WeeklyGraph({required this.weeklyHistory});
  @override
  Widget build(BuildContext context) {
   
    return 
          BlocBuilder<WeeklytabsCubit, int>
          (builder: (context, currentindex) 
          {
           //print(context.read<InsigthsCubit>().SearchAboutCategoty(context.read<WeeklyCubit>() .Aspects[currentindex] .aspect!));
           
          return Container(
              width: double.infinity,
              height: 500,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30),
                color: Colors.grey.withOpacity(0.1),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Column(children: [
                  AspectsLife(),
                  SizedBox(
                    height: 20,
                  ),
                  LineGraph(
                      weeklyHistory: context
                          .read<InsigthsCubit>()
                          .SearchAboutCategoty(context
                              .read<WeeklyCubit>()
                              .Aspects[currentindex]
                              .aspect!)),
                ]),
              ));
              
        });
  }
}

class AspectsLife extends StatelessWidget {
  AspectsLife();
  @override
  Widget build(BuildContext context) {
    List<WeelklyModel> Aspects = context.read<WeeklyCubit>().Aspects;
    return BlocBuilder<WeeklytabsCubit, int>(builder: (context, currentindex) {
      return Flexible(
        child: GridView.builder(
            shrinkWrap: true,
            itemCount: Aspects.length,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 4, // Number of columns
              mainAxisSpacing: 10.0,
              crossAxisSpacing: 20.0,
              childAspectRatio: 2, // Aspect ratio of each grid item
            ),
            itemBuilder: (context, index) {
              return InkWell(
                onTap: () {
                  context.read<WeeklytabsCubit>().selectTab(index);
                },
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    color: currentindex == index
                        ? Color(0xff000000)
                        : Color(0xffF8F8FF),
                  ),
                  child: Center(
                    child: Text(
                      Aspects[index].aspect!,
                      style: GoogleFonts.inter(
                          color: Color(0xff9291A5), fontSize: 16),
                    ),
                  ),
                ),
              );
            }),
      );
    });
  }
}

class LineGraph extends StatefulWidget {
  final List<WeelklyModel> weeklyHistory;

  LineGraph({Key? key, required this.weeklyHistory}) : super(key: key);

  @override
  State<LineGraph> createState() => _LineGraphState();
}

class _LineGraphState extends State<LineGraph> {
  late TooltipBehavior _tooltipBehavior;

  @override
  void initState() {
    _tooltipBehavior = TooltipBehavior(enable: true);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final weeklyData = widget.weeklyHistory;

    if (weeklyData.length == 1) {
      final singlePoint = weeklyData.first;
      weeklyData.add(WeelklyModel(
          timestamp: singlePoint.timestamp,
          score: singlePoint.score,
          id: singlePoint.id)); // Add dummy second point
    }

    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30),
        color: Colors.transparent,
      ),
      child: SfCartesianChart(
        primaryXAxis: CategoryAxis(),
        series: <LineSeries<WeelklyModel, String>>[
          LineSeries<WeelklyModel, String>(
            color: Color(0xff9A89FF).withOpacity(.7),
            width: weeklyData.length > 2 ? 4 : 10,
            dataSource: weeklyData,
            xValueMapper: (WeelklyModel weekdata, _) => weekdata.timestamp,
            yValueMapper: (WeelklyModel weekdata, _) => weekdata.score,
          ),
        ],
      ),
    );
  }
}
