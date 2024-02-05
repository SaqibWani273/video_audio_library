import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class NetworkImageLoader extends StatelessWidget {
  final String imageUrl;
  final double? height;
  const NetworkImageLoader({super.key, required this.imageUrl, this.height});

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
        imageUrl: imageUrl,
        height: height,
        placeholder: (context, url) {
          // return const Center(child: CircularProgressIndicator());

          return Stack(children: [
            Container(height: height, color: Colors.black.withOpacity(0.4)),
            const Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: LinearProgressIndicator(),
            ),
          ]);
        },
        errorWidget: (context, url, error) {
          return const Icon(Icons.error);
        });
  }
}
