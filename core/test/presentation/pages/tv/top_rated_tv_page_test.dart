import 'package:core/presentation/bloc/tv/top_rated_tv_bloc.dart';
import 'package:core/presentation/pages/tv/page_top_rated.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mocktail/mocktail.dart';

import '../../../dummy_data/dummy_objects.dart';
import 'top_rated_tv_page_test.mocks.dart';

void main() {
  late final MockTopTvBloc mockTopTvBloc;

  setUpAll(() {
    registerFallbackValue(TopRatedTVEventFake());
    registerFallbackValue(TopRatedTVStateFake());

    mockTopTvBloc = MockTopTvBloc();
  });

  Widget _makeTestableWidget(Widget body) {
    return BlocProvider<TopRatedTvBloc>.value(
      value: mockTopTvBloc,
      child: MaterialApp(home: body),
    );
  }

  group('Top Rated TV Page', () {
    testWidgets(
        'Should display CircularProgressIndicator when state is TopRatedTVLoading',
        (WidgetTester tester) async {
      when(() => mockTopTvBloc.state).thenReturn(TopTvLoading());
      final circular = find.byType(CircularProgressIndicator);

      await tester.pumpWidget(_makeTestableWidget(const TopTvPage()));

      expect(circular, findsOneWidget);
    });

    testWidgets('Should display ListView when state is TopRatedTVData',
        (WidgetTester tester) async {
      when(() => mockTopTvBloc.state)
          .thenReturn(TopTvData(testTvList));
      final list = find.byType(ListView);

      await tester.pumpWidget(_makeTestableWidget(const TopTvPage()));

      expect(list, findsOneWidget);
    });

    testWidgets("Should display Text('Failed') when state is TopRatedTVError",
        (WidgetTester tester) async {
      when(() => mockTopTvBloc.state)
          .thenReturn(TopTvError('Failed'));
      final errorText = find.text('Failed');

      await tester.pumpWidget(_makeTestableWidget(const TopTvPage()));

      expect(errorText, findsOneWidget);
    });
  });
}
