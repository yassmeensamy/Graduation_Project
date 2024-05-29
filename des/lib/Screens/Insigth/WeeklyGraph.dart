import 'package:des/Models/WeeklyModel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
 /*
class TabState
 {
  final String aspect;
  TabState(this.aspect);
}
class TaCubit extends Cubit<TabState> {
  TaCubit() : super(TabState());

  void selectTab(AspectTap tab) {
    emit(TabState(tab));
  }
}
*/
class WeeklyGraph extends StatelessWidget {
   WeeklyGraph({super.key});
  List<WeelklyModel>weelkyhistory=[];
  @override
  Widget build(BuildContext context) 
  {
    return Container(
        width: double.infinity,
        height: 340,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30),
          color: Colors.grey.withOpacity(0.1),
        ),
    child:Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Column(children:
       [
         AspectsLife()
        
        ],),
    )
   
    );
 }
}




class AspectsLife extends StatelessWidget {

   AspectsLife();

  @override
  Widget build(BuildContext context) {
    return  Flexible(child:
     GridView.builder(
      itemCount: 7,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 4, // Number of columns
        mainAxisSpacing: 10.0,
        crossAxisSpacing: 20.0,
        childAspectRatio:2, // Aspect ratio of each grid item
      ),
      itemBuilder: (context, index) 
      {
        return  InkWell(
         onTap: () 
       {
       }, // Use onTap instead of onPressed
       child:  Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: Color(0xffF8F8FF)
        ),                    
         //$text
        child:Center(child:Text("Annually",style: GoogleFonts.inter(color: Color(0xff9291A5),fontSize: 16), ), ),
           ),
          );
      }
    ),
    );
  
  }
}