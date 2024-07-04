import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import '../../../constants.dart' as constants;

class CachedImage extends StatelessWidget {
  final String imageUrl;

  const CachedImage({required this.imageUrl, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return imageUrl.startsWith('http')
        ? CachedNetworkImage(
            imageUrl: imageUrl,
            fit: BoxFit.cover,
            placeholder: (context, url) => Container(
              color: constants.mint.withOpacity(0.5),
              // Placeholder for network images
            ),
            errorWidget: (context, url, error) => Center(
              child: Icon(
                Icons.error,
                color: Colors.red,
              ),
            ),
          )
        : Image.asset(
            imageUrl,
            fit: BoxFit.cover,
            // Placeholder for asset images if needed
          );
  }
}
