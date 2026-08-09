class WatchList {
  final int id;
  String name;
  String desc;
  String type;
  bool isCompleted;
  WatchList ({
    required this.id,
    required this.name,
    this.desc = "",
    this.isCompleted = false,
    this.type = "Movie",
  });

  WatchList watchListToggle(){
    return WatchList(id: id, name: name, desc: desc, type: type, isCompleted: !isCompleted);
  }
}