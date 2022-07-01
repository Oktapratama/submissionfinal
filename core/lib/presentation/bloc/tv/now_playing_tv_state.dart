part of 'now_playing_tv_bloc.dart';

abstract class NowPlayingTvState extends Equatable {}

class NowPlayingTvEmpty extends NowPlayingTvState {
  @override
  List<Object> get props => [];
}

class NowPlayingTvLoading extends NowPlayingTvState {
  @override
  List<Object> get props => [];
}

class NowPlayingTvError extends NowPlayingTvState {
  final String message;
  NowPlayingTvError(this.message);

  @override
  List<Object> get props => [message];
}

class NowPlayingTvData extends NowPlayingTvState {
  final List<Tv> tv;
  NowPlayingTvData(this.tv);

  @override
  List<Object> get props => [tv];
}
