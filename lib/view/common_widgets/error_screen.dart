import 'package:flutter/material.dart';

class ErrorScreen extends StatelessWidget {
  final String errorMessage;
  final VoidCallback onPressed;
  const ErrorScreen(
      {super.key, required this.errorMessage, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        height: MediaQuery.of(context).size.height * 0.2,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.error_outline_sharp),
            Spacer(),
            Text(errorMessage),
            TextButton(
              onPressed: onPressed,
              child: const Text("Try Again"),
            ),
          ],
        ),
      ),
    );
    ;
  }
}
