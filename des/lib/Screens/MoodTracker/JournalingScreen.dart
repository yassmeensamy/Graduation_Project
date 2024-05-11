
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../constants.dart' as constants;
import '../../Components/NextButton.dart';
import '../../cubit/EmotionCubit.dart';
import '../../cubit/EmotionCubitState.dart';
import 'Conclusion.dart';


class Journalingcreen extends StatelessWidget {
  const Journalingcreen({super.key});

  @override
  Widget build(BuildContext context) 
  {
    return  BlocBuilder<SecondLayerCubit, SecondLayerCubitCubitState >
    (
      builder: (context, state) 
      {
        if(state is JournalingState)
        {
             return JournalingScreen();
        }
        else if (state is conclusionState)
        {
             return Conclusion();
        }
        return Container();
      },
    );
  
  }
}
class JournalingScreen extends StatelessWidget {
  const JournalingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController Journaling=TextEditingController();
    return  
     Scaffold(
      body: SingleChildScrollView(
        
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const JournalingTitle(),
            const SizedBox(height: 8),
            const JournalingImage(),
            const SizedBox(height: 4),
             JournalingContainer(Journaling: Journaling,),
            //Remove the unnecessary comment
            const SizedBox(height: 25),
            NextButton(
              ontap: ()
              {
                BlocProvider.of<SecondLayerCubit>(context).SendJournaling(Journaling.text);
              },
                 groundColor: constants.mint,
              text: "Next",
            ),
          ],
        ),
      ),
    );
  }
}


class JournalingContainer extends StatelessWidget {
  TextEditingController Journaling;
   JournalingContainer({ required this .Journaling});

  @override
  Widget build(BuildContext context) {
    
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 28),
          child: Stack(
            children: [
              SizedBox(
                width: 330,
                child: TextField(
                  controller:Journaling ,
                  maxLines: 17,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30),
                      borderSide: const BorderSide(color: Color.fromARGB(255, 18, 26, 170)),
                    ),
                    hintText: '  What\'s on your mind? ',
                    hintStyle: GoogleFonts.lato(
                       textStyle: TextStyle(fontSize: 18, letterSpacing: .5),
                                     ),
                    
                  
                  ),
                  onChanged: (text) {
                   
                  },
                  //inputFormatters: [LengthLimitingTextInputFormatter(30)], // Limit to 30 characters
                ),
              ),
              /*
              Positioned(
                bottom: 17,
                right: 17,
                child: Text(
                   // Display count only when writing is true
                  style: const TextStyle(
                    color: Colors.grey,
                  ),
                ),
              ),
              */
            ],
          ),
        );
      }
  }

class JournalingImage extends StatelessWidget {
  const JournalingImage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Image(
        image: AssetImage("assets/images/Journaling.png"),
        width: 350,
        height: 205,
      ),
    );
  }
}
class JournalingTitle extends StatelessWidget {
  const JournalingTitle({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top:30),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 5),
            child: Center(
              child: Column(
                children: [
                 
                  Row(
                    children: [
                      IconButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        icon: const Icon(Icons.arrow_back_ios, size: 13),
                      ),
                      const SizedBox(width: 35),
                      Text(
                        "Add any thoughts that",
                        style: TextStyle(
                      fontSize: 20,
                      fontFamily: GoogleFonts.openSans().fontFamily,
                      color: const Color(0xFF000000),
                    ),
                      ),
                    ],
                  ),
                 
                  const SizedBox(height:1), // Adding some space between the icon and text
                  Text(
                    'are reflecting your Mood',
                    style: TextStyle(
                      fontSize: 20,
                      fontFamily: GoogleFonts.openSans().fontFamily,
                      color: const Color(0xFF000000),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

