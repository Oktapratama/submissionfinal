import 'package:core/presentation/bloc/tv/top_rated_tv_bloc.dart';
import 'package:core/presentation/widgets/tv_card_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


class TopTvPage extends StatefulWidget {
  const TopTvPage({Key? key}) : super(key: key);

  @override
  _TopTvPageState createState() => _TopTvPageState();
}

class _TopTvPageState extends State<TopTvPage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(
            () => BlocProvider.of<TopRatedTvBloc>(context).add(FetchTopRatedTv()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Top Rated TVs'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: BlocBuilder<TopRatedTvBloc, TopTvState>(
          builder: (_, state) {
            if (state is TopTvLoading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (state is TopTvData) {
              return ListView.builder(
                itemBuilder: (context, index) {
                  final tv = state.tv[index];
                  return CardTv(tv);
                },
                itemCount: state.tv.length,
              );
            } else {
              return const Center(
                key: Key('error_message'),
                child: Text('Failed'),
              );
            }
          },
        ),
      ),
    );
  }
}
