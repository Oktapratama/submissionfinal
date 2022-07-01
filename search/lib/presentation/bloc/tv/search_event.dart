part of 'search_bloc.dart';

abstract class TvSearchEvent extends Equatable {}

class OnTvQueryChanged extends TvSearchEvent {
  final String query;

  OnTvQueryChanged(this.query);

  @override
  List<Object> get props => [query];
}
