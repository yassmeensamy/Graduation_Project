
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import '../../../constants.dart' as constants;
class ReportScreen extends StatelessWidget {
  const ReportScreen({super.key});

  @override
  Widget build(BuildContext context) 
  {
    return Scaffold
    (
      backgroundColor: constants.pageColor,
      body: 
      Padding(
        padding: const EdgeInsets.only(top:50 ,left: 11,right: 11),
        child:
         Column(
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

         Padding(padding: EdgeInsets.only(top:25),
         child:
         Container(
           decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
           ),
          child: Padding(padding: EdgeInsets.only(left: 10 ,right: 10 ),
          child:
           Column(
            crossAxisAlignment: CrossAxisAlignment.start,
          children: 
          [
            Padding(padding: EdgeInsets.only(bottom: 14,top: 10),
            child:
             Row(
              children: [
                //NetworkImage()
                   Image.asset(
                   "assets/images/Emotions/Sad.png",
                    width: 63,
                    height: 63,
                  ),
                   SizedBox(width: 7,),
                   Column(
                    children: 
                    [
                      Text("Sad" ,style: GoogleFonts.abhayaLibre(fontSize:24, fontWeight: FontWeight.bold ),),
                      SizedBox(height: 2,),
                      Text(DateFormat('hh:mm ').format(DateTime.now())),
                    ],
                   )
                   
              ],
             ),
            ),
              
              textline(first:"you felt",Second: "Disappointed",),
              textline(first:"You made this Activities",Second: "walking,Reading",),
              SizedBox(height: 14,),
              DescriptionTextWidget(text:"Flutter is Google’s mobile UI framework Flutter is Google’s mobile UI framework Flutter is Google’s mobile UI framework Flutter is Google’s mobile UI framework Flutter is Google’s mobile UI framework Flutter is Google’s mobile UI framework Flutter is Google’s mobile UI framework Flutter is Google’s mobile UI framework "),
              SizedBox(height: 10,),
              Line(),
              SizedBox(height: 14,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: 
                [
                   Text("Connect With Natural" ,style: GoogleFonts.abhayaLibre(fontSize: 22,color: Colors.black ,fontWeight: FontWeight.bold),),
                      Row(
                        children:
                         [
                             Image.asset("assets/images/Tip.png" , width: 22,),
                             SizedBox(width: 1,),
                            //Icon(Icons.tips_and_updates_outlined ,color: constants.TipColor,),
                            Text("Tip" ,style: GoogleFonts.abhayaLibre(color: constants.TipColor, fontSize: 20,fontWeight: FontWeight.bold),),
                        ],
                      )
                  
                ],
              ),
               SizedBox(height: 7,),
              Text("Spend time outdoors, surrounded by greenery and fresh air",style: GoogleFonts.abhayaLibre(color:constants.textGrey,fontSize: 20),)
              ,SizedBox(height: 30,),
          ],
        ), 
      
        ),
      
         ),
         ),
          ]
         
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
    return secondHalf.isEmpty
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
            );
  }
}
class Line extends StatelessWidget {
  const Line({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 2,
      color:Color(0xff100F11).withOpacity(.16)
    );
  }
}
class textline extends StatelessWidget
 {
  String first;
  String Second;
  textline({required this.first ,required this.Second});

  @override
  Widget build(BuildContext context) {
    return  Text.rich(
          TextSpan(
            text: first,
            style: GoogleFonts.abhayaLibre(fontSize: 20,color: constants.textGrey),
            children: [
              TextSpan(
                text: ' ', // Add a space here
              ),
              TextSpan(
                text: Second,
                style: GoogleFonts.abhayaLibre(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.black
                ),
              ),
            ],
          ),
        );
        
  }
}