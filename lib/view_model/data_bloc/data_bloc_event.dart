part of 'data_bloc_bloc.dart';

abstract class DataBlocEvent {}

final class LoadingEvent extends DataBlocEvent {}

final class LoadDataFromFirestoreApiEvent extends DataBlocEvent {}
final class ShowVideoEvent extends DataBlocEvent{
  final VideoDataModel videoDataModel;

  ShowVideoEvent({required this.videoDataModel});
}
final class CancelMiniPlayerEvent extends DataBlocEvent{}
final class ShowMiniPlayerEvent extends DataBlocEvent{final VideoDataModel videoDataModel;

  ShowMiniPlayerEvent({required this.videoDataModel});}
final class ShowMaxPlayerEvent extends DataBlocEvent{
  final VideoDataModel videoDataModel;

  ShowMaxPlayerEvent({required this.videoDataModel});
}
