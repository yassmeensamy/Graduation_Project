import 'package:des/Screens/Learning/TotalLessons.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:palette_generator/palette_generator.dart';
import '../../../constants.dart' as constants;

class ContentsLearning extends StatelessWidget {
  const ContentsLearning({super.key});

  @override
  Widget build(BuildContext context) {
    return  SafeArea(
      child: Scaffold(
        
        backgroundColor:constants.pageColor ,
        body: Padding(padding: EdgeInsets.only(left: 10,right: 10,top: 10),
        child:
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
        Padding(
          padding: const EdgeInsets.only(left:15,bottom: 15),
          child: Text("Learning Path" ,style:GoogleFonts.inter(fontSize: 34,)),
        ),
        Expanded(child: 
         GridView.builder(
          scrollDirection: Axis.vertical,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2, // Number of columns in the grid
            crossAxisSpacing: 6.0, // Spacing between columns
            mainAxisSpacing: 10.0,
            childAspectRatio: .87, // Spacing between rows
          ),
          itemCount: 6, // Number of items in the grid
          itemBuilder: (BuildContext context, int index) 
          {
            return LearnCard();
          }
        
        ),
        ),
          ]
        )
        )
    
      ),
    );
  }
}

class LearnCard extends StatelessWidget {
  LearnCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () 
       {
         Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => TotalLessons()),
              );
      },
      child:
     Container(
      decoration: BoxDecoration(
         // Optionally set background color
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: Colors.black.withOpacity(.23), 
          width: 1, 
        ),
      ),
      child: Column(
        children: [
          ImageContainer(imageUrl: "assets/images/gift.png"),
          Padding(
            padding: EdgeInsets.only(left: 10, top: 4),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "How to deal with bullying",
                  style: GoogleFonts.inter(fontSize: 17),
                  softWrap: true,
                ),
                SizedBox(height: 10),
                Container(
                  width: 50,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    color: Colors.red.withOpacity(.4),
                    //_backgroundColor?.withOpacity(.9),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(top: 2, bottom: 2),
                    child: Center(
                      child: Text(
                        "4 less",
                        style: GoogleFonts.inter(fontSize: 13),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    ),
    );
  }
}

class ImageContainer extends StatelessWidget {
  final String? imageUrl;

  ImageContainer({required this.imageUrl});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(20.0),
        topRight: Radius.circular(20.0),
      ),
      child:  Image.asset(
              imageUrl!,
              width: double.infinity,
              height: 120,
              fit: BoxFit.cover,
            ),
    );
  }
}
