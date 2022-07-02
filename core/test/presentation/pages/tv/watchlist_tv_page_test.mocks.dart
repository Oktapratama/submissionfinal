import 'package:flutter_test/flutter_test.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:core/presentation/bloc/tv/watchlist_tv_bloc.dart';

class MockWatchlistTvBloc extends MockBloc<WatchlistTvEvent, WatchlistTvState>
    implements WatchlistTvBloc {}

class WatchlistTVStateFake extends Fake implements WatchlistTvState {}

class WatchlistTVEventFake extends Fake implements WatchlistTvEvent {}
