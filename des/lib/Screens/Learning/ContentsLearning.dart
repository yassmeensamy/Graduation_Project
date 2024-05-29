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
  const LearnCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container
    (
     
      decoration: BoxDecoration(borderRadius:BorderRadius.circular(20),
       border: Border.all(
      color: Colors.black.withOpacity(.23), // Change this to the desired border color
        width: 1, // Adjust the width of the border if needed
      ),
      ),
      child: Column
      (
        
          children:
           [ 
            ImageWithBackground(),
            Padding(padding: EdgeInsets.only(left: 10),
            child:
            
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                 Text("How to deal with bullying" ,style: GoogleFonts.inter(fontSize: 17),softWrap: true,),
            SizedBox(height: 15,),
            Container(
              width: 50,
              decoration: BoxDecoration(borderRadius: BorderRadius.circular(12),color:Color(0xffE3C3EA).withOpacity(.6) ),
              child:
              Padding(
                padding: const EdgeInsets.only(top:2,bottom: 2),
                child: Center(child: Text("New",style:GoogleFonts.inter(fontSize: 13) , )),
              )
            )

              ],
            )
            ),

          ], 
      
      ),
   
    );
  }
}
  class ImageWithBackground extends StatelessWidget {
    const ImageWithBackground({super.key});
  
    @override
    Widget build(BuildContext context) {
      return Stack
      (
             children: [
               Positioned.fill(
                child: Container(
                  color: Color(0xffE3C3EA).withOpacity(.6), // Same color as the container's background
                ),
                ),
               Center(
                child: Image.asset(
                  'assets/images/bulling.png', // Path to your image asset
                  width: 140,
                  height: 120,
                ),
              ),
             ],
      );
    }
  }
/*
class ImageContainer extends StatelessWidget {
  String imageUrl;
 ImageContainer({ required this.imageUrl});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(
            10),
        child: Image.asset(
          'Assets/cover-uploadjpeg-1652873595 1.png', // Update this to your image path
          width: 90,
          height: 75,
          fit:
              BoxFit.cover, // Ensures the image covers the container completely
        ),
      ),
    );
  }
}
*/

/*
Future<Color?> getImagePalette(ImageProvider imageProvider) async {
  print('Starting getImagePalette function...');
  
  // Start timing
  final startTime = DateTime.now();
  
  print('Creating PaletteGenerator from ImageProvider...');
  final PaletteGenerator paletteGenerator =
      await PaletteGenerator.fromImageProvider(imageProvider);
  
  // End timing
  final endTime = DateTime.now();
  final duration = endTime.difference(startTime);
  print('PaletteGenerator creation took: ${duration.inMilliseconds}ms');
  
  print('Extracting dominant color...');
  final dominantColor = paletteGenerator.dominantColor?.color;
  
  print('Dominant color extracted: $dominantColor');
  
  // Returning dominant color
  return dominantColor;
}

class MyImageScreen extends StatefulWidget {
  @override
  _MyImageScreenState createState() => _MyImageScreenState();
}

class _MyImageScreenState extends State<MyImageScreen> {
  Color _backgroundColor = Colors.white; // Default background color
  
  // Load the image and extract dominant color
  void _loadImageAndSetBackground() async {
    // Replace 'imageProvider' with an actual ImageProvider instance
    ImageProvider imageProvider = AssetImage('assets/images/bulling.png'); // Example asset image
    Color? dominantColor = await getImagePalette(imageProvider);

    if (dominantColor != null) {
      setState(() {
        _backgroundColor = dominantColor;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    _loadImageAndSetBackground();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Image Screen'),
      ),
      body: Container(
        color: _backgroundColor,
        child: Center(
          child: Text(
            'Screen with Background Color from Image',
            style: TextStyle(color: Colors.white),
          ),
        ),
      ),
    );
  }
}
*/