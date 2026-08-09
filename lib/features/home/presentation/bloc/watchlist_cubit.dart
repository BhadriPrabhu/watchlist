import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:watchlist/features/home/domain/entities/watch_list.dart';
import 'package:watchlist/features/home/domain/repositories/watchlist_repo.dart';

class WatchlistCubit extends Cubit<List<WatchList>> {
  final WatchlistRepo watchListRepo;

  WatchlistCubit(this.watchListRepo) : super([]) {
    loadList();
  }

  Future<void> loadList() async {
    final list = await watchListRepo.getWatchlist();

    emit(list);
  }

  Future<void> addTask(WatchList newList) async {
    final newWatch = WatchList(id: DateTime.now().millisecondsSinceEpoch, name: newList.name, desc: newList.desc, type: newList.type, isCompleted: false);

    await watchListRepo.addWatchlist(newWatch);

    loadList();
  }

  Future<void> deleteTask(WatchList newList) async {
    await watchListRepo.deleteWatchlist(newList);

    loadList();
  }

  Future<void> toggleTask(WatchList newList) async {
    final updateWatchlist = newList.watchListToggle();

    await watchListRepo.editWatchlist(updateWatchlist);

    loadList();
  }
}