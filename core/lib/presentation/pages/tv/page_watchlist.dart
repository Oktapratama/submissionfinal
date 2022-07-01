import 'package:core/core.dart';
import 'package:core/presentation/bloc/tv/watchlist_tv_bloc.dart';
import 'package:core/presentation/widgets/tv_card_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


class WatchlistTvPage extends StatefulWidget {
  const WatchlistTvPage({Key? key}) : super(key: key);

  @override
  _WatchlistTvPageState createState() => _WatchlistTvPageState();
}

class _WatchlistTvPageState extends State<WatchlistTvPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: BlocBuilder<WatchlistTvBloc, WatchlistTvState>(
          builder: (_, state) {
            if (state is WatchlistTvLoading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (state is WatchlistTvData) {
              return ListView.builder(
                itemBuilder: (context, index) {
                  final tv = state.tv[index];
                  return CardTv(tv);
                },
                itemCount: state.tv.length,
              );
            } else if (state is WatchlistTvEmpty) {
              return const Center(child: Text('Watchlist is Empty'));
            } else {
              return Center(
                key: const Key('error_message'),
                child: Text((state as WatchlistTvError).message),
              );
            }
          },
        ),
      ),
    );
  }
}
