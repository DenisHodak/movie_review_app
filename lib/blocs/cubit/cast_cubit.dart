import 'package:flutter_bloc/flutter_bloc.dart';

import '../../models/cast.dart';
import '../../repositories/cast_repository.dart';

part 'cast_state.dart';

class CastCubit extends Cubit<CastState> {
  CastCubit() : super(CastInitial());

  CastRepository castRepository = CastRepository();

  void getMovieCast({required dynamic movieId}) async {
    emit(CastLoading());
    try {
      final movieDetails = await castRepository.getMovieCast(movieId: movieId);
      emit(CastLoaded(movieDetails));
    } catch (error) {
      emit(CastLoadFailed());
    }
  }
}

