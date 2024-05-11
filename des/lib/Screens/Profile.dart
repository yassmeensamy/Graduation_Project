import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../constants.dart' as constants;

class ProfileSlide  extends StatelessWidget {
  const ProfileSlide ({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(body:
    Drawer(
      width: 280,
      backgroundColor: constants.pageColor ,
      child: 
      Padding(
        padding: const EdgeInsets.only(top: 20),
        child: Column(
          children: [
             Row(
              
              children: [
                   CircleAvatar(
                    radius: 28,
                    backgroundImage:  AssetImage("Assets/Ellipse.png"),
                   ),
                   SizedBox(width: 10,),
                   Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Yara Muhammad",style: GoogleFonts.openSans(fontSize:18 ),),
                       Row(
                        children: [
                          Text("view profile ",style: GoogleFonts.openSans(fontWeight: FontWeight.bold,color: constants.darkGrey.withOpacity(.5)),)
                           ,//Icon(Icons.arrow_back_ios_new),
                        ],
                      )
                      /*
                      TextButton(onPressed: (){}, child:
                      Row(
                        children: [
                          Text("view profile ",style: GoogleFonts.openSans(fontWeight: FontWeight.bold,color: constants.darkGrey.withOpacity(.5)),)
                           ,Icon(Icons.arrow_back_ios_new),
                        ],
                      )
                      )
                      */
                    ],
                   )
      
                
              ],
              
             )
            ,
          
              ListTile(
              onTap: (){},
              title: Text("About you"),
              leading: Icon(Icons.notification_add),
            ),
            ListTile(
              onTap: (){},
              title: Text("Notification"),
              leading: Icon(Icons.notification_add),
            ),
             ListTile(
               onTap: (){},
              title: Text("AcountSettings"),
              leading: Icon(Icons.notification_add),
            ),
             
           
            ListTile(
               onTap: (){},
              title: Text("Log Out"),
              leading: Icon(Icons.notification_add),
            ),
          
          ],
        ),
      ),
    ),

    );
  }
}