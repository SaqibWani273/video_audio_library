import 'dart:convert';
import 'dart:developer';

import 'package:http/http.dart' as http;
import '../constants/other_const.dart';
import '/model/video_data_model.dart';

import '../constants/firestore_api_const.dart';

class DataRepo {
  List<VideoDataModel> videoDataModelList = [];
  List<VideoDataModel> suggestedVideosList = [];

  //to load data from firestore api
  Future<void> loadData() async {
    try {
      final response = await http.get(Uri.parse(FirestoreApiConst.getUrl));
      if (response.statusCode != 200) {
        throw CustomException(
            type: ExceptionType.network, message: " Network Error !");
      }
      final decodeResponse =
          Map<String, dynamic>.from(jsonDecode(response.body));
      decodeResponse["documents"].forEach((document) {
        videoDataModelList.add(VideoDataModel.fromMap(document["fields"]));
      });
    } on http.ClientException catch (_) {
      throw CustomException(
          type: ExceptionType.network, message: " Network Error !");
    } catch (e) {
      throw CustomException(
          type: ExceptionType.unknown, message: " Something went wrong !");
    }
  }

  final List<String> suggestionTagNames = [
    // "recommended",// add it later
    "all",
    //categories having same name as specified in video_data_model
    ...CategoriesEnum.values.map(
      (e) => e.name,
    )
  ];
  int filterSuggestions({required String suggestionTagName}) {
    suggestedVideosList = suggestionTagName == "all"
        ? videoDataModelList
        : videoDataModelList
            .where((element) => element.category == suggestionTagName)
            .toList();

    return suggestionTagNames.indexOf(suggestionTagName);
  }
}

class CustomException implements Exception {
  final ExceptionType type;
  final String message;

  CustomException({required this.message, required this.type});
}

enum ExceptionType {
  network,
  unknown,
}
