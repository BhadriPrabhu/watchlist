import 'package:isar_community/isar.dart';
import 'package:watchlist/features/home/data/models/isar_watchlist.dart';
import 'package:watchlist/features/home/domain/entities/watch_list.dart';
import 'package:watchlist/features/home/domain/repositories/watchlist_repo.dart';

class IsarWatchlistRepo implements WatchlistRepo {

  final Isar db;
  IsarWatchlistRepo(this.db);

  @override
  Future<List<WatchList>> getWatchlist() async {
    final res = await db.watchlistIsars.where().findAll();

    return res.map((e) => e.toDomain()).toList();
  }

  @override
  Future<void> addWatchlist(WatchList list) async {
    final addlist = WatchlistIsar.fromDomain(list);

    return db.writeTxn(() => db.watchlistIsars.put(addlist));
  }

  @override
  Future<void> editWatchlist(WatchList list) async {
    final editlist = WatchlistIsar.fromDomain(list);

    return db.writeTxn(() => db.watchlistIsars.put(editlist));
  }

  @override
  Future<void> deleteWatchlist(WatchList list) async {
    await db.writeTxn(() => db.watchlistIsars.delete(list.id));
  }

  @override
  Future<List<WatchList>> filterWatchList(String query) async {
    final res = await db.watchlistIsars.filter().nameContains(query, caseSensitive: false).findAll();

    return res.map((e) => e.toDomain()).toList();
  }
}