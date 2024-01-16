part of 'data_bloc_bloc.dart';

abstract class DataBlocEvent {}

final class LoadingEvent extends DataBlocEvent {}

final class LoadDataFromFirestoreApiEvent extends DataBlocEvent {}
