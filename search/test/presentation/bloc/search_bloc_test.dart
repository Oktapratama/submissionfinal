import 'package:core/domain/entities/movie.dart';
import 'package:core/domain/entities/tv/tv.dart';
import 'package:dartz/dartz.dart';
import 'package:core/utils/failure.dart';
import 'package:search/domain/search_movies.dart';
import 'package:search/domain/search_tv.dart';
import 'package:search/presentation/bloc/movie/search_bloc.dart';
import 'package:search/presentation/bloc/tv/search_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'search_bloc_test.mocks.dart';

@GenerateMocks([SearchMovies, SearchTv])
void main() {
  late MoviesSearchBloc moviesSearchBloc;
  late SearchTvBloc tvSearchBloc;
  late MockSearchMovies mockSearchMovies;
  late MockSearchTV mockSearchTV;

  setUp(() {
    mockSearchMovies = MockSearchMovies();
    mockSearchTV = MockSearchTV();
    moviesSearchBloc = MoviesSearchBloc(movies: mockSearchMovies);
    tvSearchBloc = SearchTvBloc(tv: mockSearchTV);
  });

  final tMovieModel = Movie(
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
  final tMovieList = <Movie>[tMovieModel];
  const tQueryMovie = 'spiderman';

  final tTVModel = Tv(
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
  final tTVList = <Tv>[tTVModel];
  const tQueryTV = 'Game of Thrones';

  group('search movies', () {
    test('initial state should be empty', () {
      expect(moviesSearchBloc.state, MoviesSearchEmpty());
    });
    blocTest<MoviesSearchBloc, MoviesSearchState>(
        'should emit [Loading, Data] when data is gotten successfully',
        build: () {
          when(mockSearchMovies.execute(tQueryMovie))
              .thenAnswer((_) async => Right(tMovieList));
          return moviesSearchBloc;
        },
        act: (bloc) => bloc.add(OnMoviesQueryChanged(tQueryMovie)),
        wait: const Duration(milliseconds: 500),
        expect: () => [MoviesSearchLoading(), SearchMoviesData(tMovieList)],
        verify: (bloc) => verify(mockSearchMovies.execute(tQueryMovie)));

    blocTest<MoviesSearchBloc, MoviesSearchState>(
        'should emit [Loading, Error] when data search is unsuccessful',
        build: () {
          when(mockSearchMovies.execute(tQueryMovie))
              .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
          return moviesSearchBloc;
        },
        act: (bloc) => bloc.add(OnMoviesQueryChanged(tQueryMovie)),
        wait: const Duration(milliseconds: 500),
        expect: () =>
            [MoviesSearchLoading(), MoviesSearchError('Server Failure')],
        verify: (bloc) => verify(mockSearchMovies.execute(tQueryMovie)));
  });

  group('search tv', () {
    test('initial state should be empty', () {
      expect(tvSearchBloc.state, TVSearchEmpty());
    });
    blocTest<SearchTvBloc, SearchTvState>(
        'should emit [Loading, Data] when data is gotten successfully',
        build: () {
          when(mockSearchTV.execute(tQueryTV))
              .thenAnswer((_) async => Right(tTVList));
          return tvSearchBloc;
        },
        act: (bloc) => bloc.add(OnTvQueryChanged(tQueryTV)),
        wait: const Duration(milliseconds: 500),
        expect: () => [TvSearchLoading(), SearchTvData(tTVList)],
        verify: (bloc) => verify(mockSearchTV.execute(tQueryTV)));

    blocTest<SearchTvBloc, SearchTvState>(
        'should emit [Loading, Error] when data search is unsuccessful',
        build: () {
          when(mockSearchTV.execute(tQueryTV))
              .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
          return tvSearchBloc;
        },
        act: (bloc) => bloc.add(OnTvQueryChanged(tQueryTV)),
        wait: const Duration(milliseconds: 500),
        expect: () => [TvSearchLoading(), TvSearchError('Server Failure')],
        verify: (bloc) => verify(mockSearchTV.execute(tQueryTV)));
  });
}
