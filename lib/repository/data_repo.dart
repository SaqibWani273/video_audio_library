import 'dart:convert';
import 'dart:developer';

import 'package:http/http.dart' as http;
import 'package:NUHA/model/category.dart';
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

      for (var categoryData in jsonDecode(response.body)["documents"]) {
        final PlayList allVideos = PlayList(
            nameInEnglish: "ALL VIDEOS",
            nameInArabic: " الكل ",
            videos: videoDataModelList
                .where((element) =>
                    element.category ==
                    categoryData["fields"]["nameInEnglish"]["stringValue"])
                .toList());
        //gets category & their playlists data but without videos
        //data for playlists
        var category = Category.fromMap(categoryData["fields"]);
        final updatedPlaylist = category.playLists
            ?.map((e) => e.copyWith(
                videos: videoDataModelList
                    .where((element) =>
                        element.subCategory == e.nameInEnglish &&
                        element.category == category.nameInEnglish)
                    .toList()))
            .toList();
        // log("updated  playlist -> $updatedPlaylist");
        category = category.copyWith(
            playLists: updatedPlaylist == null
                ? [allVideos]
                : (updatedPlaylist..insert(0, allVideos)));
        categories.add(category);
      }

      suggestionTagNames = [
        // "recommended",// add it later
        "all",

        ...categories.map((e) => e.nameInEnglish).toList()
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
