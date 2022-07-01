import 'package:core/domain/usecases/tv/get_popular_tv.dart';
import 'package:equatable/equatable.dart';
import 'package:bloc/bloc.dart';
import 'package:core/domain/entities/tv/tv.dart';


part 'popular_tv_event.dart';
part 'popular_tv_state.dart';

class PopularTvBloc extends Bloc<PopularTvEvent, PopularTvState> {
  final GetPopularTv getPopularTv;

  PopularTvBloc({
    required this.getPopularTv,
  }) : super(PopularTvEmpty()) {
    on<FetchPopularTv>(_fetchPopularTv);
  }

  void _fetchPopularTv(
      FetchPopularTv fetchPopularTV, Emitter<PopularTvState> emitter) async {
    emitter(PopularTvLoading());
    final hasil = await getPopularTv.execute();
    hasil.fold(
      (failure) => emitter(PopularTvError(failure.message)),
      (data) => emitter(PopularTvData(data)),
    );
  }
}
