import 'package:flutter/material.dart';

import '../../../../app/routes/route_names.dart';
import '../../../../app/theme/app_theme.dart';
import '../../../../core/models/genre_model.dart';
import '../../../genre/presentation/pages/browse_genre_page.dart';

class GenreChipList extends StatelessWidget {
  const GenreChipList({super.key, required this.genres});

  final List<GenreModel> genres;

  @override
  Widget build(BuildContext context) {
    if (genres.isEmpty) return const SizedBox.shrink();

    return SizedBox(
      height: 40,
      child: ListView.separated(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        scrollDirection: Axis.horizontal,
        itemCount: genres.length,
        separatorBuilder: (_, __) => const SizedBox(width: 8),
        itemBuilder: (context, index) {
          final genre = genres[index];
          return GestureDetector(
            onTap: () => Navigator.pushNamed(
              context,
              RouteNames.genre,
              arguments: BrowseGenreArguments(
                genreId: genre.id,
                genreName: genre.name,
              ),
            ),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              decoration: BoxDecoration(
                color: AppColors.surfaceHi,
                borderRadius: BorderRadius.circular(10),
                border: Border.all(
                  color: AppColors.border,
                  width: 1,
                ),
              ),
              child: Text(
                genre.name,
                style: const TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  color: AppColors.textSec,
                  letterSpacing: 0.2,
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}