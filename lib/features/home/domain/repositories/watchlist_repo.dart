import 'package:watchlist/features/home/domain/entities/watch_list.dart';

abstract class WatchlistRepo {
  Future<List<WatchList>> getWatchlist();

  Future<void> addWatchlist(WatchList list);

  Future<void> editWatchlist(WatchList list);

  Future<void> deleteWatchlist(WatchList list);
}