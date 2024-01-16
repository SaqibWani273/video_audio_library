part of 'suggested_videos_bloc.dart';

abstract class SuggestedVideosEvent {}

// final class LoadSuggestedVideosEvent extends SuggestedVideosEvent {}

final class LoadSuggestedVideosEvent extends SuggestedVideosEvent {
  final String suggestionTagName;

  LoadSuggestedVideosEvent({required this.suggestionTagName});
}
