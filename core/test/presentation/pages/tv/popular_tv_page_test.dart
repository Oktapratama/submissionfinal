import 'package:core/presentation/pages/tv/page_popular.dart';
import 'package:core/presentation/bloc/tv/popular_tv_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mocktail/mocktail.dart';

import '../../../dummy_data/dummy_objects.dart';
import 'popular_tv_page_test.mocks.dart';

void main() {
  late final MockPopularTvBloc mockPopularTvBloc;

  setUpAll(() {
    registerFallbackValue(PopularTVEventFake());
    registerFallbackValue(PopularTVStateFake());

    mockPopularTvBloc = MockPopularTvBloc();
  });

  Widget _makeTestableWidget(Widget body) {
    return BlocProvider<PopularTvBloc>.value(
      value: mockPopularTvBloc,
      child: MaterialApp(home: body),
    );
  }

  group('Popular TV Page', () {
    testWidgets(
        'Should display CircularProgressIndicator when state is PopularTVLoading',
        (WidgetTester tester) async {
      when(() => mockPopularTvBloc.state).thenReturn(PopularTvLoading());
      final circular = find.byType(CircularProgressIndicator);

      await tester.pumpWidget(_makeTestableWidget(const PopularTvPage()));

      expect(circular, findsOneWidget);
    });

    testWidgets('Should display ListView when state is PopularTVData',
        (WidgetTester tester) async {
      when(() => mockPopularTvBloc.state).thenReturn(PopularTvData(testTvList));
      final list = find.byType(ListView);

      await tester.pumpWidget(_makeTestableWidget(const PopularTvPage()));

      expect(list, findsOneWidget);
    });

    testWidgets("Should display Text('Failed') when state is PopularTVError",
        (WidgetTester tester) async {
      when(() => mockPopularTvBloc.state).thenReturn(PopularTvError('Failed'));
      final errorText = find.text('Failed');

      await tester.pumpWidget(_makeTestableWidget(const PopularTvPage()));

      expect(errorText, findsOneWidget);
    });
  });
}
