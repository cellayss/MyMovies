import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../app/routes/route_names.dart';
import '../../../../core/widgets/error_view.dart';
import '../../../../core/widgets/loading_widget.dart';
import '../../../../core/widgets/movie_card.dart';
import '../providers/genre_provider.dart';

class BrowseGenreArguments {
  const BrowseGenreArguments({required this.genreId, required this.genreName});

  final int genreId;
  final String genreName;
}

class BrowseGenrePage extends StatefulWidget {
  const BrowseGenrePage({super.key, required this.arguments});

  final BrowseGenreArguments arguments;

  @override
  State<BrowseGenrePage> createState() => _BrowseGenrePageState();
}

class _BrowseGenrePageState extends State<BrowseGenrePage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) return;
      context.read<GenreProvider>().loadByGenre(widget.arguments.genreId);
    });
  }

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<GenreProvider>();

    return Scaffold(
      appBar: AppBar(title: Text(widget.arguments.genreName)),
      body: Builder(
        builder: (_) {
          if (provider.isLoading) return const LoadingWidget();
          if (provider.errorMessage != null) {
            return ErrorView(
              message: provider.errorMessage!,
              onRetry: () => provider.loadByGenre(widget.arguments.genreId),
            );
          }

          return GridView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: provider.movies.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisSpacing: 18,
              crossAxisSpacing: 14,
              childAspectRatio: .58,
            ),
            itemBuilder: (context, index) {
              final movie = provider.movies[index];
              return MovieCard(
                movie: movie,
                onTap: () => Navigator.pushNamed(
                  context,
                  RouteNames.detail,
                  arguments: movie.id,
                ),
              );
            },
          );
        },
      ),
    );
  }
}
