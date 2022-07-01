import 'package:core/domain/entities/movie_detail.dart';
import 'package:core/domain/usecases/remove_watchlist.dart';
import 'package:core/domain/usecases/save_watchlist.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'watchlist_movie_modify_event.dart';
part 'watchlist_movie_modify_state.dart';

class WatchListMoviesModifyBloc
    extends Bloc<WatchListMoviesModifyEvent, WatchListMoviesModifyState> {
  final SaveWatchlist saveWatchlist;
  final RemoveWatchlist removeWatchlist;

  WatchListMoviesModifyBloc({
    required this.saveWatchlist,
    required this.removeWatchlist,
  }) : super(WatchListMoviesModifyEmpty()) {
    on<AddMovie>(_addWatchlist);
    on<RemoveMovie>(_removeWatchlist);
  }

  void _addWatchlist(
      AddMovie movie, Emitter<WatchListMoviesModifyState> emitter) async {
    emitter(WatchListMoviesModifyLoading());
    final result = await saveWatchlist.execute(movie.movieDetail);

    result.fold(
      (failure) => emitter(WatchListMoviesModifyError(failure.message)),
      (success) => emitter(MovieAdd(success)),
    );
  }

  void _removeWatchlist(
      RemoveMovie movie, Emitter<WatchListMoviesModifyState> emitter) async {
    emitter(WatchListMoviesModifyLoading());
    final result = await removeWatchlist.execute(movie.movieDetail);

    result.fold(
      (failure) => emitter(WatchListMoviesModifyError(failure.message)),
      (success) => emitter(MovieRemove(success)),
    );
  }
}
