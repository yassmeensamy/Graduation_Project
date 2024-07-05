
import 'package:des/Features/Meditation/Models/MeditationModel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../constants.dart' as constants;

import 'MeditationCubit/Meditation.dart';
import 'music_player.dart';
class MeditationScreen extends StatefulWidget {
  @override
  _MeditationScreenState createState() => _MeditationScreenState();
}

class _MeditationScreenState extends State<MeditationScreen> 
{
  
  List<MeditationModel> sessions = [];

  @override
  void initState() 
  {
    super.initState();
    fetchMeditationData();
  }

  fetchMeditationData() async {
    try {
      List<MeditationModel> fetchedSessions = await GetMeditation().GetMeditations();
      setState(() 
      {
        sessions = fetchedSessions;
        for (int i = 0; i < sessions.length; i++) {
          sessions[i].duration = sessions[i].duration.substring(3);
        }
      });
    } 
    catch (e) {
      print('Error fetching meditation data: $e');
      // Handle error as needed
    }
  }
// حاسه انها غلط لانه افرض ضاف حاجة جديده؟
//الصح  اني اعمل  زي الاسكرين الي بعدها color genetetate 
// دي بس  حاليا لهندله الايرورز ميحصلش
 
 
 //الصح حاجة من 2 في اللوم بنعمل %  او  نطلع اللون من باك جراوند بتاعت صوره
 
 
  final List<Color> colors = [
    Color(0xFFE7F6FF),
    Color(0xFFFFE8EC),
    Color(0xFFFFFACA),
    Color( 0xFFEEE5FF),
    Color(0xFFE7F6FF),
    Color(0xFFD5E8E4),
    Color( 0xFFEEE5FF),
    Color(0xFFE7F6FF),
    Color(0xFFD5E8E4),
    Color( 0xFFEEE5FF),
    Color(0xFFE7F6FF),
    Color(0xFFD5E8E4),
          ];
     
@override
Widget build(BuildContext context) 
{
  return Scaffold
  (
  backgroundColor: constants.pageColor,
  appBar:
   AppBar(
  iconTheme: IconThemeData(color: Colors.black),
  elevation: 0,
  backgroundColor: Colors.transparent,
  title:Text(
        "Meditation",
           style: GoogleFonts.nunitoSans(
                fontWeight: FontWeight.w700,
                fontSize: 24,
                color: Colors.black
           ),
),
   ),
    body: 
    Padding(
      padding: const EdgeInsets.only(top: 5, left: 17, right: 17),
      child:
      GridView.custom(
          gridDelegate: SliverWovenGridDelegate.count(
            crossAxisCount: 2,
            mainAxisSpacing: 11,
            crossAxisSpacing:11,
            pattern: [
              WovenGridTile(.63),
              WovenGridTile(
              .59,
                crossAxisRatio:1,
                
                alignment: AlignmentDirectional.bottomStart, 
              ),
            ],
          ),
          childrenDelegate: SliverChildBuilderDelegate(
            (context, index) => MeditationCard(
              title: sessions[index].MeditationName,
              duration: sessions[index].duration,
              cardColor: colors[index],
              image: sessions[index].MeditationImage,
              TrackID: sessions[index].MeditationURl,
            
            ),
            childCount: sessions.length, // Define the count of children here
          ),
        ),
      ),
  );
}
}

class MeditationCard extends StatelessWidget {
  final String image;
  final String title;
  final String duration;
  final Color cardColor;
  final String TrackID;
  //final  double extent;

  MeditationCard({
    required this.title,
    required this.image,
    required this.duration,
    required this.cardColor,
    required this.TrackID,
   // required this.extent,

  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // Handle tap action here
        Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => MusicPlayer(trackID:TrackID,)),
        );
      },
      child:

      Container(
       //width: extent,
      ///height: extent,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        color: cardColor,
        
      ),
      child:Padding(padding: EdgeInsets.only(top:12,left:20),
      child:
       Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [   
            Text(
              title,
              style: GoogleFonts.nunitoSans(
                fontWeight: FontWeight.w700,
                fontSize: 20
  ), 
              //TextStyle(fontSize: 18, fontWeight: FontWeight.w600 ,color: Colors.black,fontFamily: GoogleFonts.lato().fontFamily),
            ),
               
            SizedBox(height: 12),
            Container(
              height: 24,
              width: 48,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
              ),
              child:
              Center(child:
                Text(
                  duration,
                  style: TextStyle(fontSize: 12, fontWeight: FontWeight.w800),
                ),
              ),
            ),
              SizedBox(height: 10),
            Center(child:
            Image.network(
              image,
              //fit: BoxFit.cover,
            // Adjust height as per your requirement
            ),
            )
          ],
        ),
      ),
      ),
    );
    
    
    
  }
}
