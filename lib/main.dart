import 'package:core/core.dart';
import 'package:core/presentation/bloc/movie/movie_detail_bloc.dart';
import 'package:core/presentation/bloc/movie/now_playing_movie_bloc.dart';
import 'package:core/presentation/bloc/movie/popular_movie_bloc.dart';
import 'package:core/presentation/bloc/movie/top_rated_movie_bloc.dart';
import 'package:core/presentation/bloc/movie/watchlist_movie_bloc.dart';
import 'package:core/presentation/bloc/movie/watchlist_movie_modify_bloc.dart';
import 'package:core/presentation/bloc/movie/watchlist_movie_status_bloc.dart';
import 'package:core/presentation/bloc/tv/now_playing_tv_bloc.dart';
import 'package:core/presentation/bloc/tv/popular_tv_bloc.dart';
import 'package:core/presentation/bloc/tv/top_rated_tv_bloc.dart';
import 'package:core/presentation/bloc/tv/tv_detail_bloc.dart';
import 'package:core/presentation/bloc/tv/watchlist_tv_bloc.dart';
import 'package:core/presentation/bloc/tv/watchlist_tv_modify_bloc.dart';
import 'package:core/presentation/bloc/tv/watchlist_tv_status_bloc.dart';
import 'package:core/presentation/pages/home_page.dart';
import 'package:core/presentation/pages/movie_detail_page.dart';
import 'package:core/presentation/pages/popular_movies_page.dart';
import 'package:core/presentation/pages/top_rated_movies_page.dart';
import 'package:core/presentation/pages/tv/page_detail.dart';
import 'package:core/presentation/pages/tv/page_popular.dart';
import 'package:core/presentation/pages/tv/page_top_rated.dart';
import 'package:core/presentation/pages/watchlist_page.dart';
import 'package:core/utils/ssl_helper.dart';
import 'package:core/utils/utils.dart';
import 'package:about/about_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ditonton/injection.dart' as di;
import 'package:search/presentation/bloc/movie/search_bloc.dart';
import 'package:search/presentation/bloc/tv/search_bloc.dart';
import 'package:search/presentation/pages/page_search.dart';
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  FlutterError.onError = FirebaseCrashlytics.instance.recordFlutterFatalError;
  di.init(await getHttpClient());
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        BlocProvider(
          create: (_) => di.locator<MoviesSearchBloc>(),
        ),
        BlocProvider(
          create: (_) => di.locator<TvSearchBloc>(),
        ),
        BlocProvider(
          create: (_) => di.locator<NowPlayingMoviesBloc>(),
        ),
        BlocProvider(
          create: (_) => di.locator<PopularMoviesBloc>(),
        ),
        BlocProvider(
          create: (_) => di.locator<TopRatedMoviesBloc>(),
        ),
        BlocProvider(
          create: (_) => di.locator<MovieDetailBloc>(),
        ),
        BlocProvider(
          create: (_) => di.locator<WatchlistMoviesBloc>(),
        ),
        BlocProvider(
          create: (_) => di.locator<WatchListStatusBloc>(),
        ),
        BlocProvider(
          create: (_) => di.locator<WatchListMoviesModifyBloc>(),
        ),
        BlocProvider(
          create: (_) => di.locator<NowPlayingTvBloc>(),
        ),
        BlocProvider(
          create: (_) => di.locator<PopularTvBloc>(),
        ),
        BlocProvider(
          create: (_) => di.locator<TopRatedTvBloc>(),
        ),
        BlocProvider(
          create: (_) => di.locator<TvDetailBloc>(),
        ),
        BlocProvider(
          create: (_) => di.locator<WatchlistTvBloc>(),
        ),
        BlocProvider(
          create: (_) => di.locator<TvWatchlistStatusBloc>(),
        ),
        BlocProvider(
          create: (_) => di.locator<WatchListTvModifyBloc>(),
        ),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData.dark().copyWith(
          colorScheme: kColorScheme,
          primaryColor: kRichBlack,
          scaffoldBackgroundColor: kRichBlack,
          textTheme: kTextTheme,
        ),
        initialRoute: ROUTE_HOME,
        onGenerateRoute: (RouteSettings settings) {
          switch (settings.name) {
            case ROUTE_HOME:
              return MaterialPageRoute(builder: (_) => HomePage());
            case ROUTE_MOVIE_POPULAR:
              return CupertinoPageRoute(builder: (_) => PopularMoviesPage());
            case ROUTE_MOVIE_TOP_RATED:
              return CupertinoPageRoute(builder: (_) => TopRatedMoviesPage());
            case ROUTE_MOVIE_DETAIL:
              final id = settings.arguments as int;
              return MaterialPageRoute(
                builder: (_) => MovieDetailPage(id: id),
                settings: settings,
              );

            case ROUTE_SEARCH:
              return CupertinoPageRoute(builder: (_) => SearchPage());
            case ROUTE_WATCHLIST:
              return MaterialPageRoute(builder: (_) => WatchlistPage());

            case ROUTE_TV_POPULAR:
              return CupertinoPageRoute(builder: (_) => PopularTvPage());
            case ROUTE_TV_TOP_RATED:
              return CupertinoPageRoute(builder: (_) => TopTvPage());
            case ROUTE_TV_DETAIL:
              final id = settings.arguments as int;
              return MaterialPageRoute(
                builder: (_) => TvDetailPage(id: id),
                settings: settings,
              );

            case ROUTE_ABOUT:
              return MaterialPageRoute(builder: (_) => AboutPage());
            default:
              return MaterialPageRoute(builder: (_) {
                return Scaffold(
                  body: Center(
                    child: Text('Page not found :('),
                  ),
                );
              });
          }
        },
      ),
    );
  }
}
