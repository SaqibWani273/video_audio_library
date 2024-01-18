import 'dart:convert';
import 'dart:developer';

import 'package:http/http.dart' as http;
import 'package:video_audio_library/model/category.dart';
import '../model/playlist.dart';
import '/model/video_data_model.dart';

import '../constants/firestore_api_const.dart';

class DataRepo {
  List<VideoDataModel> videoDataModelList = [];
  List<VideoDataModel> suggestedVideosList = [];
  List<Category> categories = [];
  List<String> suggestionTagNames = [];
  final List<PlayList> playLists = <PlayList>[];

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

  Future<void> loadCategories() async {
    try {
      final response =
          await http.get(Uri.parse(FirestoreApiConst.getCategoriesUrl));
      if (response.statusCode != 200) {
        throw CustomException(
            type: ExceptionType.network, message: " Network Error !");
      }
      // log(" loadCategories -> ${response.body}");
      var i = 0;
      for (var category in jsonDecode(response.body)["documents"]) {
        categories.add(Category.fromMap(category["fields"]));
        //to do : change it late, temp solution
        playLists.add(PlayList.fromMap(category["fields"]));
        playLists[i] = playLists[i].copyWith(
          videos: videoDataModelList
              .where(
                  (element) => element.category == playLists[i].nameInEnglish)
              .toList(),
        );
        i++;
      }
      playLists.forEach((element) {
        log("playlist -> ${element.nameInEnglish} = ${element.videos?.length}");
      });
      //suggestions while video is plaing
      suggestionTagNames = [
        // "recommended",// add it later
        "all",

        ...categories.map((e) => e.nameInEnglish).toList()
        // CategoriesEnum.values.map(
        //   (e) => e.name,
        // )
      ];
    } on http.ClientException catch (_) {
      throw CustomException(
          type: ExceptionType.network, message: " Network Error !");
    } catch (e) {
      log(" Error in loadCategories -> $e");
      throw CustomException(
          type: ExceptionType.unknown, message: " Something went wrong !");
    }
  }

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
