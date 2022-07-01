import 'package:core/domain/usecases/tv/get_top_rated_tv.dart';
import 'package:equatable/equatable.dart';
import 'package:core/domain/entities/tv/tv.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


part 'top_rated_tv_event.dart';
part 'top_rated_tv_state.dart';

class TopTvBloc extends Bloc<TopTvEvent, TopTvState> {
  final GetTopRatedTv getTopTv;

  TopTvBloc({
    required this.getTopTv,
  }) : super(TopTvEmpty()) {
    on<FetchTopTv>(_fetchTopTv);
  }

  void _fetchTopTv(
      FetchTopTv fetchTopRatedTV, Emitter<TopTvState> emitter) async {
    emitter(TopTvLoading());
    final hasil = await getTopTv.execute();
    hasil.fold(
      (failure) => emitter(TopTvError(failure.message)),
      (data) => emitter(TopTvData(data)),
    );
  }
}
