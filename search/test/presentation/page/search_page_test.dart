import 'package:core/domain/entities/movie.dart';
import 'package:core/domain/entities/tv/tv.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:search/presentation/bloc/movie/search_bloc.dart';
import 'package:search/presentation/bloc/tv/search_bloc.dart';
import 'package:search/presentation/pages/page_search.dart';
import 'search_page_test_mocks.dart';
import 'package:mocktail/mocktail.dart';

void main() {
  late final MockMoviesSearchBloc mockMoviesSearchBloc;
  late final MockTvSearchBloc mockTVSearchBloc;

  setUpAll(() {
    registerFallbackValue(MoviesSearchStateFake());
    registerFallbackValue(MoviesSearchEventFake());
    registerFallbackValue(TvSearchStateFake());
    registerFallbackValue(TvSearchEventFake());

    mockMoviesSearchBloc = MockMoviesSearchBloc();
    mockTVSearchBloc = MockTvSearchBloc();
  });

  Widget _makeTestableWidget(Widget body) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<MoviesSearchBloc>.value(value: mockMoviesSearchBloc),
        BlocProvider<SearchTvBloc>.value(value: mockTVSearchBloc),
      ],
      child: MaterialApp(home: body),
    );
  }

  final testMovie = Movie(
    adult: false,
    backdropPath: '/muth4OYamXf41G2evdrLEg8d3om.jpg',
    genreIds: const [14, 28],
    id: 557,
    originalTitle: 'Spider-Man',
    overview:
        'After being bitten by a genetically altered spider, nerdy high school student Peter Parker is endowed with amazing powers to become the Amazing superhero known as Spider-Man.',
    popularity: 60.441,
    posterPath: '/rweIrveL43TaxUN0akQEaAXL6x0.jpg',
    releaseDate: '2002-05-01',
    title: 'Spider-Man',
    video: false,
    voteAverage: 7.2,
    voteCount: 13507,
  );

  final testMovieList = [testMovie];

  final testTV = Tv(
      posterPath: "/y2roOFsew9nJKKVwwJCHSyzgpK9.jpg",
      popularity: 130.362,
      id: 61374,
      backdropPath: "/yOarY3Yo0NMkuTuft87M5oAZa3C.jpg",
      voteAverage: 8.5,
      overview:
      "Ken Kaneki is a bookworm college student who meets a girl names Rize at a cafe he frequents. They're the same age and have the same interests, so they quickly become close. Little does Kaneki know that Rize is a ghoul – a kind of monster that lives by hunting and devouring human flesh. When part of her special organ – \"the red child\" – is transplanted into Kaneki, he becomes a ghoul himself, trapped in a warped world where humans are not the top of the food chain.",
      originCountry: ["JP"],
      genreIds: [10759,16,18,9648],
      originalLanguage: "ja",
      voteCount: 1821,
      name: "Tokyo Ghoul",
      originalName: "東京喰種トーキョーグール");

  final testTVList = [testTV];

  group('search page', () {
    testWidgets(
        'should display CircularProgressIndicator when states is MoviesSearchLoading and TVSearchLoading',
        (WidgetTester test) async {
      when(() => mockMoviesSearchBloc.state).thenReturn(MoviesSearchLoading());
      when(() => mockTVSearchBloc.state).thenReturn(TvSearchLoading());

      final circular = find.byType(CircularProgressIndicator);
      await test.pumpWidget(_makeTestableWidget(const SearchPage()));

      final textField = find.byKey(const Key('search-textfield'));
      final queryText = find.text('superman');

      await test.enterText(textField, 'superman');
      await test.testTextInput.receiveAction(TextInputAction.search);

      expect(circular, findsOneWidget);
      expect(queryText, findsOneWidget);
    });

    testWidgets('should display ListView when result is not empty',
        (WidgetTester test) async {
      when(() => mockMoviesSearchBloc.state)
          .thenReturn(SearchMoviesData(testMovieList));
      when(() => mockTVSearchBloc.state).thenReturn(SearchTvData(testTVList));

      final listView = find.byType(ListView);
      await test.pumpWidget(_makeTestableWidget(const SearchPage()));

      expect(listView, findsOneWidget);
    });

    testWidgets(
        "should display ('Data cannot be found') when result is empty",
        (WidgetTester test) async {
      when(() => mockMoviesSearchBloc.state)
          .thenReturn(SearchMoviesData(const []));
      when(() => mockTVSearchBloc.state).thenReturn(SearchTvData(const []));

      await test.pumpWidget(_makeTestableWidget(const SearchPage()));

      final errorText = find.text('Data cannot be found at Movies or TV');
      final textField = find.byKey(const Key('search-textfield'));
      final queryText = find.text('superman');

      await test.enterText(textField, 'superman');
      await test.testTextInput.receiveAction(TextInputAction.search);

      expect(errorText, findsOneWidget);
      expect(queryText, findsOneWidget);
    });

    testWidgets(
        'should not display anything when states is MoviesSearchError and TVSearchError',
        (WidgetTester test) async {
      when(() => mockMoviesSearchBloc.state).thenReturn(MoviesSearchError(''));
      when(() => mockTVSearchBloc.state).thenReturn(TvSearchError(''));

      await test.pumpWidget(_makeTestableWidget(const SearchPage()));

      final errorText = find.byKey(const Key('search-error'));
      final textField = find.byKey(const Key('search-textfield'));
      final queryText = find.text('superman');

      await test.enterText(textField, 'superman');
      await test.testTextInput.receiveAction(TextInputAction.search);

      expect(errorText, findsOneWidget);
      expect(queryText, findsOneWidget);
    });
  });
}
