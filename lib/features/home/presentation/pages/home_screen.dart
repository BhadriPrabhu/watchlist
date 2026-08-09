import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:watchlist/features/home/domain/repositories/watchlist_repo.dart';
// import 'package:watchlist/features/home/presentation/bloc/watchlist_cubit.dart';
import 'package:watchlist/features/home/presentation/pages/home_screen_view.dart';

class HomeScreen extends StatelessWidget {
  // final WatchlistRepo watchlistRepo;

  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // return BlocProvider(create: (context) => WatchlistCubit(watchlistRepo), child: HomeScreenView(),);
    return HomeScreenView();
  }

}