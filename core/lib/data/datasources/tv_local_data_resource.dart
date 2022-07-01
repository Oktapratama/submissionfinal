import '../../utils/exception.dart';
import '../models/tv/tv_table.dart';
import 'db/database_helper_tv.dart';

abstract class TvLocalDataSource {
  Future<String> insertWatchlistTv(TableTv tv);
  Future<String> removeWatchlistTv(TableTv tv);
  Future<TableTv?> getTvById(int id);
  Future<List<TableTv>> getWatchlistTv();
}

class TvLocalDataSourceImpl implements TvLocalDataSource {
  final DatabaseHelperTv databaseHelper;

  TvLocalDataSourceImpl({required this.databaseHelper});

  @override
  Future<String> insertWatchlistTv(TableTv tv) async {
    try {
      await databaseHelper.insertWatchlistTv(tv);
      return 'Added to Watchlist';
    } catch (e) {
      throw DatabaseException(e.toString());
    }
  }

  @override
  Future<String> removeWatchlistTv(TableTv tv) async {
    try {
      await databaseHelper.removeWatchlistTv(tv);
      return 'Removed from Watchlist';
    } catch (e) {
      throw DatabaseException(e.toString());
    }
  }

  @override
  Future<TableTv?> getTvById(int id) async {
    final result = await databaseHelper.getTvById(id);
    if (result != null) {
      return TableTv.fromMap(result);
    } else {
      return null;
    }
  }

  @override
  Future<List<TableTv>> getWatchlistTv() async {
    final result = await databaseHelper.getWatchlistTv();
    return result.map((data) => TableTv.fromMap(data)).toList();
  }
}