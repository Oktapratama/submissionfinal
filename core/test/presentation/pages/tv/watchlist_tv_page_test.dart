import 'package:core/presentation/bloc/tv/watchlist_tv_bloc.dart';
import 'package:core/presentation/pages/tv/page_watchlist.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mocktail/mocktail.dart';

import '../../../dummy_data/dummy_objects.dart';
import 'watchlist_tv_page_test.mocks.dart';

void main() {
  late final MockWatchlistTvBloc mockWatchlistTvBloc;

  setUpAll(() {
    registerFallbackValue(WatchlistTVEventFake());
    registerFallbackValue(WatchlistTVStateFake());

    mockWatchlistTvBloc = MockWatchlistTvBloc();
  });

  Widget _makeTestableWidget(Widget body) {
    return BlocProvider<WatchlistTvBloc>.value(
      value: mockWatchlistTvBloc,
      child: MaterialApp(home: body),
    );
  }

  group('Watchlist TV Page', () {
    testWidgets(
        'Should display CircularProgressIndicator when state is WatchlistTVLoading',
        (WidgetTester tester) async {
      when(() => mockWatchlistTvBloc.state).thenReturn(WatchlistTvLoading());
      final circular = find.byType(CircularProgressIndicator);

      await tester.pumpWidget(_makeTestableWidget(const WatchlistTvPage()));

      expect(circular, findsOneWidget);
    });

    testWidgets('Should display ListView when state is WatchlistTVData',
        (WidgetTester tester) async {
      when(() => mockWatchlistTvBloc.state)
          .thenReturn(WatchlistTvData(testTvList));
      final list = find.byType(ListView);

      await tester.pumpWidget(_makeTestableWidget(const WatchlistTvPage()));

      expect(list, findsOneWidget);
    });

    testWidgets("Should display Text('Failed') when state is WatchlistTVError",
        (WidgetTester tester) async {
      when(() => mockWatchlistTvBloc.state)
          .thenReturn(WatchlistTvError('Failed'));
      final errorText = find.text('Failed');

      await tester.pumpWidget(_makeTestableWidget(const WatchlistTvPage()));
      expect(errorText, findsOneWidget);
    });

    testWidgets(
        "Should display Text('Watchlist is Empty') when state is WatchlistTVEmpty",
        (WidgetTester tester) async {
      when(() => mockWatchlistTvBloc.state).thenReturn(WatchlistTvEmpty());
      final empty = find.text("Watchlist is Empty");

      await tester.pumpWidget(_makeTestableWidget(const WatchlistTvPage()));
      expect(empty, findsOneWidget);
    });
  });
}
