import 'package:cached_network_image/cached_network_image.dart';
import 'package:core/core.dart';
import 'package:core/domain/entities/tv/tv.dart';
import 'package:core/presentation/bloc/tv/now_playing_tv_bloc.dart';
import 'package:core/presentation/bloc/tv/popular_tv_bloc.dart';
import 'package:core/presentation/bloc/tv/top_rated_tv_bloc.dart';
import 'package:core/utils/base.dart';
import 'package:core/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../styles/text_styles.dart';


class HomeTvPage extends StatefulWidget {
  const HomeTvPage({Key? key}) : super(key: key);

  @override
  _HomeTvPage createState() => _HomeTvPage();
}

class _HomeTvPage extends State<HomeTvPage> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(8),
          child: Text('Now Playing TV', style: kHeading6),
        ),
        BlocBuilder<NowPlayingTvBloc, NowPlayingTvState>(
          builder: (_, state) {
            if (state is NowPlayingTvLoading) {
              return Center(child: CircularProgressIndicator());
            } else if (state is NowPlayingTvData) {
              return TVList(state.tv);
            } else {
              return const Text('Failed');
            }
          },
        ),
        _buildSubHeading(
            title: 'Popular TV',
            onTap: () => Navigator.pushNamed(context, ROUTE_TV_POPULAR)),
        BlocBuilder<PopularTvBloc, PopularTvState>(
          builder: (_, state) {
            if (state is PopularTvLoading) {
              return Center(child: CircularProgressIndicator());
            } else if (state is PopularTvData) {
              return TVList(state.tv);
            } else {
              return const Text('Failed');
            }
          },
        ),
        _buildSubHeading(
            title: 'Top Rated TV',
            onTap: () => Navigator.pushNamed(context, ROUTE_TV_TOP_RATED)),
        BlocBuilder<TopTvBloc, TopTvState>(
          builder: (_, state) {
            if (state is TopTvLoading) {
              return Center(child: CircularProgressIndicator());
            } else if (state is TopTvData) {
              return TVList(state.tv);
            } else {
              return const Text('Failed');
            }
          },
        ),
      ],
    );
  }

  Row _buildSubHeading({required String title, required Function() onTap}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: kHeading6,
        ),
        InkWell(
          onTap: onTap,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Text('See More'),
                Icon(Icons.arrow_forward_ios),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class TVList extends StatelessWidget {
  final List<Tv> tv;

  const TVList(this.tv);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 200,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          final data = tv[index];
          return Container(
            padding: const EdgeInsets.all(8),
            child: InkWell(
              onTap: () {
                Navigator.pushNamed(
                  context,
                  ROUTE_TV_DETAIL,
                  arguments: data.id,
                );
              },
              child: ClipRRect(
                borderRadius: BorderRadius.all(Radius.circular(16)),
                child: CachedNetworkImage(
                  imageUrl: '$BASE_URL_IMAGE${data.posterPath}',
                  placeholder: (context, url) => const Center(
                    child: CircularProgressIndicator(),
                  ),
                  errorWidget: (context, url, error) => Icon(Icons.error),
                ),
              ),
            ),
          );
        },
        itemCount: tv.length,
      ),
    );
  }
}
