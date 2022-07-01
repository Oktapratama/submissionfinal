import 'package:dartz/dartz.dart';
import '../../../utils/failure.dart';
import '../../entities/tv/tv.dart';
import '../../repositories/tv_repository.dart';

class GetWatchlistTv {
  final TvRepository _repository;
  GetWatchlistTv(this._repository);
  Future<Either<Failure, List<Tv>>> execute() {
    return _repository.getWatchlistTv();
  }
}