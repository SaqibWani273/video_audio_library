part of 'suggested_videos_bloc.dart';

abstract class SuggestedVideosState {}

class SuggestedVideosInitial extends SuggestedVideosState {}

class LoadingState extends SuggestedVideosState {}

class LaodedState extends SuggestedVideosState {
  final int currentIndex;

  LaodedState({
    required this.currentIndex,
  });
}

class ErrorState extends SuggestedVideosState {
  final String message;

  ErrorState({
    required this.message,
  });
}
