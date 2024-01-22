import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../model/video_data_model.dart';
import '../repository/data_repo.dart';

class Utils {
  List<VideoDataModel> searchVideo(String val, BuildContext context) {
    //to check for each word from the search query
    final lowerSearchValueList = val.toLowerCase().split(' ');

    final allVideos = context.read<DataRepo>().videoDataModelList;
    //filter videos where videodescription or category contains
    // one or more words from the search query
    final filteredVideos = allVideos.where((element) {
      return lowerSearchValueList.any((searchWord) =>
          element.videoDescription.toLowerCase().contains(searchWord) ||
          element.category.toLowerCase().contains(searchWord));
    }).toList();
    //sort these to show most matching videos first
    //maybe change sorting logic later

    filteredVideos.sort((a, b) {
      return b.videoDescription.compareTo(a.videoDescription);
    });

    return filteredVideos;
  }
}
