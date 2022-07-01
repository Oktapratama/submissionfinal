import 'package:core/domain/entities/movie.dart';
import 'package:core/domain/usecases/get_popular_movies.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


part 'popular_movie_event.dart';
part 'popular_movie_state.dart';

class PopularMoviesBloc extends Bloc<PopularMoviesEvent, PopularMoviesState> {
  final GetPopularMovies getPopularMovies;

  PopularMoviesBloc({
    required this.getPopularMovies,
  }) : super(PopularMoviesEmpty()) {
    on<FetchPopularMovies>(_fetchPopularMovies);
  }

  void _fetchPopularMovies(FetchPopularMovies fetchPopularMovies,
      Emitter<PopularMoviesState> emitter) async {
    emitter(PopularMoviesLoading());
    final hasil = await getPopularMovies.execute();
    hasil.fold(
      (failure) => emitter(PopularMoviesError(failure.message)),
      (data) => emitter(PopularMoviesData(data)),
    );
  }
}
