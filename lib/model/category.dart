// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class Category {
  String nameInEnglish;
  String nameInArabic;
  String imgUrl;

  Category(
      {required this.nameInEnglish,
      required this.nameInArabic,
      required this.imgUrl});

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'nameInEnglish': nameInEnglish,
      'nameInArabic': nameInArabic,
      'imageUrl': imgUrl,
    };
  }

  factory Category.fromMap(Map<String, dynamic> map) {
    return Category(
      nameInEnglish: map['nameInEnglish']["stringValue"] as String,
      nameInArabic: map['nameInArabic']["stringValue"] as String,
      imgUrl: map['imageUrl']["stringValue"] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory Category.fromJson(String source) =>
      Category.fromMap(json.decode(source) as Map<String, dynamic>);
}
