import 'package:flutter/material.dart';

class LoadingWidget extends StatelessWidget {
  const LoadingWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: 0,
      left: 0,
      bottom: 0,
      right: 0,
      child: Container(
        color: Colors.black,
        child: Center(
            child: CircularProgressIndicator.adaptive(
          backgroundColor: Colors.white,
          // valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
          strokeWidth: 3.0,

          strokeCap: StrokeCap.square,
        )),
      ),
    );
  }
}
