import 'package:flutter_test/flutter_test.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:core/presentation/bloc/tv/watchlist_tv_modify_bloc.dart';
import 'package:core/presentation/bloc/tv/tv_detail_bloc.dart';
import 'package:core/presentation/bloc/tv/watchlist_tv_status_bloc.dart';

class MockTvDetailBloc extends MockBloc<TvDetailEvent, TvDetailState>
    implements TvDetailBloc {}

class TVDetailStateFake extends Fake implements TvDetailState {}

class TVDetailEventFake extends Fake implements TvDetailEvent {}

class MockWatchlistTvModifyBloc
    extends MockBloc<WatchListTvModifyEvent, WatchListTvModifyState>
    implements WatchListTvModifyBloc {}

class WatchlistTVModifyStateFake extends Fake
    implements WatchListTvModifyState {}

class WatchlistTvModifyEventFake extends Fake
    implements WatchListTvModifyEvent {}

class MockWatchlistTvStatusBloc
    extends MockBloc<TvWatchlistStatusEvent, TvWatchlistStatusState>
    implements TvWatchlistStatusBloc {}

class WatchlistStatusStateFake extends Fake implements TvWatchlistStatusState {}

class WatchlistStatusEventFake extends Fake implements TvWatchlistStatusEvent {}
