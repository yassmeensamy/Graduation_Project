
import 'package:des/Models/ActivityModel.dart';
import 'package:des/Models/ReportModel.dart';
import 'package:des/cubit/cubit/handle_emojy_daily_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import '../../../../constants.dart' as constants;



class ReportScreen extends StatelessWidget 
{
  ReportModel dailyreport;
   ReportScreen(this.dailyreport);
  
  @override
  Widget build(BuildContext context) 
  {
    print(dailyreport.primarymood.ImagePath!);
    return  WillPopScope(
      onWillPop: () async
      {
           /*
           awaitt  ممكن وممكن 
           */
           //await  BlocProvider.of<InsigthsCubit>(context).ResetInsigth();
           BlocProvider.of<HandleEmojyDailyCubit>(context).FinishEntry(dailyreport,context);
           Navigator.pushNamedAndRemoveUntil(context, '/home', (route) => true);
           return true;
     },

      child: Scaffold
    (
      backgroundColor: constants.pageColor,
      body:  Padding(
        padding: const EdgeInsets.symmetric(vertical: 50,horizontal: 10),
        child:Column(
           crossAxisAlignment: CrossAxisAlignment.end,
            children: [
            Column(
                            children: [
                              Text(
                                DateFormat('EEEE').format(DateTime.now()),
                                style: const TextStyle(
                                    color: constants.txtGrey, fontSize: 16),
                              ),
                              Text(
                                DateFormat.MMMMd().format(DateTime.now()),
                                style: const TextStyle(fontSize: 20),
                              ),
                            ],
                          ),
         Padding(padding: EdgeInsets.only(top:25 ),
         child:
         Container(
           decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
           ),
          child: Padding(padding: EdgeInsets.only(left: 10 ,right: 10 ,bottom: 10 ),
          child:
           Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: 
          [
            Padding(padding: EdgeInsets.symmetric(vertical: 12),
            child:
             Row(
              children: [
                Container(
                       width: 63,
                       height: 63,
                       decoration: BoxDecoration(                 
                           image: DecorationImage(
                           fit: BoxFit.cover,
                           image: NetworkImage(dailyreport.primarymood.ImagePath!),
                                                  ),
                                                  ),
                                                ),
                       
                   SizedBox(width: 7,),
                   Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: 
                    [
                      Text( dailyreport.primarymood.Text,style: GoogleFonts.abhayaLibre(fontSize:24, fontWeight: FontWeight.bold ),),
                      SizedBox(height: 2,),
                      Text(DateFormat('hh:mm ').format(DateTime.now())),
                    ],
                   )     
              ],
             ),
            ),
              
              TextLine(first:"you felt",second: dailyreport.Secondmood.Text,),
              TextLine(first:"You made this Activities",second:dailyreport.activities),
              DescriptionTextWidget(text:dailyreport.journaling!),
              Line(),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: 
                [
                   Text("Tip of the day" ,style: GoogleFonts.abhayaLibre(fontSize: 22,color: Colors.black ,fontWeight: FontWeight.bold),),
                      Row
                      (
                        children:
                         [
                             Image.asset("assets/images/Tip.png" , width: 22,),
                             SizedBox(width: 1,),
                            Text("Tips" ,style: GoogleFonts.abhayaLibre(color: constants.TipColor, fontSize: 20,fontWeight: FontWeight.bold),),
                        ],
                      )   
                ],
              ),
              
              Text(dailyreport.dayTip!,style: GoogleFonts.abhayaLibre(color:constants.textGrey,fontSize: 20),),
              dailyreport.stressTip != "None"
            ?  Padding(padding: EdgeInsets.only(top:6),child:
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                 
                  Text(
                    "Stress Tip",
                    style: GoogleFonts.abhayaLibre(
                      fontSize: 22,
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    dailyreport.stressTip!,
                    style: GoogleFonts.abhayaLibre(
                      color: constants.textGrey,
                      fontSize: 20,
                    ),
                  ),
                ],
              ),
            )
            : SizedBox.shrink(),
          ],
        ), 
      
        ),
      
         ),
         ),
          ]
         
    ),
      
      ),
    ),
    );
  }
}
class DescriptionTextWidget extends StatefulWidget {
  final String text;

  DescriptionTextWidget({required this.text});

  @override
  _DescriptionTextWidgetState createState() => new _DescriptionTextWidgetState();
}
class _DescriptionTextWidgetState extends State<DescriptionTextWidget> {
  late String firstHalf;
  late String secondHalf;

  bool flag = true;

  @override
  void initState() {
    super.initState();

    if (widget.text.length > 70) 
    {
      firstHalf = widget.text.substring(0, 70);
      secondHalf = widget.text.substring(70, widget.text.length);
    } 
    else {
      firstHalf = widget.text;
      secondHalf = "";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(padding: EdgeInsets.only(top:12 ,bottom: 10),
    child:
    secondHalf.isEmpty
          ? Text.rich(
          TextSpan(
            text: 'Note:',
            style: GoogleFonts.abhayaLibre(fontSize: 22,color: Colors.black,fontWeight: FontWeight.bold),
            children: [
              TextSpan(
                text: firstHalf,
                style: GoogleFonts.abhayaLibre(
                  fontWeight: FontWeight.normal,
                  fontSize: 20,
                  color: constants.textGrey,
                ),
              ),
            ],
          ),
        )
          : new Column(
              children: <Widget>[
                 Text.rich(
          TextSpan(
            text: 'Note:',
            style: GoogleFonts.abhayaLibre(fontSize: 22,color: Colors.black,fontWeight: FontWeight.bold),
            children: [
              TextSpan(
                  text: ' ', // Add a space here
              ),
              
              TextSpan(
                text: flag ? (firstHalf + "...") : (firstHalf + secondHalf),   
                style: GoogleFonts.abhayaLibre(
                  fontWeight: FontWeight.normal,
                  fontSize: 20,
                  color: constants.textGrey,
                ),
              ),
            ],
          ),
        ),
          SizedBox(height: 10,),
                new InkWell(
                  child: new Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>
                    [
                      Icon(Icons.add,color:(constants.darkpurple),size: 20),
                       Text(
                        flag ? "Read more" : "Read less",
                        style: GoogleFonts.abhayaLibre(color:(constants.darkpurple),fontWeight: FontWeight.bold ,fontSize: 20)
                      ),
                    ],
                  ),
                  onTap: () {
                    setState(() {
                      flag = !flag;
                    });
                  },
                ),
              ],
            ),
    );
  }
}
class Line extends StatelessWidget {
  const Line({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(padding:EdgeInsets.only(bottom:12),
    child:
    Container(
      height: 2,
      color:Color(0xff100F11).withOpacity(.16)
    ),
    );
  }
}
class TextLine extends StatelessWidget {
  final String first;
  final dynamic second; 
  TextLine({required this.first, required this.second});
  @override
  Widget build(BuildContext context) 
  {
    return RichText(
      softWrap: true,
      text: TextSpan(
        text: first,
        style: GoogleFonts.abhayaLibre(fontSize: 20, color: constants.textGrey),
        children: _buildChildren(),
      ),
    );
  }
  List<TextSpan> _buildChildren() {
    if (second is String) {
      return [
        TextSpan(text: ' '),
        TextSpan(
          text: second,
          style: GoogleFonts.abhayaLibre(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
      ];
    } else if (second is List<ActivityModel>) {
      return [
        TextSpan(text: ' '),
        ...second.map((activity) => TextSpan(
          text: activity.Text!,
          style: GoogleFonts.abhayaLibre(
            fontSize: 19,
            color: Color(0xff100F11),
            fontWeight: FontWeight.bold,
          ),
        )).expand((e) => [e, TextSpan(text: ", ")]).toList()..removeLast(),
      ];
    } else {
      throw ArgumentError('Invalid type for second parameter');
    }
  }
}