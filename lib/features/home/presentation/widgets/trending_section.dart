import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';

import '../../../../app/routes/route_names.dart';
import '../../../../app/theme/app_theme.dart';
import '../../../../core/constants/api_constants.dart';
import '../../../../core/models/movie_model.dart';

class TrendingSection extends StatelessWidget {
  const TrendingSection({super.key, required this.movies});

  final List<MovieModel> movies;

  @override
  Widget build(BuildContext context) {
    if (movies.isEmpty) return const SizedBox.shrink();

    return SizedBox(
      height: 220,
      child: ListView.separated(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        scrollDirection: Axis.horizontal,
        itemCount: movies.take(10).length,
        separatorBuilder: (_, __) => const SizedBox(width: 4),
        itemBuilder: (context, index) {
          final movie = movies[index];
          return GestureDetector(
            onTap: () => Navigator.pushNamed(
              context,
              RouteNames.detail,
              arguments: movie.id,
            ),
            child: SizedBox(
              width: 152,
              child: Stack(
                clipBehavior: Clip.none,
                children: [
                  // ── Ghosted oversized rank number, bleeding behind poster ──
                  Positioned(
                    left: -6,
                    bottom: 18,
                    child: Text(
                      '${index + 1}',
                      style: TextStyle(
                        fontSize: 92,
                        fontWeight: FontWeight.w900,
                        height: 1,
                        letterSpacing: -4,
                        foreground: Paint()
                          ..style = PaintingStyle.stroke
                          ..strokeWidth = 1.6
                          ..color = AppColors.violet.withOpacity(0.35),
                      ),
                    ),
                  ),

                  // ── Poster card, offset right so the rank peeks out ──
                  Padding(
                    padding: const EdgeInsets.only(left: 28),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(16),
                      child: Container(
                        height: 200,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(16),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.5),
                              blurRadius: 16,
                              offset: const Offset(0, 8),
                            ),
                          ],
                        ),
                        child: Stack(
                          fit: StackFit.expand,
                          children: [
                            CachedNetworkImage(
                              imageUrl:
                                  '${ApiConstants.imageBaseUrl}${movie.posterPath}',
                              fit: BoxFit.cover,
                              placeholder: (_, __) => Container(
                                color: AppColors.surfaceHi,
                              ),
                              errorWidget: (_, __, ___) => Container(
                                color: AppColors.surfaceHi,
                                child: const Icon(
                                  Icons.movie_outlined,
                                  color: AppColors.textDim,
                                ),
                              ),
                            ),

                            // Scrim for legibility
                            const DecoratedBox(
                              decoration: BoxDecoration(
                                gradient: AppColors.cardScrim,
                              ),
                            ),

                            // Title
                            Positioned(
                              left: 10,
                              right: 10,
                              bottom: 10,
                              child: Text(
                                movie.title,
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(
                                  color: AppColors.textPri,
                                  fontSize: 12,
                                  fontWeight: FontWeight.w700,
                                  height: 1.25,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}