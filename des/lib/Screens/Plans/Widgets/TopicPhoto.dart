import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import '../../../constants.dart' as constants;

class TopicPhoto extends StatelessWidget 
{
  final String Imageurl;
   TopicPhoto(this.Imageurl);
  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    return  Stack(children: [
    Positioned.fill(
            top: 0,
            left: 0,
            right: 0,
           bottom:screenHeight * 0.48 ,
            child:
            Container(     
              child: 
              CachedNetworkImage(
                
                height: screenHeight * 0.35,
                imageUrl: Imageurl,
                fit: BoxFit.cover,
                placeholder: (context, url) => Container(
                  color: Colors.grey[300],
                ),
                errorWidget: (context, url, error) => Center(
                  child: Icon(
                    Icons.error,
                    color: Colors.red,
                  ),
                ),
              ),
            ),
          ),
           Positioned(
            top: screenHeight * 0.32, // Start below the first container
            left: 0,
            right: 0,
            height: screenHeight * 0.7, // Take up the remaining visible area
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30),
                color: constants.pageColor,
              ),
            ),
          ),
          ],);
}
}