part of 'search_bloc.dart';

abstract class SearchTvEvent extends Equatable {}

class OnTvQueryChanged extends SearchTvEvent {
  final String query;

  OnTvQueryChanged(this.query);

  @override
  List<Object> get props => [query];
}
