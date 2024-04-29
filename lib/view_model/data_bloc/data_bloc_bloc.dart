import 'dart:developer';

import 'package:NUHA/model/video_data_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../repository/data_repo.dart';
import '../../model/custom_exception.dart';

part 'data_bloc_event.dart';
part 'data_bloc_state.dart';

class DataBlocBloc extends Bloc<DataBlocEvent, DataBlocState> {
  final DataRepo dataRepo;
  DataBlocBloc({required this.dataRepo}) : super(DataBlocInitial()) {
    on<LoadDataFromFirestoreApiEvent>(_loadData);
    on<ShowVideoEvent>(_showVideo);
    on<CancelMiniPlayerEvent>(_cancelVideo);
  }
  Future<void> _loadData(
      LoadDataFromFirestoreApiEvent event, Emitter<DataBlocState> emit) async {
    try {
      emit(LoadingState());
      await dataRepo.loadData();
      log("loaded data, ${dataRepo.videoDataModelList.length}");
      if (dataRepo.categories.isEmpty) {
        await dataRepo.loadCategories();
      }

      emit(LaodedState());
    } on CustomException catch (e) {
      log(e.message);
      emit(ErrorState(message: e.message));
    } catch (e) {
      log(e.toString());
      emit(ErrorState(message: " Something went wrong !"));
    }
  }
 Future< void> _showVideo(ShowVideoEvent event,Emitter<DataBlocState> emit)async{
    emit(LaodedState());//work around to stop
  await  Future.delayed(Duration(milliseconds: 100)); //(if) any current video in
  // miniplayer and open a new video
emit(LaodedState(videoDataModel: event.videoDataModel));

  }
  void _cancelVideo(CancelMiniPlayerEvent event,Emitter<DataBlocState> emit){
    emit(LaodedState());
  }
}
