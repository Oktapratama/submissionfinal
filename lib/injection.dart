import 'dart:io';
import 'package:core/data/datasources/movie_local_data_source.dart';
import 'package:core/data/datasources/movie_remote_data_source.dart';
import 'package:core/data/datasources/tv_local_data_resource.dart';
import 'package:core/data/datasources/tv_remote_data_resource.dart';
import 'package:core/data/datasources/db/database_helper.dart';
import 'package:core/data/datasources/db/database_helper_tv.dart';
import 'package:core/data/repositories/movie_repository_impl.dart';
import 'package:core/data/repositories/tv_repository_impl.dart';
import 'package:core/domain/repositories/movie_repository.dart';
import 'package:core/domain/repositories/tv_repository.dart';
import 'package:core/domain/usecases/get_movie_detail.dart';
import 'package:core/domain/usecases/get_movie_recommendations.dart';
import 'package:core/domain/usecases/get_now_playing_movies.dart';
import 'package:core/domain/usecases/get_popular_movies.dart';
import 'package:core/domain/usecases/get_top_rated_movies.dart';
import 'package:core/domain/usecases/get_watchlist_movies.dart';
import 'package:core/domain/usecases/get_watchlist_status.dart';
import 'package:core/domain/usecases/remove_watchlist.dart';
import 'package:core/domain/usecases/save_watchlist.dart';
import 'package:core/domain/usecases/tv/get_now_playing_tv.dart';
import 'package:core/domain/usecases/tv/get_popular_tv.dart';
import 'package:core/domain/usecases/tv/get_top_rated_tv.dart';
import 'package:core/domain/usecases/tv/get_tv_detail.dart';
import 'package:core/domain/usecases/tv/get_tv_recommendations.dart';
import 'package:core/domain/usecases/tv/get_watchlist_status_tv.dart';
import 'package:core/domain/usecases/tv/get_watchlist_tv.dart';
import 'package:core/domain/usecases/tv/remove_watchlist_tv.dart';
import 'package:core/domain/usecases/tv/save_watchlist_tv.dart';
import 'package:core/presentation/bloc/movie/movie_detail_bloc.dart';
import 'package:core/presentation/bloc/movie/now_playing_movie_bloc.dart';
import 'package:core/presentation/bloc/movie/popular_movie_bloc.dart';
import 'package:core/presentation/bloc/movie/top_rated_movie_bloc.dart';
import 'package:core/presentation/bloc/movie/watchlist_movie_bloc.dart';
import 'package:core/presentation/bloc/movie/watchlist_movie_modify_bloc.dart';
import 'package:core/presentation/bloc/movie/watchlist_movie_status_bloc.dart';
import 'package:core/presentation/bloc/tv/now_playing_tv_bloc.dart';
import 'package:core/presentation/bloc/tv/popular_tv_bloc.dart';
import 'package:core/presentation/bloc/tv/top_rated_tv_bloc.dart';
import 'package:core/presentation/bloc/tv/tv_detail_bloc.dart';
import 'package:core/presentation/bloc/tv/watchlist_tv_bloc.dart';
import 'package:core/presentation/bloc/tv/watchlist_tv_modify_bloc.dart';
import 'package:core/presentation/bloc/tv/watchlist_tv_status_bloc.dart';
import 'package:http/http.dart' as http;
import 'package:get_it/get_it.dart';
import 'package:search/domain/search_movies.dart';
import 'package:search/domain/search_tv.dart';
import 'package:search/presentation/bloc/movie/search_bloc.dart';
import 'package:search/presentation/bloc/tv/search_bloc.dart';


final locator = GetIt.instance;

void init(HttpClient httpClient) {
  // provider movie

  locator.registerFactory(
          () => NowPlayingMoviesBloc(
          getNowPlayingMovies: locator()));
  locator.registerFactory(
          () => PopularMoviesBloc(
          getPopularMovies: locator()));
  locator.registerFactory(
          () => TopRatedMoviesBloc(
          getTopRatedMovies: locator()));
  locator.registerFactory(
          () => MovieDetailBloc(
          getMovieDetail: locator(), getMovieRecommendations: locator()));
  locator.registerFactory(
          () => WatchListMoviesModifyBloc(
          saveWatchlist: locator(), removeWatchlist: locator()));
  locator.registerFactory(
          () => WatchListStatusBloc(
          getWatchListStatus: locator()));
  locator.registerFactory(
          () => WatchlistMoviesBloc(
          getWatchlistMovies: locator()));
  locator.registerFactory(
          () => MoviesSearchBloc(movies: locator()));


  // provider tv
  locator.registerFactory(
          () => NowPlayingTvBloc(
          getNowPlayingTv: locator()));
  locator.registerFactory(
          () => PopularTvBloc(
          getPopularTv: locator()));
  locator.registerFactory(
          () => TopRatedTvBloc(
          getTopTv: locator()));
  locator.registerFactory(
          () =>TvDetailBloc(
          getTvDetail: locator(),
          getTvRecommendations: locator()));
  locator.registerFactory(
          () => WatchListTvModifyBloc(
          saveWatchlist: locator(),
          removeWatchlist: locator()));
  locator.registerFactory(
          () => TvWatchlistStatusBloc(
          getTvWatchlistStatus: locator()));
  locator.registerFactory(
          () => WatchlistTvBloc(
          getWatchlistTv: locator()));
  locator.registerFactory(
          () => TvSearchBloc(
          tv: locator()));



  // use case movie
  locator.registerLazySingleton(() => GetNowPlayingMovies(locator()));
  locator.registerLazySingleton(() => GetPopularMovies(locator()));
  locator.registerLazySingleton(() => GetTopRatedMovies(locator()));
  locator.registerLazySingleton(() => GetMovieDetail(locator()));
  locator.registerLazySingleton(() => GetMovieRecommendations(locator()));
  locator.registerLazySingleton(() => SearchMovies(locator()));
  locator.registerLazySingleton(() => GetWatchListStatus(locator()));
  locator.registerLazySingleton(() => SaveWatchlist(locator()));
  locator.registerLazySingleton(() => RemoveWatchlist(locator()));
  locator.registerLazySingleton(() => GetWatchlistMovies(locator()));

  // use case tv
  locator.registerLazySingleton(() => GetNowPlayingTv(locator()));
  locator.registerLazySingleton(() => GetPopularTv(locator()));
  locator.registerLazySingleton(() => GetTopRatedTv(locator()));
  locator.registerLazySingleton(() => GetTvDetail(locator()));
  locator.registerLazySingleton(() => GetTvRecommendations(locator()));
  locator.registerLazySingleton(() => SearchTv(locator()));
  locator.registerLazySingleton(() => GetWatchListStatusTv(locator()));
  locator.registerLazySingleton(() => SaveWatchlistTv(locator()));
  locator.registerLazySingleton(() => RemoveWatchlistTv(locator()));
  locator.registerLazySingleton(() => GetWatchlistTv(locator()));

  // repository movie
  locator.registerLazySingleton<MovieRepository>(
        () => MovieRepositoryImpl(
      remoteDataSource: locator(),
      localDataSource: locator(),
    ),
  );

  // repository tv
  locator.registerLazySingleton<TvRepository>(
        () => TvRepositoryImpl(
      remoteDataSource: locator(),
      localDataSourceTv: locator(),
    ),
  );

  // data sources movie
  locator.registerLazySingleton<MovieRemoteDataSource>(
          () => MovieRemoteDataSourceImpl(client: locator()));
  locator.registerLazySingleton<MovieLocalDataSource>(
          () => MovieLocalDataSourceImpl(databaseHelper: locator()));

  // data sources tv
  locator.registerLazySingleton<TvRemoteDataSource>(
          () => TvRemoteDataSourceImpl(client: locator()));
  locator.registerLazySingleton<TvLocalDataSource>(
          () => TvLocalDataSourceImpl(databaseHelper: locator()));

  // helper movie
  locator.registerLazySingleton<DatabaseHelper>(() => DatabaseHelper());

  // helper tv
  locator.registerLazySingleton<DatabaseHelperTv>(() => DatabaseHelperTv());

  // external
  locator.registerLazySingleton(() => http.Client());
}

