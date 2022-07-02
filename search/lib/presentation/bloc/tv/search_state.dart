part of 'search_bloc.dart';

abstract class SearchTvState extends Equatable {}

class TVSearchEmpty extends SearchTvState {
  @override
  List<Object> get props => [];
}

class TvSearchLoading extends SearchTvState {
  @override
  List<Object> get props => [];
}

class TvSearchError extends SearchTvState {
  final String pesan;

  TvSearchError(this.pesan);

  @override
  List<Object> get props => [pesan];
}

class SearchTvData extends SearchTvState {
  final List<Tv> hasil;

  SearchTvData(this.hasil);

  @override
  List<Object> get props => [hasil];
}
