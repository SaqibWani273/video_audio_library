part of 'data_bloc_bloc.dart';

abstract class DataBlocState {}

final class DataBlocInitial extends DataBlocState {}

final class LoadingState extends DataBlocState {}

final class LaodedState extends DataBlocState {}

final class ErrorState extends DataBlocState {
  final String message;

  ErrorState({
    required this.message,
  });
}
