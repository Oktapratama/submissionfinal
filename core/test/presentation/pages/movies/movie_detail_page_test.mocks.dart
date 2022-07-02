import 'package:flutter_test/flutter_test.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:core/presentation/bloc/movie/watchlist_movie_modify_bloc.dart';
import 'package:core/presentation/bloc/movie/movie_detail_bloc.dart';
import 'package:core/presentation/bloc/movie/watchlist_movie_status_bloc.dart';

class MockMovieDetailBloc extends MockBloc<MovieDetailEvent, MovieDetailState>
    implements MovieDetailBloc {}

class MovieDetailStateFake extends Fake implements MovieDetailState {}

class MovieDetailEventFake extends Fake implements MovieDetailEvent {}

class MockWatchListMoviesModifyBloc
    extends MockBloc<WatchListMoviesModifyEvent, WatchListMoviesModifyState>
    implements WatchListMoviesModifyBloc {}

class WatchlistMovieModifyStateFake extends Fake
    implements WatchListMoviesModifyState {}

class WatchlistMovieModifyEventFake extends Fake
    implements WatchListMoviesModifyEvent {}

class MockWatchlistMoviesStatusBloc
    extends MockBloc<WatchListStatusEvent, WatchListStatusState>
    implements WatchListStatusBloc {}

class WatchlistStatusStateFake extends Fake implements WatchListStatusState {}

class WatchlistStatusEventFake extends Fake implements WatchListStatusEvent {}
