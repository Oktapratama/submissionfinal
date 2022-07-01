part of 'search_bloc.dart';

abstract class MoviesSearchEvent extends Equatable {}

class OnMoviesQueryChanged extends MoviesSearchEvent {
  final String query;

  OnMoviesQueryChanged(this.query);

  @override
  List<Object> get props => [query];
}
