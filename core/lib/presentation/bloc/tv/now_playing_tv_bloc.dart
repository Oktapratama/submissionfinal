import 'package:core/domain/entities/tv/tv.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../domain/usecases/tv/get_now_playing_tv.dart';


part 'now_playing_tv_event.dart';
part 'now_playing_tv_state.dart';

class NowPlayingTvBloc extends Bloc<NowPlayingTvEvent, NowPlayingTvState> {
  final GetNowPlayingTv getNowPlayingTv;

  NowPlayingTvBloc({
    required this.getNowPlayingTv,
  }) : super(NowPlayingTvEmpty()) {
    on<FetchNowPlayingTv>(_fetchNowPlayingTV);
  }

  void _fetchNowPlayingTV(FetchNowPlayingTv fetchNowPlayingTV,
      Emitter<NowPlayingTvState> emitter) async {
    emitter(NowPlayingTvLoading());
    final detailResult = await getNowPlayingTv.execute();
    detailResult.fold(
      (failure) => emitter(NowPlayingTvError(failure.message)),
      (data) => emitter(NowPlayingTvData(data)),
    );
  }
}
