import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:video_audio_library/constants/other_const.dart';

import '../../repository/data_repo.dart';

part 'data_bloc_event.dart';
part 'data_bloc_state.dart';

class DataBlocBloc extends Bloc<DataBlocEvent, DataBlocState> {
  final DataRepo dataRepo;
  DataBlocBloc({required this.dataRepo}) : super(DataBlocInitial()) {
    on<LoadDataFromFirestoreApiEvent>(_loadData);
  }
  Future<void> _loadData(
      LoadDataFromFirestoreApiEvent event, Emitter<DataBlocState> emit) async {
    try {
      emit(LoadingState());
      await dataRepo.loadData();

      emit(LaodedState());
    } on CustomException catch (e) {
      emit(ErrorState(message: e.message));
    } catch (e) {
      emit(ErrorState(message: " Something went wrong !"));
    }
  }
}
