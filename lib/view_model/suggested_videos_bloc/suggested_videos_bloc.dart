import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:video_audio_library/constants/other_const.dart';

import '../../repository/data_repo.dart';

part 'suggested_videos_state.dart';
part 'Suggested_videos_event.dart';

class SuggestedVideosBloc
    extends Bloc<SuggestedVideosEvent, SuggestedVideosState> {
  final DataRepo dataRepo;
  SuggestedVideosBloc({required this.dataRepo})
      : super(SuggestedVideosInitial()) {
    on<LoadSuggestedVideosEvent>(_loadSuggestedVideos);
  }
  Future<void> _loadSuggestedVideos(LoadSuggestedVideosEvent event,
      Emitter<SuggestedVideosState> emit) async {
    try {
      emit(LoadingState());
      final clikedIndex = dataRepo.filterSuggestions(
          suggestionTagName: event.suggestionTagName);
      await Future.delayed(const Duration(milliseconds: 10));
      emit(LaodedState(currentIndex: clikedIndex));
    } on CustomException catch (e) {
      emit(ErrorState(message: e.message));
    } catch (e) {
      emit(ErrorState(message: " Something went wrong !"));
    }
  }
}
