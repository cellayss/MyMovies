import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../core/constants/api_constants.dart';
import '../../../../core/models/movie_model.dart';
import '../../../../core/widgets/error_view.dart';
import '../../../../core/widgets/loading_widget.dart';
import '../../../favorite/presentation/providers/favorite_provider.dart';
import '../providers/movie_detail_provider.dart';

class MovieDetailPage extends StatefulWidget {
  const MovieDetailPage({super.key, required this.movieId});
  final int movieId;

  @override
  State<MovieDetailPage> createState() => _MovieDetailPageState();
}

class _MovieDetailPageState extends State<MovieDetailPage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) return;
      context.read<MovieDetailProvider>().loadDetail(widget.movieId);
    });
  }

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<MovieDetailProvider>();
    final movie = provider.movie;

    return Scaffold(
      body: Builder(builder: (_) {
        if (provider.isLoading) return const LoadingWidget();
        if (provider.errorMessage != null) {
          return ErrorView(
            message: provider.errorMessage!,
            onRetry: () => provider.loadDetail(widget.movieId),
          );
        }
        if (movie == null) return const SizedBox.shrink();

        final favoriteMovie = MovieModel(
          id: movie.id,
          title: movie.title,
          overview: movie.overview,
          posterPath: movie.posterPath,
          backdropPath: movie.backdropPath,
          releaseDate: movie.releaseDate,
          voteAverage: movie.voteAverage,
        );
        final favoriteProvider = context.watch<FavoriteProvider>();
        final isFavorite = favoriteProvider.isFavorite(movie.id);

        return CustomScrollView(
          slivers: [
            // Backdrop + back button + favorite button
            SliverAppBar(
              expandedHeight: 300,
              pinned: true,
              backgroundColor: const Color(0xFF171116),
              leading: Padding(
                padding: const EdgeInsets.all(8),
                child: CircleAvatar(
                  backgroundColor: Colors.black45,
                  child: IconButton(
                    icon: const Icon(Icons.arrow_back, color: Colors.white, size: 18),
                    onPressed: () => Navigator.pop(context),
                  ),
                ),
              ),
              actions: [
                Padding(
                  padding: const EdgeInsets.all(8),
                  child: CircleAvatar(
                    backgroundColor: Colors.black45,
                    child: IconButton(
                      icon: Icon(
                        isFavorite ? Icons.favorite : Icons.favorite_border,
                        color: isFavorite ? const Color(0xFFE85D8F) : Colors.white,
                        size: 18,
                      ),
                      onPressed: () => context.read<FavoriteProvider>().toggleFavorite(favoriteMovie),
                    ),
                  ),
                ),
              ],
              flexibleSpace: FlexibleSpaceBar(
                background: Stack(
                  fit: StackFit.expand,
                  children: [
                    CachedNetworkImage(
                      imageUrl: '${ApiConstants.imageBaseUrl}${movie.backdropPath}',
                      fit: BoxFit.cover,
                      placeholder: (_, __) => Container(color: const Color(0xFF241821)),
                      errorWidget: (_, __, ___) => CachedNetworkImage(
                        imageUrl: '${ApiConstants.imageBaseUrl}${movie.posterPath}',
                        fit: BoxFit.cover,
                      ),
                    ),
                    // Gradient bawah
                    const DecoratedBox(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          stops: [0.5, 1.0],
                          colors: [Colors.transparent, Color(0xFF171116)],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(20, 0, 20, 32),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Judul
                    Text(
                      movie.title,
                      style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                            fontWeight: FontWeight.w800,
                            height: 1.2,
                          ),
                    ),
                    const SizedBox(height: 12),

                    // Info row: rating, tahun, durasi
                    Wrap(
                      spacing: 12,
                      runSpacing: 8,
                      children: [
                        _InfoBadge(
                          icon: Icons.star_rounded,
                          label: movie.voteAverage.toStringAsFixed(1),
                          color: const Color(0xFFE85D8F),
                        ),
                        _InfoBadge(
                          icon: Icons.calendar_today_outlined,
                          label: movie.releaseDate.length >= 4
                              ? movie.releaseDate.substring(0, 4)
                              : movie.releaseDate,
                          color: Colors.grey,
                        ),
                        if (movie.runtime > 0)
                          _InfoBadge(
                            icon: Icons.access_time_outlined,
                            label: '${movie.runtime} min',
                            color: Colors.grey,
                          ),
                      ],
                    ),
                    const SizedBox(height: 16),

                    // Genre chips
                    if (movie.genres.isNotEmpty) ...[
                      Wrap(
                        spacing: 8,
                        runSpacing: 8,
                        children: movie.genres
                            .map(
                              (g) => Container(
                                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 5),
                                decoration: BoxDecoration(
                                  color: const Color(0xFFFFEEF5),
                                  borderRadius: BorderRadius.circular(6),
                                  border: Border.all(
                                    color: const Color(0xFFE85D8F).withOpacity(0.4),
                                  ),
                                ),
                                child: Text(
                                  g.name,
                                  style: const TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w600,
                                    color: Color(0xFFE85D8F),
                                  ),
                                ),
                              ),
                            )
                            .toList(),
                      ),
                      const SizedBox(height: 20),
                    ],

                    // Divider
                    const Divider(height: 1),
                    const SizedBox(height: 20),

                    // Sinopsis
                    const Text(
                      'Sinopsis',
                      style: TextStyle(fontSize: 15, fontWeight: FontWeight.w700),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      movie.overview.isNotEmpty ? movie.overview : 'Tidak ada sinopsis.',
                      style: const TextStyle(
                        fontSize: 14,
                        height: 1.6,
                        color: Color(0xFF5A4A52),
                      ),
                    ),
                    const SizedBox(height: 28),

                    // Tombol tambah favorit
                    SizedBox(
                      width: double.infinity,
                      child: FilledButton.icon(
                        onPressed: () => context.read<FavoriteProvider>().toggleFavorite(favoriteMovie),
                        icon: Icon(
                          isFavorite ? Icons.favorite : Icons.favorite_border,
                          size: 18,
                        ),
                        label: Text(
                          isFavorite ? 'Hapus dari Favorit' : 'Tambah ke Favorit',
                          style: const TextStyle(fontWeight: FontWeight.w600),
                        ),
                        style: FilledButton.styleFrom(
                          backgroundColor: isFavorite
                              ? Colors.grey[300]
                              : const Color(0xFFE85D8F),
                          foregroundColor: isFavorite ? Colors.grey[700] : Colors.white,
                          padding: const EdgeInsets.symmetric(vertical: 14),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        );
      }),
    );
  }
}

class _InfoBadge extends StatelessWidget {
  const _InfoBadge({required this.icon, required this.label, required this.color});
  final IconData icon;
  final String label;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, size: 14, color: color),
        const SizedBox(width: 4),
        Text(
          label,
          style: TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.w600,
            color: color,
          ),
        ),
      ],
    );
  }
}