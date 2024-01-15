import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';

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
    emit(LoadingState());
    await dataRepo.loadData();
    log("inside bloc, ${dataRepo.videoDataModelList.length}");
    emit(LaodedState());
  }
}
