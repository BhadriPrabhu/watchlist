import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:watchlist/features/home/domain/entities/watch_list.dart';
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
              Text("Watchlist"),
            ],
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
