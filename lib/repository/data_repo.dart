import 'dart:convert';
import 'dart:developer';

import 'package:http/http.dart' as http;
import 'package:video_audio_library/model/video_data_model.dart';

import '../constants/firestore_api_const.dart';

class DataRepo {
  List<VideoDataModel> videoDataModelList = [];

  //to load data from firestore api
  Future<void> loadData() async {
    try {
      final response = await http.get(Uri.parse(FirestoreApiConst.getUrl));
      if (response.statusCode != 200) {
        log("error -> ${response.body}");
        throw CustomException(
            type: ExceptionType.network, message: " Network Error !");
      }
      final decodeResponse =
          Map<String, dynamic>.from(jsonDecode(response.body));
      var i = 0;
      decodeResponse["documents"].forEach((document) {
        log("document${i++}  -> \n ${document}");
        videoDataModelList.add(VideoDataModel.fromMap(document["fields"]));
      });
      // log("response -> ${response.body}");
    } catch (e) {
      log("error -> $e");
      throw CustomException(
          type: ExceptionType.unknown, message: " Something went wrong !");
    }
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
