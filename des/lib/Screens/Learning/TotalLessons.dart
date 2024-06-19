import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SelectedIndexCubit extends Cubit<int> {
  SelectedIndexCubit() : super(-1);

  void selectIndex(int index) {
    if (state == index) {
      emit(-1);
    } else {
      emit(index);
    }
  }
}
class TotalLessons extends StatelessWidget {
  const TotalLessons({Key? key}) : super(key: key);
  
  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    return BlocProvider(
      create: (context) => SelectedIndexCubit(),
      child:
      Scaffold(
        body: BlocBuilder<SelectedIndexCubit, int>(
          builder: (context, selectedIndex) {
            return Stack(
              children: [
                Positioned(
                  top: 0,
                  left: 0,
                  right: 0,
                  height: screenHeight * 0.4,
                  child: Container(
                    color: Color(0xffE3C3EA).withOpacity(.6),
                    child: Center(
                      child: Image.asset(
                        'assets/images/bulling.png', // Path to your image asset
                        width: 250,
                        height: 300,
                      ),
                    ),
                  ),
                ),
                Positioned(
                  top: screenHeight * 0.416,
                  left: 7,
                  right: 7,
                  height: 40,
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(11),
                      color: Color(0xff7F7F7F).withOpacity(.1),
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Icon(Icons.add),
                        SizedBox(width: 5),
                        Text(
                          "You may revisit sessions after you’ve done them once",
                          style: GoogleFonts.nunitoSans(fontSize: 14),
                        ),
                      ],
                    ),
                  ),
                ),
                Positioned(
                  top: screenHeight * 0.48,
                  left: 7,
                  right: 7,
                  child: Text(
                    "Content",
                    style: GoogleFonts.nunitoSans(fontSize: 30),
                  ),
                ),
                Positioned(
                  top: screenHeight * 0.5,
                  left: 7,
                  right: 7,
                  bottom: 0, 
                  child: ListView.builder(
                    physics: BouncingScrollPhysics(),
                    itemCount: 3,
                    itemBuilder: (context, index) {
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          GestureDetector(
                            onTap: () {
                              context.read<SelectedIndexCubit>().selectIndex(index);
                            },
                            child: Container(
                              height: 54,
                              decoration: BoxDecoration(
                                border: Border(
                                  bottom: BorderSide(color: Colors.black.withOpacity(.2), width: 2),
                                ),
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Icon(Icons.search),
                                      Text(
                                        "Understanding your belief system",
                                        style: GoogleFonts.nunitoSans(fontSize: 17, fontWeight: FontWeight.w700),
                                      ),
                                    ],
                                  ),
                                  Transform.rotate(
                                    angle: -180 * 3.1415926535 / 180,
                                    child: Icon(Icons.arrow_back_ios),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          if (selectedIndex == index)
                            Column(
                                               children: List.generate(8, (innerIndex) {
                                      return Container( 
                                        height: 80,      
                                    color: Colors.blue,
                                    padding: EdgeInsets.all(16),
                                    child: Text(
                                      'Container for item $innerIndex',
                                      style: TextStyle(color: Colors.white),
                                    ),
                                  );
                                },
                              ),
                                )
                            
                        ],
                      );
                    },
                  ),
                ),
              ],
            );
          },
        ),
      ),
   
    );
  }
}
