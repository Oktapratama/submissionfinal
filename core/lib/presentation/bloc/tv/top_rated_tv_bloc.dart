import 'package:core/domain/usecases/tv/get_top_rated_tv.dart';
import 'package:equatable/equatable.dart';
import 'package:core/domain/entities/tv/tv.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


part 'top_rated_tv_event.dart';
part 'top_rated_tv_state.dart';

class TopRatedTvBloc extends Bloc<TopTvEvent, TopTvState> {
  final GetTopRatedTv getTopTv;

  TopRatedTvBloc({
    required this.getTopTv,
  }) : super(TopTvEmpty()) {
    on<FetchTopRatedTv>(_fetchTopTv);
  }

  void _fetchTopTv(
      FetchTopRatedTv fetchTopRatedTV, Emitter<TopTvState> emitter) async {
    emitter(TopTvLoading());
    final hasil = await getTopTv.execute();
    hasil.fold(
      (failure) => emitter(TopTvError(failure.message)),
      (data) => emitter(TopTvData(data)),
    );
  }
}
