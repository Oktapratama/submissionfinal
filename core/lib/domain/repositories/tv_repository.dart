import 'package:dartz/dartz.dart';
import 'package:core/utils/failure.dart';
import 'package:core/domain/entities/tv/tv.dart';
import 'package:core/domain/entities/tv/tv_detail.dart';

abstract class TvRepository {
  Future<Either<Failure, List<Tv>>> getNowPlayingTv();
  Future<Either<Failure, List<Tv>>> getPopularTv();
  Future<Either<Failure, List<Tv>>> getTopRatedTv();
  Future<Either<Failure, DetailTv>> getTvDetail(int id);
  Future<Either<Failure, List<Tv>>> getTvRecommendations(int id);
  Future<Either<Failure, List<Tv>>> searchTv(String query);
  Future<Either<Failure, String>> saveWatchlist(DetailTv tv);
  Future<Either<Failure, String>> removeWatchlist(DetailTv tv);
  Future<bool> isAddedToWatchlist(int id);
  Future<Either<Failure, List<Tv>>> getWatchlistTv();
}
