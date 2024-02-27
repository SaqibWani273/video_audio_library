import 'package:flutter/material.dart';
import '/model/video_data_model.dart';
import '/view/home_screen/widgets/videos_list_widget.dart';

class SearchResults extends StatefulWidget {
  final List<VideoDataModel> searchResults;
  const SearchResults({super.key, required this.searchResults});

  @override
  State<SearchResults> createState() => _SearchResultsState();
}

class _SearchResultsState extends State<SearchResults> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          foregroundColor: Colors.black,
          title: const Text("Search Results"),
        ),
        body: widget.searchResults.isEmpty
            ? const Center(child: Text("no results found"))
            : SizedBox(
                height: MediaQuery.of(context).size.height,
                child: Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: MyBlockBuilder(
                    videosList: widget.searchResults,
                  ),
                ),
              ),
      ),
    );
  }
}
