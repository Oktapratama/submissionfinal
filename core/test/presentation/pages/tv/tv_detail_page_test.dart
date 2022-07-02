import 'package:core/core.dart';
import 'package:core/presentation/pages/tv/page_detail.dart';
import 'package:core/presentation/bloc/tv/tv_detail_bloc.dart';
import 'package:core/presentation/bloc/tv/watchlist_tv_status_bloc.dart';
import 'package:core/presentation/bloc/tv/watchlist_tv_modify_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../../dummy_data/dummy_objects.dart';
import 'tv_detail_page_test.mocks.dart';

void main() {
  late MockWatchlistTvStatusBloc mockWatchlistTvStatusBloc;
  late MockWatchlistTvModifyBloc mockWatchlistTvModifyBloc;
  late MockTvDetailBloc mockTvDetailBloc;

  setUpAll(() {
    registerFallbackValue(WatchlistStatusStateFake());
    registerFallbackValue(WatchlistStatusEventFake());
    registerFallbackValue(WatchlistTVModifyStateFake());
    registerFallbackValue(WatchlistTvModifyEventFake());
    registerFallbackValue(TVDetailStateFake());
    registerFallbackValue(TVDetailEventFake());
  });

  setUp(() {
    mockWatchlistTvStatusBloc = MockWatchlistTvStatusBloc();
    mockWatchlistTvModifyBloc = MockWatchlistTvModifyBloc();
    mockTvDetailBloc = MockTvDetailBloc();
  });

  Widget _makeTestableWidget(Widget body) {
    return BlocProvider<TvWatchlistStatusBloc>.value(
      value: mockWatchlistTvStatusBloc,
      child: BlocProvider<WatchListTvModifyBloc>.value(
        value: mockWatchlistTvModifyBloc,
        child: BlocProvider<TvDetailBloc>.value(
          value: mockTvDetailBloc,
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

  group('Detail TV Page', () {
    testWidgets(
        'Should display CircularProgressIndicator when state is TVDetailLoading',
        (WidgetTester tester) async {
      when(() => mockTvDetailBloc.state).thenReturn(TvDetailLoading());
      when(() => mockWatchlistTvStatusBloc.state)
          .thenReturn(TvWatchlistStatusEmpty());
      when(() => mockWatchlistTvModifyBloc.state)
          .thenReturn(WatchListTVModifyEmpty());

      final circular = find.byType(CircularProgressIndicator);

      await tester.pumpWidget(_makeTestableWidget(const TvDetailPage(id: id)));

      expect(circular, findsOneWidget);
    });

    testWidgets('Should display Text when state is TVDetailError',
        (WidgetTester tester) async {
      when(() => mockTvDetailBloc.state).thenReturn(TvDetailError('Failed'));
      when(() => mockWatchlistTvStatusBloc.state)
          .thenReturn(TvWatchlistStatusEmpty());
      when(() => mockWatchlistTvModifyBloc.state)
          .thenReturn(WatchListTVModifyEmpty());

      final errorText = find.text('Failed');

      await tester.pumpWidget(_makeTestableWidget(const TvDetailPage(id: id)));

      expect(errorText, findsOneWidget);
    });

    testWidgets(
        'Should display Icon Check when state is TVDetailData and TVStatusState(true)',
        (WidgetTester tester) async {
      when(() => mockTvDetailBloc.state)
          .thenReturn(TvDetailData(testTvDetail, testTvList));
      when(() => mockWatchlistTvStatusBloc.state)
          .thenReturn(TvStatusState(true));
      when(() => mockWatchlistTvModifyBloc.state)
          .thenReturn(WatchListTVModifyEmpty());
      final iconCheck = find.byIcon(Icons.check);

      await tester.pumpWidget(_makeTestableWidget(const TvDetailPage(id: id)));

      expect(iconCheck, findsOneWidget);
    });

    testWidgets(
        'Should display Icon Add when state is TVDetailData and TVStatusState(false)',
        (WidgetTester tester) async {
      when(() => mockTvDetailBloc.state)
          .thenReturn(TvDetailData(testTvDetail, testTvList));
      when(() => mockWatchlistTvStatusBloc.state)
          .thenReturn(TvStatusState(false));
      when(() => mockWatchlistTvModifyBloc.state)
          .thenReturn(WatchListTVModifyEmpty());
      final iconAdd = find.byIcon(Icons.add);

      await tester.pumpWidget(_makeTestableWidget(const TvDetailPage(id: id)));

      expect(iconAdd, findsOneWidget);
    });
  });
}
