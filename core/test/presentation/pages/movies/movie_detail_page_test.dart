import 'package:core/core.dart';
import 'package:core/presentation/pages/movie_detail_page.dart';
import 'package:core/presentation/bloc/movie/movie_detail_bloc.dart';
import 'package:core/presentation/bloc/movie/watchlist_movie_status_bloc.dart';
import 'package:core/presentation/bloc/movie/watchlist_movie_modify_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mocktail/mocktail.dart';

import '../../../dummy_data/dummy_objects.dart';
import 'movie_detail_page_test.mocks.dart';

void main() {
  late MockWatchlistMoviesStatusBloc mockWatchlistMoviesStatusBloc;
  late MockWatchListMoviesModifyBloc mockWatchlistMoviesModifyBloc;
  late MockMovieDetailBloc mockMovieDetailBloc;

  setUpAll(() {
    registerFallbackValue(WatchlistStatusStateFake());
    registerFallbackValue(WatchlistStatusEventFake());
    registerFallbackValue(WatchlistMovieModifyStateFake());
    registerFallbackValue(WatchlistMovieModifyEventFake());
    registerFallbackValue(MovieDetailStateFake());
    registerFallbackValue(MovieDetailEventFake());

    mockWatchlistMoviesStatusBloc = MockWatchlistMoviesStatusBloc();
    mockWatchlistMoviesModifyBloc = MockWatchListMoviesModifyBloc();
    mockMovieDetailBloc = MockMovieDetailBloc();
  });

  Widget _makeTestableWidget(Widget body) {
    return BlocProvider<WatchListStatusBloc>.value(
      value: mockWatchlistMoviesStatusBloc,
      child: BlocProvider<WatchListMoviesModifyBloc>.value(
        value: mockWatchlistMoviesModifyBloc,
        child: BlocProvider<MovieDetailBloc>.value(
          value: mockMovieDetailBloc,
          child: MaterialApp(
            home: body,
            theme: ThemeData.dark().copyWith(
              primaryColor: kRichBlack,
              scaffoldBackgroundColor: kRichBlack,
              textTheme: kTextTheme,
              colorScheme: kColorScheme.copyWith(secondary: kMikadoYellow),
            ),
          ),
        ),
      ),
    );
  }

  const id = 1;

  group('Detail Movie Page', () {
    testWidgets(
        'should display CircularProgressIndicator when state is MovieDetailLoading',
        (WidgetTester tester) async {
      when(() => mockMovieDetailBloc.state).thenReturn(MovieDetailLoading());
      when(() => mockWatchlistMoviesStatusBloc.state)
          .thenReturn(WatchListStatusEmpty());
      when(() => mockWatchlistMoviesModifyBloc.state)
          .thenReturn(WatchListMoviesModifyEmpty());
      final circular = find.byType(CircularProgressIndicator);

      await tester
          .pumpWidget(_makeTestableWidget(const MovieDetailPage(id: id)));

      expect(circular, findsOneWidget);
    });

    testWidgets('should display Text when state is MovieDetailError',
        (WidgetTester tester) async {
      when(() => mockMovieDetailBloc.state)
          .thenReturn(MovieDetailError('Failed'));
      when(() => mockWatchlistMoviesStatusBloc.state)
          .thenReturn(WatchListStatusEmpty());
      when(() => mockWatchlistMoviesModifyBloc.state)
          .thenReturn(WatchListMoviesModifyEmpty());
      final error = find.text('Failed');

      await tester
          .pumpWidget(_makeTestableWidget(const MovieDetailPage(id: id)));

      expect(error, findsOneWidget);
    });

    testWidgets(
        'should display Icon Check when state is MovieDetailData and MovieStatusState(true)',
        (WidgetTester tester) async {
      when(() => mockMovieDetailBloc.state)
          .thenReturn(MovieDetailData(testMovieDetail, testMovieList));
      when(() => mockWatchlistMoviesStatusBloc.state)
          .thenReturn(MovieStatusState(true));
      when(() => mockWatchlistMoviesModifyBloc.state)
          .thenReturn(WatchListMoviesModifyEmpty());
      final iconCheck = find.byIcon(Icons.check);

      await tester
          .pumpWidget(_makeTestableWidget(const MovieDetailPage(id: id)));

      expect(iconCheck, findsOneWidget);
    });

    testWidgets(
        'should display Icon Add when state is MovieDetailData and MovieStatusState(false)',
        (WidgetTester tester) async {
      when(() => mockMovieDetailBloc.state)
          .thenReturn(MovieDetailData(testMovieDetail, testMovieList));
      when(() => mockWatchlistMoviesStatusBloc.state)
          .thenReturn(MovieStatusState(false));
      when(() => mockWatchlistMoviesModifyBloc.state)
          .thenReturn(WatchListMoviesModifyEmpty());
      final iconAdd = find.byIcon(Icons.add);

      await tester
          .pumpWidget(_makeTestableWidget(const MovieDetailPage(id: id)));

      expect(iconAdd, findsOneWidget);
    });
  });
}
