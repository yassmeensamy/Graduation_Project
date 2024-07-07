import 'package:des/Components/UpperBgCircle.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../constants.dart' as constants;

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold
    (
      backgroundColor: Color(0xffA2D9CE),
      body: 
      Stack
      (
        children: [
           Positioned(
      top: -80.h,
      left: -50,
      child: Container(
        width: 370,
        height: 370,
        decoration: BoxDecoration(
          color: constants.babyBlue70,
          shape: BoxShape.circle,
        ),
      )
           ),

                      
          Positioned(
              top: 360,
              left: 70.h,
              right: 70.h,
              child:Container(
                    width: 140.0,
                    height: 140.0,
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                    ),
                    child: 
                    Center(child:Image.asset(
                    'assets/images/7.png',

                    )
                    
                  )
                ),
          ),

           Positioned(
      top: 515.h,
      left: 100.h,
      child: GestureDetector(
        onTap: (){},
        child: Container(
          width: 380.0,
          height: 380.0,
          decoration: const BoxDecoration(
            color: constants.lilac70,
            shape: BoxShape.circle,
          ),)
      )
           ),
        ],
        

      ),

    );
  }
}