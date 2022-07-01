import 'package:core/domain/entities/tv/tv.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../domain/usecases/tv/get_watchlist_tv.dart';

part 'watchlist_tv_event.dart';
part 'watchlist_tv_state.dart';

class WatchlistTvBloc extends Bloc <WatchlistTvEvent, WatchlistTvState> {
  final GetWatchlistTv getWatchlistTv;

  WatchlistTvBloc({
    required this.getWatchlistTv,
  }) : super(WatchlistTvEmpty()) {
    on<FetchWatchlistTv>(_fetchWatchlistTv);
  }

  void _fetchWatchlistTv(FetchWatchlistTv fetchWatchlistTV,
      Emitter<WatchlistTvState> emitter) async {
    emitter(WatchlistTvLoading());
    final hasil = await getWatchlistTv.execute();
    hasil.fold(
      (failure) => emitter(WatchlistTvError(failure.message)),
      (data) => data.isNotEmpty
          ? emitter(WatchlistTvData(data))
          : emitter(WatchlistTvEmpty()),
    );
  }
}
