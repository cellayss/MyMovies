import 'package:flutter/material.dart';

import '../../../../app/routes/route_names.dart';
import '../../../../core/models/movie_model.dart';
import '../../../../core/widgets/movie_card.dart';

class NowPlayingGrid extends StatelessWidget {
  const NowPlayingGrid({super.key, required this.movies});

  final List<MovieModel> movies;

  @override
  Widget build(BuildContext context) {
    return SliverPadding(
      padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
      sliver: SliverGrid(
        delegate: SliverChildBuilderDelegate((context, index) {
          final movie = movies[index];
          return MovieCard(
            movie: movie,
            onTap: () => Navigator.pushNamed(
              context,
              RouteNames.detail,
              arguments: movie.id,
            ),
          );
        }, childCount: movies.length),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisSpacing: 18,
          crossAxisSpacing: 14,
          childAspectRatio: .58,
        ),
      ),
    );
  }
}