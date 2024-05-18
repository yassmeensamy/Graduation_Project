import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart'; // Import shimmer package
import 'package:intl/intl.dart';

class Homeloading extends StatelessWidget {
  const Homeloading();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      /*
      bottomNavigationBar: Container( 
            height:100,
              decoration: BoxDecoration(
                color:Colors.grey,
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(25),
                topRight: Radius.circular(25),
                
              ),),
      ),
      */
      body: Shimmer.fromColors(
        baseColor: Colors.grey[300]!,
        highlightColor: Colors.grey[100]!,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    margin: const EdgeInsets.only(top: 40, left: 20),
                    width: 50,
                    height: 50,
                    decoration: BoxDecoration(
                      color: Colors.grey,
                      shape: BoxShape.circle,
                    ),
                  ),
                  const Spacer(),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Container(width: 30, height: 20),
                      Container(width: 30, height: 20),
                    ],
                  ),
                  const SizedBox(
                    width: 16,
                  ),
                  const Padding(
                    padding: EdgeInsets.only(top: 16.0),
                    child: Icon(
                      Icons.calendar_month_outlined,
                      color: Colors.grey,
                    ),
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                ],
              ),
              Text(
                      'Welcome Back,',
                      style: const TextStyle(fontSize: 22,color: Colors.grey),
                    ),
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 10.0),
                child: Text(
                  'How\'s your mental status at the moment?',
                  style: TextStyle(color: Colors.grey),
                ),
              ),
              Container(
                height: 50, // Adjust height as needed
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: 9, // Replace with your desired number of items
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: EdgeInsets.symmetric(horizontal: 3),
                      child: SizedBox(
                        height: 63,
                        child: Container(
                          width: 63,
                          decoration: BoxDecoration(
                            color: Colors.grey,
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
              SizedBox(height: 10,),
               Container
               (
                width: double.infinity,
                height: 100,
                decoration: BoxDecoration(
                            color: Colors.grey,
                          ),
               ),
               SizedBox(height: 10,),
               Container
               (
                width: double.infinity,
                height: 180,
                decoration: BoxDecoration(
                            color: Colors.grey,
                          ),
               )
            ],
          ),
        ),
      ),
    );
  }
}
