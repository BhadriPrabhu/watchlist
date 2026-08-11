import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:watchlist/features/home/domain/entities/watch_list.dart';
// import 'package:watchlist/features/home/domain/repositories/watchlist_repo.dart';
import 'package:watchlist/features/home/presentation/bloc/watchlist_cubit.dart';

class HomeScreenView extends StatefulWidget {
  const HomeScreenView({super.key});

  @override
  State<StatefulWidget> createState() => _HomeScreenViewState();
}

class _HomeScreenViewState extends State<HomeScreenView> {
  @override
  void initState() {
    // _loadList();
    super.initState();
    context.read<WatchlistCubit>().loadList();
  }

  final TextEditingController _watchlistName = TextEditingController();
  final TextEditingController _watchlistDesc = TextEditingController();
  String _typeValue = "Movie";
  final List<String> typeList = ["Movie", "Song", "Series", "Anime", "TV Show"];

  Future<void> _showAddDialog(BuildContext context) async {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            "Add New Watchlist",
            style: TextStyle(
              color: Colors.black,
              fontSize: 24.0,
              fontWeight: FontWeight.w800,
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
                  DropdownButtonFormField<String>(
                    value: _typeValue,
                    items:
                        typeList.map((String e) {
                          return DropdownMenuItem<String>(
                            value: e,
                            child: Text(e),
                          );
                        }).toList(),
                    onChanged: (value) {
                      setState(() {
                        _typeValue = value.toString();
                      });
                    },
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
                    _typeValue = "Movie";
                  },
                  style: TextButton.styleFrom(
                    foregroundColor: Colors.black,
                    padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    side: BorderSide(color: Colors.grey[400]!),
                  ),
                  child: Text(
                    "Cancel",
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 16.0,
                      color: Colors.grey[900],
                    ),
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    if (_watchlistName.text.isNotEmpty) {
                      final newItem = WatchList(
                        id: DateTime.now().millisecondsSinceEpoch,
                        name: _watchlistName.text,
                        desc: _watchlistDesc.text,
                        type: _typeValue,
                        isCompleted: false,
                      );
                      context.read<WatchlistCubit>().addTask(newItem);
                      Navigator.pop(context);
                      setState(() {
                        // _filterList(_searchContoller.text.toString());
                        // myFutureList.add(newItem);
                      });
                      _watchlistName.text = "";
                      _watchlistDesc.text = "";
                      _typeValue = "Movie";
                    }
                  },
                  style: TextButton.styleFrom(
                    foregroundColor: Colors.white,
                    backgroundColor: Colors.blue[700],
                    padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                  ),
                  child: Text(
                    "Create",
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
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
      body: BlocBuilder<WatchlistCubit, List<WatchList>>(
        builder: (context, state) {
          return Column(
            children: [
            ],
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _showAddDialog(context);
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
