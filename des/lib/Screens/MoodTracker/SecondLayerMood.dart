import 'package:des/Screens/MoodTracker/ReportScreen.dart';
import 'package:des/cubit/cubit/handle_home_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import '../../../constants.dart' as constants;
import 'package:just_the_tooltip/just_the_tooltip.dart';
import '../../Components/NextButton.dart';
import '../../Models/MoodModel.dart';
import '../../cubit/EmotionCubit.dart';
import '../../cubit/EmotionCubitState.dart';
import '../../cubit/mood_card_cubit.dart';
import '../../cubit/mood_card_state.dart';
import '../Temp.dart';
import 'Actvities.dart';
import 'JournalingScreen.dart';

class  SecondViewMoodPage extends StatelessWidget {
  const SecondViewMoodPage({Key? key});
  @override
  Widget build(BuildContext context) {
   
   
    return WillPopScope(
      onWillPop: () async {
        //BlocProvider.of<HandleHomeCubit>(context).resetState();
        return true;
      },
      child:BlocConsumer<SecondLayerCubit, SecondLayerCubitCubitState>(
      listener: (context, state) 
      {
        if (state is Activities_ReasonsState) 
        {
             Navigator.push(context, MaterialPageRoute(builder: (context) => Activities(
              activitiesList: state.Activities, 
              reasonList: state.Reasons
            ))).then((_) {
              BlocProvider.of<SecondLayerCubit>(context).emit(EmotionCubitStateSucess(
                 BlocProvider.of<SecondLayerCubit>(context).secondEmotions,
                   BlocProvider.of<SecondLayerCubit>(context).ImagePath,
                 BlocProvider.of<SecondLayerCubit>(context).EmotionType,
              
              ));
            });
        }
        else if (state is JournalingState)
        {
             Navigator.push(context, MaterialPageRoute(builder: (context)=>Journalingcreen()));
        }
        else if ( state is conclusionState)
        {
                         Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (context) =>ReportScreen(state.reportModel)),
              ModalRoute.withName('/home'), 
            );

             
        }
        
      },
       builder: (BuildContext context, SecondLayerCubitCubitState state) 
       { 
        if(state is EmotionCubitStateSucess  )
        {
         return  SecondLayerView(EmotionType: state.moodname
         ,moods: state.Emotions
         ,ImagePath: state.ImagePath,);
        }
        else 
        {
           
           return Scaffold(body: Center(child: CircularProgressIndicator(),),)
           ;
        }
      },
     
   
    ),
    );
      }
    
  
  }

class SecondLayerView extends StatelessWidget {
   List<MoodModel> moods;
    String EmotionType;
    String ImagePath;
 SecondLayerView({required this.moods,required this.ImagePath,required this.EmotionType});
 String currentTime()
     {
      DateTime now = DateTime.now();
      String formattedTime = DateFormat.Hm().format(now);
      return formattedTime;
    }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(30),
        child: Column(
          children: [
            Row(
              children: [
                IconButton(
                  onPressed: () 
                  {
                 // هنا كده لما يرجع لللهوم مش هينفع يرجع لاي حاجة قبلها 
                   Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => temp()), (route) => false,);
                  },
                  icon: const Icon(Icons.arrow_back_ios, size: 13),
                ),
                const SizedBox(width: 35),
                const Text(
                  "How are you Feeling?",
                  style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
                ),
              ],
            ),
            const SizedBox(height: 12),
            DateCard(date: currentTime()),
            const SizedBox(height: 25),
            Image(
              image: AssetImage(ImagePath),
              width: 130.0,
              height: 130.0,
            ),
            const SizedBox(height: 25),
            const HorizontalLineDrawingWidget(),
           
            const SizedBox(height: 25),
            Text(
               EmotionType,
              style: TextStyle(fontSize: 40, color: Colors.black, fontFamily: 'Roboto'),
            ),
            const SizedBox(height: 20),
            const Text(
              "Which words describe your feeling best?",
              style: TextStyle(fontSize: 16, color: Colors.black54),
            ),
            const SizedBox(height: 10),
            Expanded(
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  crossAxisSpacing: 16.0,
                  mainAxisSpacing: 16.0,
                ),
                itemCount: moods.length,
                itemBuilder: (context, index) 
                {
                  return  TooltipSample(child: 
                  MoodCard(
                    mood: moods[index],
                    index: index,    
                    backgroundColorAfter: constants.mint ,
                    backgroundColorBefore: Colors.white10, 
                  ),
                  description: moods[index].Description!,
                  );
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 20),
              child: NextButton(
                ontap: () 
                {
                   BlocProvider.of<SecondLayerCubit>(context).SaveAndNaviagtion(context);
                },
                   groundColor: constants.mint,
              text: "Next",
              ),
            ),
          ],
        ),
      ),
        );
  }
}


class DateCard extends StatelessWidget {
  final String date;

  const DateCard({Key? key, required this.date});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 130,
      height: 30,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: Colors.white,
        border: Border.all(
          color: Colors.grey,
          width: 0.1,
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text("Today " + date),
          const SizedBox(
            width: 10,
          ),
          Transform.rotate(
            angle: 270 * 3.1415926535 / 180, // Rotate 180 degrees (in radians)
            child: const Icon(
              Icons.arrow_back_ios,
              size: 13,
            ),
          )
        ],
      ),
    );
  }
}


class MoodCard extends StatelessWidget 
{
  final dynamic  mood;
  final int index;
   final Color backgroundColorBefore;
   final Color backgroundColorAfter;
  
  const MoodCard({
    Key? key,
    required this.mood,
    required this.index,
    required this.backgroundColorBefore,
    required this.backgroundColorAfter
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<MoodCubit, MoodState>(
      listener: (context, state) {},
      builder: (context, state) {
        final isSelected = state.selectedMoodIndex == index;
        return InkWell(
          onTap: () {
            if (isSelected)
             {
                context.read<MoodCubit>().unselectMood();  
                context.read<SecondLayerCubit>().SelectedMood=" ";
                //print(context.read<SecondLayerCubit>().SelectedMood);
             } 
            else
             {
                context.read<MoodCubit>().selectMood(index);
                context.read<SecondLayerCubit>().SelectedMood=mood.Text;
                //print(context.read<SecondLayerCubit>().SelectedMood);
             }
          },
          child: Container(
            decoration: BoxDecoration(
              color: isSelected ? backgroundColorAfter : backgroundColorBefore,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Padding(
              padding: EdgeInsets.only(top: 10),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Image(
                    //image: NetworkImage(mood.ImagePath),
                    image:NetworkImage(mood.ImagePath),
                    height: 60,
                    width: 60,
                  ),
                  Text(mood.Text, style: TextStyle(fontSize: 16)),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

class TooltipSample extends StatelessWidget {
  final String description;
  final Widget child;
  const TooltipSample({required this.description ,required this.child});

  @override
  Widget build(BuildContext context) {
    return JustTheTooltip(
      child: Material(
       
       
        child:  child,
        ),
      
      content: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text(description),
      ),
    );
  }
}

class HorizontalLineDrawingWidget extends StatelessWidget {
  const HorizontalLineDrawingWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return 
    
    CustomPaint(
      painter: HorizontalLinePainter(),
       // Set the size of the paint area
    );
  }
}

class HorizontalLinePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
       ..color = const Color(0XFF9CABC2).withOpacity(.5)
      ..strokeWidth = 2.0;

    const start =  Offset(-110, 0); // Starting point of the horizontal line
    const end =   Offset(110.0, 0); // Ending point of the horizontal line

    canvas.drawLine(start, end, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
  
}




