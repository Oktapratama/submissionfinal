
import 'package:core/domain/entities/tv/tv.dart';
import 'package:core/domain/entities/tv/tv_detail.dart';
import 'package:core/domain/usecases/tv/get_tv_detail.dart';
import 'package:core/domain/usecases/tv/get_tv_recommendations.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'tv_detail_event.dart';
part 'tv_detail_state.dart';

class TvDetailBloc extends Bloc<TvDetailEvent, TvDetailState> {
  final GetTvDetail getTvDetail;
  final GetTvRecommendations getTvRecommendations;

  TvDetailBloc({
    required this.getTvDetail,
    required this.getTvRecommendations,
  }) : super((TvDetailEmpty())) {
    on<FetchTvDetail>(_fetchTvDetail);
  }

  void _fetchTvDetail(
      FetchTvDetail fetchTvDetail, Emitter<TvDetailState> emitter) async {
    emitter(TvDetailLoading());
    final detailResult = await getTvDetail.execute(fetchTvDetail.id);
    final recommendationResult =
        await getTvRecommendations.execute(fetchTvDetail.id);
    detailResult.fold((failure) => emitter(TvDetailError(failure.message)),
        (detTV) {
      emitter(TvDetailLoading());
      recommendationResult.fold(
        (failure) => emitter(TvDetailError(failure.message)),
        (recTV) => emitter(
          TvDetailData(detTV, recTV),
        ),
      );
    });
  }
}
