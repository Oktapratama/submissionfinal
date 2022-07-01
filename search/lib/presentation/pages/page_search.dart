import 'package:core/domain/entities/movie.dart';
import 'package:core/presentation/widgets/movie_card_list.dart';
import 'package:core/presentation/widgets/tv_card_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:search/presentation/bloc/movie/search_bloc.dart';
import 'package:search/presentation/bloc/tv/search_bloc.dart';

class SearchPage extends StatelessWidget {
  const SearchPage({Key? key}) : super(key: key);

  get kHeading6 => null;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Search'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              key: const Key('search-textfield'),
              onChanged: (query) {
                context
                    .read<MoviesSearchBloc>()
                    .add(OnMoviesQueryChanged(query));
                context.read<TvSearchBloc>().add(OnTvQueryChanged(query));
              },
              decoration: const InputDecoration(
                hintText: 'Search title',
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(),
              ),
              textInputAction: TextInputAction.search,
            ),
            SizedBox(height: 16),
            Text(
              'Search Result',
              style: kHeading6,
            ),
            BlocBuilder<MoviesSearchBloc, MoviesSearchState>(
              builder: (_, movieObject) =>
                  BlocBuilder<TvSearchBloc, TvSearchState>(
                      builder: (_, tvObject) {
                        if (movieObject is MoviesSearchLoading &&
                            tvObject is TvSearchLoading) {
                          return const Expanded(
                            child: Center(
                              child: CircularProgressIndicator(),
                            ),
                          );
                        } else if (tvObject is SearchTvData &&
                            movieObject is SearchMoviesData) {
                          final List<dynamic> result = [
                            ...movieObject.hasil,
                            ...tvObject.hasil
                          ];
                          return Expanded(
                            child: (result.isNotEmpty)
                                ? ListView.builder(
                              key: const Key('search-listview'),
                              itemBuilder: (_, index) => (result[index] is Movie)
                                  ? MovieCard(result[index])
                                  : CardTv(result[index]),
                              itemCount: result.length,
                            )
                                : const Center(
                              child: Text(
                                'Data cannot be found at Movies or TV',
                              ),
                            ),
                          );
                        } else {
                          return const SizedBox(key: Key('search-error'));
                        }
                      }),
            ),
          ],
        ),
      ),
    );
  }
}
