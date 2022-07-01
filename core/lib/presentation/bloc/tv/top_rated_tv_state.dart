part of 'top_rated_tv_bloc.dart';

abstract class TopTvState extends Equatable {}

class TopTvEmpty extends TopTvState {
  @override
  List<Object> get props => [];
}

class TopTvLoading extends TopTvState {
  @override
  List<Object> get props => [];
}

class TopTvError extends TopTvState {
  final String message;
  TopTvError(this.message);

  @override
  List<Object> get props => [message];
}

class TopTvData extends TopTvState {
  final List<Tv> tv;
  TopTvData(this.tv);

  @override
  List<Object> get props => [tv];
}
