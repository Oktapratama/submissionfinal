part of 'search_bloc.dart';

abstract class TvSearchState extends Equatable {}

class TVSearchEmpty extends TvSearchState {
  @override
  List<Object> get props => [];
}

class TvSearchLoading extends TvSearchState {
  @override
  List<Object> get props => [];
}

class TvSearchError extends TvSearchState {
  final String pesan;

  TvSearchError(this.pesan);

  @override
  List<Object> get props => [pesan];
}

class SearchTvData extends TvSearchState {
  final List<Tv> hasil;

  SearchTvData(this.hasil);

  @override
  List<Object> get props => [hasil];
}
