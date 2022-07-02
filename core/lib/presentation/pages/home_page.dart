
import 'package:core/presentation/bloc/movie/now_playing_movie_bloc.dart';
import 'package:core/presentation/bloc/movie/popular_movie_bloc.dart';
import 'package:core/presentation/bloc/movie/top_rated_movie_bloc.dart';
import 'package:core/presentation/bloc/tv/now_playing_tv_bloc.dart';
import 'package:core/presentation/bloc/tv/popular_tv_bloc.dart';
import 'package:core/presentation/bloc/tv/top_rated_tv_bloc.dart';
import 'package:core/presentation/pages/home_movie_page.dart';
import 'package:core/presentation/pages/tv/page_home.dart';
import 'package:core/presentation/widgets/drawer.dart';
import 'package:core/utils/utils.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePage createState() => _HomePage();
}

class _HomePage extends State<HomePage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      BlocProvider.of<NowPlayingMoviesBloc>(context)
          .add(FetchNowPlayingMovies());
      BlocProvider.of<PopularMoviesBloc>(context).add(FetchPopularMovies());
      BlocProvider.of<TopRatedMoviesBloc>(context).add(FetchTopRatedMovies());

      BlocProvider.of<NowPlayingTvBloc>(context).add(FetchNowPlayingTv());
      BlocProvider.of<PopularTvBloc>(context).add(FetchPopularTv());
      BlocProvider.of<TopRatedTvBloc>(context).add(FetchTopRatedTv());
    });
  }

  @override
  Widget build(BuildContext context) {
    return BuildDrawer(
      content: Scaffold(
        appBar: AppBar(
          leading: const Icon(Icons.menu),
          title: const Text('Ditonton'),
          actions: [
            IconButton(
              onPressed: () {
                Navigator.pushNamed(context, ROUTE_SEARCH);
              },
              icon: const Icon(Icons.search),
            ),
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.all(8),
          child: SingleChildScrollView(
            child: Column(
              children: const [
                HomeMoviePage(),
                HomeTvPage(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
