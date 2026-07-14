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
    );
  }
}
