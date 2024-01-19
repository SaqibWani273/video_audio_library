import 'package:flutter/material.dart';

class NetworkImageLoader extends StatelessWidget {
  final String imageUrl;
  const NetworkImageLoader({super.key, required this.imageUrl});

  @override
  Widget build(BuildContext context) {
    return Image.network(
      imageUrl,
      fit: BoxFit.fill,
      loadingBuilder: (context, child, progress) {
        return progress == null
            ? child
            : Stack(children: [
                Container(
                  color: Colors.grey.shade200,
                ),
                const Positioned(
                  bottom: 0,
                  left: 0,
                  right: 0,
                  child: LinearProgressIndicator(),
                ),
              ]);
      },
    );
  }
}
