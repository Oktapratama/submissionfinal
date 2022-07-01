part of 'tv_detail_bloc.dart';

abstract class TvDetailState extends Equatable {}

class TvDetailEmpty extends TvDetailState {
  @override
  List<Object> get props => [];
}

class TvDetailLoading extends TvDetailState {
  @override
  List<Object> get props => [];
}

class TvDetailError extends TvDetailState {
  final String message;
  TvDetailError(this.message);

  @override
  List<Object> get props => [message];
}

class TvDetailData extends TvDetailState {
  final DetailTv tvDetail;
  final List<Tv> tv;
  TvDetailData(this.tvDetail, this.tv);

  @override
  List<Object> get props => [tvDetail, tv];
}
