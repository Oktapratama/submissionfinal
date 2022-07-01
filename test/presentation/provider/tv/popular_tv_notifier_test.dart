import 'package:dartz/dartz.dart';
import 'package:ditonton/utils/failure.dart';
import 'package:ditonton/utils/state_enum.dart';
import 'package:ditonton/domain/entities/tv/tv.dart';
import 'package:ditonton/domain/usecases/tv/get_popular_tv.dart';
import 'package:ditonton/presentation/provider/tv/tv_popular_notifier.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'popular_tv_notifier_test.mocks.dart';

@GenerateMocks([GetPopularTv])
void main() {
  late MockGetPopularTv mockGetPopularTv;
  late PopularTvNotifier notifier;
  late int listenerCallCount;

  setUp(() {
    listenerCallCount = 0;
    mockGetPopularTv = MockGetPopularTv();
    notifier = PopularTvNotifier(mockGetPopularTv)
      ..addListener(() {
        listenerCallCount++;
      });
  });

  final HitTestBehavior = Tv(
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

  final tMovieList = <Tv>[HitTestBehavior];

  test('should change state to loading when usecase is called', () async {
    // arrange
    when(mockGetPopularTv.execute()).thenAnswer((_) async => Right(tMovieList));
    // act
    notifier.fetchPopularTv();
    // assert
    expect(notifier.state, RequestState.Loading);
    expect(listenerCallCount, 1);
  });

  test('should change movies data when data is gotten successfully', () async {
    // arrange
    when(mockGetPopularTv.execute()).thenAnswer((_) async => Right(tMovieList));
    // act
    await notifier.fetchPopularTv();
    // assert
    expect(notifier.state, RequestState.Loaded);
    expect(notifier.tv, tMovieList);
    expect(listenerCallCount, 2);
  });

  test('should return error when data is unsuccessful', () async {
    // arrange
    when(mockGetPopularTv.execute())
        .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
    // act
    await notifier.fetchPopularTv();
    // assert
    expect(notifier.state, RequestState.Error);
    expect(notifier.message, 'Server Failure');
    expect(listenerCallCount, 2);
  });
}
