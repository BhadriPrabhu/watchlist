import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  runApp(const MainApp());
}

class FutureList {
  String name;
  String desc;
  bool isCompleted;
  FutureList({required this.name, this.desc = "", this.isCompleted = false});
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Watchlist",
      theme: ThemeData(
        textTheme: GoogleFonts.outfitTextTheme(Theme.of(context).textTheme).apply(fontFamilyFallback: const ['sans-serif','Arial']),
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: WatchlistScreen(),
    );
  }
}

class WatchlistScreen extends StatefulWidget {
  const WatchlistScreen({super.key});

  @override
  State<WatchlistScreen> createState() => _WatchlistScreenState();
}

class _WatchlistScreenState extends State<WatchlistScreen> {
  List<FutureList> myFutureList = [
    FutureList(
      name: "Spider Man - Brand New Day",
      desc: "In Cinemas on July 30",
    ),
    FutureList(name: "Avengers - Doomsday", desc: "In Cinemas on December 18"),
  ];
  List<FutureList> filteredList = [];

  @override
  void initState() {
    super.initState();
    filteredList = myFutureList;
  }

  final TextEditingController _watchlistName = TextEditingController();
  final TextEditingController _watchlistDesc = TextEditingController();

  Future<void> _showAddDialog(BuildContext context) async {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            "Add New Watchlist",
            style: TextStyle(
              color: Colors.black,
              fontSize: 20.0,
              fontWeight: FontWeight.w900,
            ),
          ),
          insetPadding: EdgeInsets.symmetric(horizontal: 30.0),
          content: SizedBox(
            width: MediaQuery.of(context).size.width,
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                spacing: 10.0,
                children: [
                  TextField(
                    controller: _watchlistName,
                    autofocus: true,
                    decoration: InputDecoration(
                      hintText: "Enter Watchlist name",
                      hintStyle: TextStyle(fontWeight: FontWeight.w500),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: BorderSide(
                          width: 0.5,
                          color: Colors.blueAccent,
                        ),
                      ),
                    ),
                    style: TextStyle(),
                    maxLength: 50,
                  ),
                  TextField(
                    controller: _watchlistDesc,
                    autofocus: true,
                    decoration: InputDecoration(
                      hintText: "Enter Description",
                      hintStyle: TextStyle(fontWeight: FontWeight.w500),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: BorderSide(
                          width: 0.5,
                          color: Colors.blueAccent,
                        ),
                      ),
                    ),
                    style: TextStyle(),
                  ),
                ],
              ),
            ),
          ),
          actions: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                    _watchlistName.text = "";
                    _watchlistDesc.text = "";
                  },
                  style: TextButton.styleFrom(
                    foregroundColor: Colors.grey[800],
                    padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                  ),
                  child: Text(
                    "Cancel",
                    style: TextStyle(
                      fontWeight: FontWeight.w700,
                      fontSize: 16.0,
                      color: Colors.black,
                    ),
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    if (_watchlistName.text.isNotEmpty) {
                      setState(() {
                        myFutureList.add(
                          FutureList(
                            name: _watchlistName.text,
                            desc: _watchlistDesc.text,
                            isCompleted: false,
                          ),
                        );
                      });
                      Navigator.pop(context);
                      _watchlistName.text = "";
                      _watchlistDesc.text = "";
                    }
                  },
                  style: TextButton.styleFrom(
                    foregroundColor: Colors.white,
                    backgroundColor: Colors.blue[700],
                    padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                  ),
                  child: Text(
                    "Create",
                    style: TextStyle(
                      fontWeight: FontWeight.w700,
                      fontSize: 16.0,
                    ),
                  ),
                ),
              ],
            ),
          ],
        );
      },
    );
  }

  void _filterList(String query) {
    List<FutureList> res = [];
    if (query.isEmpty) {
      res = myFutureList;
    } else {
      res =
          myFutureList
              .where((i) => i.name.toLowerCase().contains(query.toLowerCase()))
              .toList();
    }

    setState(() {
      filteredList = res;
    });
  }

  final TextEditingController _searchContoller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "WatchList",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.w700),
        ),
        toolbarHeight: 60.0,
        backgroundColor: Colors.blueAccent,
        titleSpacing: 24.0,
      ),
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
            child: TextField(
              controller: _searchContoller,
              autofocus: true,
              decoration: InputDecoration(
                hintText: "Search",
                hintStyle: TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 16.0,
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide(width: 0.5, color: Colors.black),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide(width: 0.5, color: Colors.black),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide(width: 0.5, color: Colors.black),
                ),
                prefixIcon: Icon(Icons.search, color: Colors.grey, size: 24.0),
              ),
              onChanged: (value) {
                _filterList(value);
              },
            ),
          ),
          Expanded(
            child:
                filteredList.isNotEmpty
                    ? (ListView.separated(
                      itemCount: filteredList.length,
                      separatorBuilder:
                          (context, index) => const SizedBox(height: 10),
                      itemBuilder: (context, index) {
                        final myList = filteredList[index];
                        return CheckboxListTile(
                          value: myList.isCompleted,
                          onChanged: (newValue) {
                            setState(() {
                              myList.isCompleted = newValue ?? false;
                            });
                          },
                          title: Text(
                            myList.name,
                            style: TextStyle(
                              decoration:
                                  myList.isCompleted
                                      ? TextDecoration.lineThrough
                                      : TextDecoration.none,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          subtitle:
                              myList.desc != "" ? Text(myList.desc) : null,
                          controlAffinity: ListTileControlAffinity.leading,
                          hoverColor: Colors.blueGrey,

                          tileColor: Colors.grey.shade100,
                          selectedTileColor: Colors.cyan,
                          selected: myList.isCompleted,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                            side: BorderSide(width: 1, color: Colors.blueGrey),
                          ),
                        );
                        // InkWell(
                        //   child: Padding(
                        //     padding: const EdgeInsets.symmetric(
                        //       horizontal: 20.0,
                        //       vertical: 6.0,
                        //     ),
                        //     child: Row(
                        //       children: [
                        //         Checkbox(
                        //           value: myList.isCompleted,
                        //           onChanged: (bool? newValue) {
                        //             setState(() {
                        //               myList.isCompleted = newValue ?? false;
                        //             });
                        //           },
                        //         ),
                        //         Text(myList.name, style: TextStyle(decoration: myList.isCompleted ? TextDecoration.lineThrough : TextDecoration.none),),
                        //       ],
                        //     ),
                        //   ),
                        // );
                      },
                      padding: EdgeInsets.symmetric(
                        horizontal: 16.0,
                        vertical: 8.0,
                      ),
                    ))
                    : Center(child: Text("No results found")),
          ),
        ],
      ),
      floatingActionButton: Semantics(
        label: "Add WatchList",
        child: FloatingActionButton(
          onPressed: () {
            // setState(() {
            //   myFutureList.add(FutureList(name: "Hey Hi", isCompleted: false));
            // });
            // ScaffoldMessenger.of(context).showSnackBar(
            //   SnackBar(content: Text("Open Dialog"))
            // );
            _showAddDialog(context);
          },
          backgroundColor: Colors.blue,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          child: Icon(
            Icons.add,
            size: 32.0,
            color: Colors.white,
            weight: 700.0,
          ),
        ),
      ),
    );
  }
}
