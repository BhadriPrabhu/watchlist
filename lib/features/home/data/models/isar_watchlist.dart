import 'package:isar_community/isar.dart';
import 'package:watchlist/features/home/domain/entities/watch_list.dart';

part 'isar_watchlist.g.dart';

@collection
class WatchlistIsar {
  Id id = Isar.autoIncrement;
  late String name;
  late String desc;
  late String type;
  late bool isCompleted;

  WatchList toDomain(){
    return WatchList(id: id, name: name, desc: desc, type: type, isCompleted: isCompleted);
  }

  static WatchlistIsar fromDomain(WatchList watchlist){
    final modelIsar = WatchlistIsar()
    ..name = watchlist.name
    ..desc = watchlist.desc
    ..type = watchlist.type
    ..isCompleted = watchlist.isCompleted;

    if(watchlist.id != 0){
      modelIsar.id = watchlist.id;
    }
    return modelIsar;

  }
}