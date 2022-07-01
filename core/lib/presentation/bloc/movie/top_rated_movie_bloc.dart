import 'package:core/domain/entities/movie.dart';
import 'package:core/domain/usecases/get_top_rated_movies.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


part 'top_rated_movie_event.dart';
part 'top_rated_movie_state.dart';

class TopRatedMoviesBloc
    extends Bloc<TopRatedMoviesEvent, TopRatedMoviesState> {
  final GetTopRatedMovies getTopRatedMovies;

  TopRatedMoviesBloc({
    required this.getTopRatedMovies,
  }) : super(TopRatedMoviesEmpty()) {
    on<FetchTopRatedMovies>(_fetchTopRatedMovies);
  }

  void _fetchTopRatedMovies(FetchTopRatedMovies fetchTopRatedMovies,
      Emitter<TopRatedMoviesState> emitter) async {
    emitter(TopRatedMoviesLoading());
    final hasil = await getTopRatedMovies.execute();
    hasil.fold(
      (failure) => emitter(TopRatedMoviesError(failure.message)),
      (data) => emitter(TopRatedMoviesData(data)),
    );
  }
}
