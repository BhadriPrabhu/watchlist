import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';

void main() {
  runApp(const MainApp());
}

class FutureList {
  String name;
  bool isCompleted;
  FutureList({required this.name, this.isCompleted = false});
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(home: WatchlistScreen());
  }
}

class WatchlistScreen extends StatefulWidget {
  const WatchlistScreen({super.key});

  @override
  State<WatchlistScreen> createState() => _WatchlistScreenState();
}

class _WatchlistScreenState extends State<WatchlistScreen> {
  List<FutureList> myFutureList = [
    FutureList(name: "Spider Man"),
    FutureList(name: "Avengers"),
  ];

  final TextEditingController _watchlistName = TextEditingController();

  Future<void> _showAddDialog(BuildContext context) async {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Add new Watchlist", style: TextStyle(color: Colors.black, fontSize: 24.0, fontWeight: FontWeight.w800),),
          content: SingleChildScrollView(
            child: TextField(
              controller: _watchlistName,
              autofocus: true,
              decoration: InputDecoration(hintText: "Enter Watchlist name"),
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
                  },
                  style: TextButton.styleFrom(
                    foregroundColor: Colors.grey[800],
                    padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                  ),
                  child: Text("Cancel", style: TextStyle(fontWeight: FontWeight.w700, fontSize: 16.0, color: Colors.black),),
                ),
                ElevatedButton(
                  onPressed: () {
                    if (_watchlistName.text.isNotEmpty) {
                      setState(() {
                        myFutureList.add(
                          FutureList(
                            name: _watchlistName.text,
                            isCompleted: false,
                          ),
                        );
                      });
                      Navigator.pop(context);
                      _watchlistName.text = "";
                    }
                  },
                  style: TextButton.styleFrom(
                    foregroundColor: Colors.white,
                    backgroundColor: Colors.blue[700],
                    padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                  ),
                  child: Text("Create", style: TextStyle(fontWeight: FontWeight.w700, fontSize: 16.0),),
                ),
              ],
            ),
          ],
        );
      },
    );
  }

  // final TextEditingController _textContoller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "WatchList",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.w900),
        ),
        toolbarHeight: 50.0,
        backgroundColor: Colors.blueAccent,
      ),
      body: (ListView.builder(
        itemCount: myFutureList.length,
        itemBuilder: (context, index) {
          final myList = myFutureList[index];
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
              ),
            ),
            controlAffinity: ListTileControlAffinity.leading,
            hoverColor: Colors.blueGrey,
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
      )),
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
          child: Icon(Icons.add),
        ),
      ),
    );
  }
}
