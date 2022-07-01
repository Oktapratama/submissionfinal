import 'package:core/core.dart';
import 'package:core/presentation/bloc/movie/watchlist_movie_bloc.dart';
import 'package:core/presentation/bloc/tv/watchlist_tv_bloc.dart';
import 'package:core/presentation/pages/watchlist_movies_page.dart';
import 'package:core/presentation/pages/tv/page_watchlist.dart';
import 'package:core/utils/utils.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';

import '../../styles/colors.dart';

class WatchlistPage extends StatefulWidget {
  const WatchlistPage({Key? key}) : super(key: key);

  @override
  _WatchlistPage createState() => _WatchlistPage();
}

class _WatchlistPage extends State<WatchlistPage> with RouteAware {
  @override
  void initState() {
    super.initState();
    Future.microtask(() =>
        BlocProvider.of<WatchlistTvBloc>(context).add(FetchWatchlistTv()));
    Future.microtask(() => BlocProvider.of<WatchlistMoviesBloc>(context)
        .add(FetchWatchlistMovies()));
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    routeObserver.subscribe(this, ModalRoute.of(context)!);
  }

  @override
  void didPopNext() {
    super.didPopNext();
    BlocProvider.of<WatchlistTvBloc>(context).add(FetchWatchlistTv());
    BlocProvider.of<WatchlistMoviesBloc>(context).add(FetchWatchlistMovies());
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Watchlist'),
          bottom: const TabBar(
            indicatorColor: kMikadoYellow,
            tabs: [
              Tab(icon: Icon(Icons.movie_creation_rounded)),
              Tab(icon: Icon(Icons.tv_rounded)),
            ],
          ),
        ),
        body: const Padding(
          padding: EdgeInsets.all(8),
          child: TabBarView(
            children: [WatchlistMoviesPage(), WatchlistTvPage()],
          ),
        ),
      ),
    );
  }
}
