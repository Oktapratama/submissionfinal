import 'package:core/domain/entities/movie.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rxdart/rxdart.dart';
import 'package:search/domain/search_movies.dart';


part 'search_event.dart';
part 'search_state.dart';

class MoviesSearchBloc extends Bloc<MoviesSearchEvent, MoviesSearchState> {
  final SearchMovies movies;

  MoviesSearchBloc({required this.movies}) : super(MoviesSearchEmpty()) {
    on<OnMoviesQueryChanged>((event, emit) async {
      final dataQuery = event.query;

      emit(MoviesSearchLoading());
      final dataResult = await movies.execute(dataQuery);

      dataResult.fold((failure) {
        emit(MoviesSearchError(failure.message));
      }, (data) {
        emit(SearchMoviesData(data));
      });
    }, transformer: _debounceMovie(const Duration(milliseconds: 500)));
  }

  EventTransformer<OnMoviesQueryChanged> _debounceMovie<OnMoviesQueryChanged>(
      Duration dur) {
    return (events, mapper) => events.debounceTime(dur).switchMap(mapper);
  }
}
