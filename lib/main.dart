import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:isar_community/isar.dart';
import 'package:path_provider/path_provider.dart';
// import 'package:uuid/uuid.dart';
import 'package:watchlist/features/home/data/models/isar_watchlist.dart';
import 'package:watchlist/features/home/data/repositories/isar_watchlist_repo.dart';
import 'package:watchlist/features/home/domain/repositories/watchlist_repo.dart';
import 'package:watchlist/features/home/domain/entities/watch_list.dart';
import 'package:watchlist/features/home/presentation/bloc/watchlist_cubit.dart';
import 'package:watchlist/features/home/presentation/pages/home_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  WatchlistRepo watchlistRepo;

  try {
    final dir = await getApplicationDocumentsDirectory();

    final isarWatchList = await Isar.open([
      WatchlistIsarSchema,
    ], directory: dir.path);

    watchlistRepo = IsarWatchlistRepo(isarWatchList);
  } catch (e, stackTrace) {
    debugPrint("Error initializing Isar or App: $e");
    debugPrintStack(stackTrace: stackTrace);
    // Fallback to an in-memory repository so the app can still start
    watchlistRepo = InMemoryWatchlistRepo();
  }

  runApp(MainApp(watchlistMainRepo: watchlistRepo));
}

// enum WatchType { movie, song, series, anime, tvshow }

// class FutureList {
//   final String id;
//   String name;
//   String desc;
//   String type;
//   bool isCompleted;
//   FutureList({
//     required this.id,
//     required this.name,
//     this.desc = "",
//     this.isCompleted = false,
//     this.type = "Movie",
//   });
// }

class MainApp extends StatelessWidget {
  final WatchlistRepo watchlistMainRepo;

  const MainApp({super.key, required this.watchlistMainRepo});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => WatchlistCubit(watchlistMainRepo),
      child: MaterialApp(
        title: "Watchlist",
        theme: ThemeData(
          textTheme: GoogleFonts.outfitTextTheme().apply(
            fontFamilyFallback: const ['sans-serif', 'Arial'],
          ),
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        ),
        debugShowCheckedModeBanner: false,
        home: const HomeScreen(),
      ),
    );
  }
}

class InMemoryWatchlistRepo implements WatchlistRepo {
  final List<WatchList> _items = [];

  @override
  Future<void> addWatchlist(WatchList list) async {
    _items.add(list);
  }

  @override
  Future<void> deleteWatchlist(WatchList list) async {
    _items.removeWhere((i) => i.id == list.id);
  }

  @override
  Future<void> editWatchlist(WatchList list) async {
    final idx = _items.indexWhere((i) => i.id == list.id);
    if (idx != -1) _items[idx] = list;
  }

  @override
  Future<List<WatchList>> getWatchlist() async {
    return List<WatchList>.from(_items);
  }

  @override
  Future<List<WatchList>> filterWatchList(String query) async {
    if (query.isEmpty) {
      return List<WatchList>.from(_items);
    }

    // Filter the items where the name contains the search query
    final filteredList =
        _items.where((item) {
          return item.name.toLowerCase().contains(query.toLowerCase());
        }).toList();

    return filteredList;
  }
}

// class WatchlistScreen extends StatefulWidget {
//   const WatchlistScreen({super.key});

//   @override
//   State<WatchlistScreen> createState() => _WatchlistScreenState();
// }

// class _WatchlistScreenState extends State<WatchlistScreen> {
//   List<FutureList> myFutureList = [
//     FutureList(
//       id: '1',
//       name: "The Avengers - 2012",
//       desc: "Via TamilPrint",
//       type: "Movie",
//     ),
//     FutureList(
//       id: '2',
//       name: "Avengers - Doomsday",
//       desc: "In Cinemas on December 18",
//       type: "Movie",
//     ),
//     FutureList(id: '3', name: "Gypsy", desc: "In Youtube", type: "Movie"),
//     FutureList(
//       id: '4',
//       name: "Love oh Love",
//       desc: "In Youtube",
//       type: "Movie",
//     ),
//   ];
//   List<FutureList> filteredList = [];

//   @override
//   void initState() {
//     super.initState();
//     filteredList = myFutureList;
//   }

//   final TextEditingController _watchlistName = TextEditingController();
//   final TextEditingController _watchlistDesc = TextEditingController();
//   String _typeValue = "Movie";
//   final List<String> typeList = ["Movie", "Song", "Series", "Anime", "TV Show"];

//   Future<void> _showAddDialog(BuildContext context) async {
//     return showDialog(
//       context: context,
//       builder: (BuildContext context) {
//         return AlertDialog(
//           title: Text(
//             "Add New Watchlist",
//             style: TextStyle(
//               color: Colors.black,
//               fontSize: 24.0,
//               fontWeight: FontWeight.w800,
//             ),
//           ),
//           insetPadding: EdgeInsets.symmetric(horizontal: 30.0),
//           content: SizedBox(
//             width: MediaQuery.of(context).size.width,
//             child: SingleChildScrollView(
//               child: Column(
//                 mainAxisAlignment: MainAxisAlignment.start,
//                 spacing: 10.0,
//                 children: [
//                   TextField(
//                     controller: _watchlistName,
//                     autofocus: true,
//                     decoration: InputDecoration(
//                       hintText: "Enter Watchlist name",
//                       hintStyle: TextStyle(fontWeight: FontWeight.w500),
//                       border: OutlineInputBorder(
//                         borderRadius: BorderRadius.circular(8),
//                         borderSide: BorderSide(
//                           width: 0.5,
//                           color: Colors.blueAccent,
//                         ),
//                       ),
//                     ),
//                     style: TextStyle(),
//                     maxLength: 50,
//                   ),
//                   TextField(
//                     controller: _watchlistDesc,
//                     autofocus: true,
//                     decoration: InputDecoration(
//                       hintText: "Enter Description",
//                       hintStyle: TextStyle(fontWeight: FontWeight.w500),
//                       border: OutlineInputBorder(
//                         borderRadius: BorderRadius.circular(8),
//                         borderSide: BorderSide(
//                           width: 0.5,
//                           color: Colors.blueAccent,
//                         ),
//                       ),
//                     ),
//                     style: TextStyle(),
//                   ),
//                   DropdownButtonFormField<String>(
//                     value: _typeValue,
//                     items:
//                         typeList.map((String e) {
//                           return DropdownMenuItem<String>(
//                             value: e,
//                             child: Text(e),
//                           );
//                         }).toList(),
//                     onChanged: (value) {
//                       setState(() {
//                         _typeValue = value.toString();
//                       });
//                     },
//                   ),
//                 ],
//               ),
//             ),
//           ),
//           actions: [
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 ElevatedButton(
//                   onPressed: () {
//                     Navigator.pop(context);
//                     _watchlistName.text = "";
//                     _watchlistDesc.text = "";
//                     _typeValue = "Movie";
//                   },
//                   style: TextButton.styleFrom(
//                     foregroundColor: Colors.black,
//                     padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
//                     shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(8.0),
//                     ),
//                     side: BorderSide(color: Colors.grey[400]!),
//                   ),
//                   child: Text(
//                     "Cancel",
//                     style: TextStyle(
//                       fontWeight: FontWeight.w500,
//                       fontSize: 16.0,
//                       color: Colors.grey[900],
//                     ),
//                   ),
//                 ),
//                 ElevatedButton(
//                   onPressed: () {
//                     if (_watchlistName.text.isNotEmpty) {
//                       final newItem = FutureList(
//                         id: Uuid().v4(),
//                         name: _watchlistName.text,
//                         desc: _watchlistDesc.text,
//                         type: _typeValue,
//                         isCompleted: false,
//                       );
//                       Navigator.pop(context);
//                       setState(() {
//                         _filterList(_searchContoller.text.toString());
//                         myFutureList.add(newItem);
//                       });
//                       _watchlistName.text = "";
//                       _watchlistDesc.text = "";
//                       _typeValue = "Movie";
//                     }
//                   },
//                   style: TextButton.styleFrom(
//                     foregroundColor: Colors.white,
//                     backgroundColor: Colors.blue[700],
//                     padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
//                     shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(8.0),
//                     ),
//                   ),
//                   child: Text(
//                     "Create",
//                     style: TextStyle(
//                       fontWeight: FontWeight.w500,
//                       fontSize: 16.0,
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           ],
//         );
//       },
//     );
//   }

//   void _filterList(String query) {
//     List<FutureList> res = [];
//     res =
//         myFutureList.where((i) {
//           return i.name.toLowerCase().contains(query.toLowerCase()) &&
//               (_typeFilterContoller == "All" || _typeFilterContoller == i.type);
//         }).toList();

//     setState(() {
//       filteredList = res;
//     });
//   }

//   final TextEditingController _searchContoller = TextEditingController();
//   String _typeFilterContoller = "All";
//   bool _isClearHover = false;
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text(
//           "WatchList",
//           style: TextStyle(color: Colors.white, fontWeight: FontWeight.w700),
//         ),
//         toolbarHeight: 60.0,
//         backgroundColor: Colors.blueAccent,
//         titleSpacing: 24.0,
//         actions: [
//           // SizedBox(
//           //   width: 110,
//           DropdownButton<String>(
//             value: _typeFilterContoller,
//             items: [
//               const DropdownMenuItem(
//                 value: "All",
//                 child: Text("All", style: TextStyle(fontSize: 14.0)),
//               ),
//               ...typeList.map((String e) {
//                 return DropdownMenuItem<String>(
//                   value: e,
//                   child: Text(e, style: TextStyle(fontSize: 14.0)),
//                 );
//               }),
//             ],
//             onChanged: (value) {
//               setState(() {
//                 _typeFilterContoller = value.toString();
//               });
//               _filterList(_searchContoller.text.toString());
//             },
//             // decoration: InputDecoration(
//             //   border: OutlineInputBorder(borderSide: BorderSide.none),
//             // ),
//             style: GoogleFonts.outfit().apply(
//               fontFamilyFallback: const ['sans-serif', 'Arial'],
//             ),
//           ),
//           // ),
//         ],
//       ),
//       body: Column(
//         children: [
//           Padding(
//             padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
//             child: TextField(
//               controller: _searchContoller,
//               autofocus: false,
//               decoration: InputDecoration(
//                 hintText: "Search",
//                 hintStyle: TextStyle(
//                   fontWeight: FontWeight.w500,
//                   fontSize: 16.0,
//                 ),
//                 border: OutlineInputBorder(
//                   borderRadius: BorderRadius.circular(8),
//                   borderSide: BorderSide(width: 0.5, color: Colors.black),
//                 ),
//                 enabledBorder: OutlineInputBorder(
//                   borderRadius: BorderRadius.circular(8),
//                   borderSide: BorderSide(width: 0.5, color: Colors.black),
//                 ),
//                 focusedBorder: OutlineInputBorder(
//                   borderRadius: BorderRadius.circular(8),
//                   borderSide: BorderSide(width: 0.5, color: Colors.black),
//                 ),
//                 prefixIcon: Icon(Icons.search, color: Colors.grey, size: 24.0),
//                 // suffix: IconButton(
//                 //   onPressed: () {

//                 //   },
//                 //   icon: Icon(Icons.clear, size: 20.0, color: Colors.grey,),
//                 //   style: TextButton.styleFrom(
//                 //     padding: EdgeInsets.zero,
//                 //   ),
//                 //   constraints: const BoxConstraints(),
//                 //   splashRadius: 0.1,
//                 // )
//                 suffixIcon:
//                     _searchContoller.text.isNotEmpty
//                         ? MouseRegion(
//                           cursor: SystemMouseCursors.click,
//                           onEnter:
//                               (_) => {
//                                 setState(() {
//                                   _isClearHover = true;
//                                 }),
//                               },
//                           onExit: (_) {
//                             setState(() {
//                               _isClearHover = false;
//                             });
//                           },
//                           child: GestureDetector(
//                             onTap: () {
//                               _searchContoller.clear();
//                               _filterList("");
//                             },
//                             child: Icon(
//                               Icons.clear,
//                               size: 20.0,
//                               color: _isClearHover ? Colors.black : Colors.grey,
//                             ),
//                           ),
//                         )
//                         : null,
//               ),
//               onChanged: (value) {
//                 _filterList(value);
//               },
//             ),
//           ),
//           Expanded(
//             child:
//                 filteredList.isNotEmpty
//                     ? (ListView.separated(
//                       itemCount: filteredList.length,
//                       separatorBuilder:
//                           (context, index) => const SizedBox(height: 10),
//                       itemBuilder: (context, index) {
//                         final myList = filteredList[index];
//                         return Dismissible(
//                           key: Key(myList.id),
//                           // direction: DismissDirection.vertical,
//                           background: Container(
//                             // color: Colors.red,
//                             alignment: Alignment.centerRight,
//                             padding: const EdgeInsets.only(right: 20.0),
//                             decoration: BoxDecoration(
//                               borderRadius: BorderRadius.circular(8),
//                               color: Colors.red.shade600,
//                             ),
//                             child: const Icon(
//                               Icons.delete,
//                               color: Colors.white,
//                               size: 24.0,
//                             ),
//                           ),
//                           direction: DismissDirection.endToStart,
//                           confirmDismiss: (direction) async {
//                             return await showDialog<bool>(
//                                   context: context,
//                                   builder:
//                                       (context) => AlertDialog(
//                                         title: Text("Ready to delete"),
//                                         actions: [
//                                           Row(
//                                             children: [
//                                               ElevatedButton(
//                                                 onPressed: () {
//                                                   Navigator.of(
//                                                     context,
//                                                   ).pop(false);
//                                                 },
//                                                 child: Text("Cancel"),
//                                               ),
//                                               ElevatedButton(
//                                                 onPressed: () {
//                                                   Navigator.of(
//                                                     context,
//                                                   ).pop(true);
//                                                 },
//                                                 child: Text("Delete"),
//                                               ),
//                                             ],
//                                           ),
//                                         ],
//                                       ),
//                                 ) ??
//                                 false;
//                           },
//                           onDismissed: (direction) {
//                             setState(() {
//                               myFutureList.removeWhere(
//                                 (i) => i.id == myList.id,
//                               );
//                               _filterList(_searchContoller.text.toString());
//                             });
//                           },
//                           child: CheckboxListTile(
//                             value: myList.isCompleted,
//                             onChanged: (newValue) {
//                               setState(() {
//                                 myList.isCompleted = newValue ?? false;
//                               });
//                             },
//                             title: Text(
//                               myList.name,
//                               style: TextStyle(
//                                 decoration:
//                                     myList.isCompleted
//                                         ? TextDecoration.lineThrough
//                                         : TextDecoration.none,
//                                 fontWeight: FontWeight.w500,
//                               ),
//                             ),
//                             subtitle:
//                                 // myList.desc != "" ? Text('${myList.type} \u2022 ${myList.desc}') : Text(myList.type),
//                                 myList.desc != ""
//                                     ? Text.rich(
//                                       TextSpan(
//                                         children: [
//                                           TextSpan(text: myList.type),
//                                           WidgetSpan(
//                                             alignment:
//                                                 PlaceholderAlignment.middle,
//                                             child: Text(
//                                               " \u2022 ",
//                                               style: TextStyle(
//                                                 fontSize: 20.0,
//                                                 fontWeight: FontWeight.bold,
//                                               ),
//                                             ),
//                                           ),
//                                           TextSpan(text: myList.desc),
//                                         ],
//                                       ),
//                                       overflow: TextOverflow.ellipsis,
//                                       maxLines: 1,
//                                     )
//                                     : Text(myList.type),
//                             controlAffinity: ListTileControlAffinity.leading,
//                             hoverColor: Colors.blueGrey,

//                             tileColor: Colors.grey.shade100,
//                             selectedTileColor: Colors.cyan,
//                             selected: myList.isCompleted,
//                             shape: RoundedRectangleBorder(
//                               borderRadius: BorderRadius.circular(8),
//                               side: BorderSide(
//                                 width: 1,
//                                 color: Colors.blueGrey,
//                               ),
//                             ),
//                           ),
//                         );

//                         // InkWell(
//                         //   child: Padding(
//                         //     padding: const EdgeInsets.symmetric(
//                         //       horizontal: 20.0,
//                         //       vertical: 6.0,
//                         //     ),
//                         //     child: Row(
//                         //       children: [
//                         //         Checkbox(
//                         //           value: myList.isCompleted,
//                         //           onChanged: (bool? newValue) {
//                         //             setState(() {
//                         //               myList.isCompleted = newValue ?? false;
//                         //             });
//                         //           },
//                         //         ),
//                         //         Text(myList.name, style: TextStyle(decoration: myList.isCompleted ? TextDecoration.lineThrough : TextDecoration.none),),
//                         //       ],
//                         //     ),
//                         //   ),
//                         // );
//                       },
//                       padding: EdgeInsets.symmetric(
//                         horizontal: 16.0,
//                         vertical: 8.0,
//                       ),
//                     ))
//                     : Center(child: Text("No results found")),
//           ),
//         ],
//       ),
//       floatingActionButton: Semantics(
//         label: "Add WatchList",
//         child: FloatingActionButton(
//           onPressed: () {
//             // setState(() {
//             //   myFutureList.add(FutureList(name: "Hey Hi", isCompleted: false));
//             // });
//             // ScaffoldMessenger.of(context).showSnackBar(
//             //   SnackBar(content: Text("Open Dialog"))
//             // );
//             _showAddDialog(context);
//           },
//           backgroundColor: Colors.blue,
//           shape: RoundedRectangleBorder(
//             borderRadius: BorderRadius.circular(12),
//           ),
//           child: Icon(
//             Icons.add,
//             size: 32.0,
//             color: Colors.white,
//             weight: 700.0,
//           ),
//         ),
//       ),
//     );
//   }
// }
