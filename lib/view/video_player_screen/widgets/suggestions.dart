import 'package:flutter/material.dart';

enum SuggestionsEnum {
  recommended,
  all,
  tafseer,
  seerah,
  fiqh,
  hadees,
  quran,
  quranRecitation,
  tafseerRecitation,
  quranTafseerRecitation,
  fiqh1,
  hadees1,
  quran1,
  quranRecitation1,
  tafseerRecitation1,
  quranTafseerRecitation1,
}

class Suggestions extends StatelessWidget {
  const Suggestions({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
            children: SuggestionsEnum.values
                .map((e) => Container(
                      margin: const EdgeInsets.all(8.0),
                      padding: const EdgeInsets.all(8.0),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16.0),
                        color: Colors.grey.shade200,
                      ),
                      child: Text(e.name.toUpperCase()),
                    ))
                .toList()),
      ),
    );
  }
}
