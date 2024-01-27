import 'package:flutter/material.dart';
import 'package:NUHA/view/common_widgets/network_image_loader.dart';

class CategoryHeader extends StatelessWidget {
  final String playListImgUrl;
  final String playListName;
  final String playListNameInArabic;
  const CategoryHeader({
    super.key,
    required this.playListImgUrl,
    required this.playListName,
    required this.playListNameInArabic,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 200,
        margin: const EdgeInsets.all(16.0),
        padding: const EdgeInsets.all(16.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16.0),
          color: Colors.grey.shade200,
        ),
        child: Column(
            // mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                  child: Row(
                // mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                      child: NetworkImageLoader(
                    imageUrl: playListImgUrl,
                  )),
                  Expanded(
                      child: Center(
                          child: Text("$playListName\n$playListNameInArabic")))
                ],
              )),
              Expanded(
                  child: Row(children: [
                Expanded(
                    child: TextButton.icon(
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all(
                            Colors.grey.shade600,
                          ),
                        ),
                        onPressed: () {},
                        icon: const Icon(Icons.play_arrow),
                        label: const Text(
                          "Play all",
                          style: TextStyle(color: Colors.white),
                        ))),
                SizedBox(
                  width: 20,
                ),
                Expanded(
                    child: TextButton.icon(
                        style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all(Colors.grey.shade300),
                        ),
                        onPressed: () {},
                        icon: const Icon(Icons.shuffle),
                        label: const Text("Shuffle"))),
              ]))
            ]));
  }
}
