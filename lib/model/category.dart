// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:NUHA/model/playlist.dart';

class Category {
  String nameInEnglish;
  String nameInArabic;
  String imgUrl;
  List<PlayList> playLists;

  Category({
    required this.nameInEnglish,
    required this.nameInArabic,
    required this.imgUrl,
    this.playLists = const [],
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'nameInEnglish': nameInEnglish,
      'nameInArabic': nameInArabic,
      'imageUrl': imgUrl,
      // 'playLists': playLists.map((x) => x.toMap()).toList(),
    };
  }

  factory Category.fromMap(Map<String, dynamic> map) {
    return Category(
      nameInEnglish: map['nameInEnglish']["stringValue"] as String,
      nameInArabic: map['nameInArabic']["stringValue"] as String,
      imgUrl: map['imageUrl']["stringValue"] as String,
      // playLists: List<PlayList>.from(
      //   (map['playLists'] as List<int>).map<PlayList>(
      //     (x) => PlayList.fromMap(x as Map<String, dynamic>),
      //   ),
      // ),
    );
  }

  String toJson() => json.encode(toMap());

  factory Category.fromJson(String source) =>
      Category.fromMap(json.decode(source) as Map<String, dynamic>);

  Category copyWith({
    String? nameInEnglish,
    String? nameInArabic,
    String? imgUrl,
    List<PlayList>? playLists,
  }) {
    return Category(
      nameInEnglish: nameInEnglish ?? this.nameInEnglish,
      nameInArabic: nameInArabic ?? this.nameInArabic,
      imgUrl: imgUrl ?? this.imgUrl,
      playLists: playLists ?? this.playLists,
    );
  }
}
