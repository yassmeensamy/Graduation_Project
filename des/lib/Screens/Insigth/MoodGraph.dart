import 'package:des/Models/MoodModel.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import '../../Models/MoodgraphModel.dart';

class MoodCount extends StatelessWidget {
  final String text;
  final Color col;
  final num count;
  MoodCount({required this.col, required this.text ,required this.count});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 10,right: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          
         Row(
          children: [
             CircleAvatar(radius: 4, backgroundColor: col),
          SizedBox(width: 5),
          Text(text, style: GoogleFonts.roboto(fontSize: 20)),
          ],
         ),
          Text(count.toString(), style: GoogleFonts.roboto(fontSize: 20)),
        ],
      ),
    );
  }
}

class MoodGraph extends StatelessWidget {
  List<MoodModel>chartData;
  MoodGraph(this.chartData);

  @override
  Widget build(BuildContext context) {
   List<Color> colors = [
  Color(0xff14B8A6),
  Color(0xff3B82F6),
  Color(0xff6366F1),
  Color(0xffEC4899),
  Color(0xffF59E0B),
  Color(0xffFACC15),
  //Color(0xff)
];

    /*
    final List<MoodGraphModel> chartData = 
    [
      MoodGraphModel(mood: 'Happy', moodcount: 25),
      MoodGraphModel(mood: 'Fear', moodcount: 38),
      MoodGraphModel(mood: 'Loved', moodcount: 34),
      MoodGraphModel(mood: 'Angry', moodcount: 52),
      MoodGraphModel(mood: 'Sad', moodcount: 10),
      MoodGraphModel(mood: 'Disgust', moodcount: 4),
    ];
    */
    for (int i = 0; i < chartData.length; i++)
     {
      int colorIndex = i % colors.length;
      chartData[i].colormood = colors[colorIndex];
    }
return 
   Container(
    width: double.infinity,
    height: 340,
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(30),
      color: Colors.grey.withOpacity(0.1), // Adjust the background color
    ),
    child: Padding(
      padding: const EdgeInsets.all(3), 
      child: Stack(
        children: <Widget>[
          Positioned(
            top: 30,
            left: 0,
            right: 0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(padding: EdgeInsets.only(left: 8),
                child:
                Text("Mood Tracker", style: GoogleFonts.roboto(fontSize: 20,fontWeight: FontWeight.bold)),
                ),
                Text("Label", style: GoogleFonts.roboto(fontSize: 20,color: Color(0XFF737373))),
                Text("Days", style: GoogleFonts.roboto(fontSize: 20,color: Color(0XFF737373))),
              ],
            ),
          ),
          Positioned(
            top: 80, // Adjust the top position as needed to create space for the row
            left: 0,
            child: Container(
              width: 200, // Specify the size of the chart
              height: 200, // Specify the size of the chart
              child: SfCircularChart(
                series: <CircularSeries>[
                  DoughnutSeries<MoodModel, String>(
                    dataSource: chartData,
                    pointColorMapper: (data, _) => data.colormood,
                    xValueMapper: (MoodModel data, _) => data.Text,
                    yValueMapper: (MoodModel data, _) => data.count,
                    radius: '100%',
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            top: 50, // Adjust the top position as needed to create space for the row
            left: 210,
            child: SizedBox(
              width: 160,
              height: 400,
              child: ListView.builder
             
              (
                itemCount: chartData.length,
                itemBuilder: (context, index) {
                  return MoodCount(col: chartData[index].colormood!, text: chartData[index].Text,count: chartData[index].count!);
                },
                //separatorBuilder: (context, index) => SizedBox(height: 5), // Add separation between items
              ),
            ),
          ),
        ],
      ),
    ),
  );

  }
}
