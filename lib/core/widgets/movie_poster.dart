import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../utils/image_url_helper.dart';

class MoviePoster extends StatelessWidget {
  const MoviePoster({
    super.key,
    required this.posterPath,
    this.borderRadius = 8,
  });

  final String posterPath;
  final double borderRadius;

  @override
  Widget build(BuildContext context) {
    final imageUrl = ImageUrlHelper.poster(posterPath);

    return ClipRRect(
      borderRadius: BorderRadius.circular(borderRadius),
      child: AspectRatio(
        aspectRatio: 2 / 3,
        child: imageUrl.isEmpty
            ? ColoredBox(
                color: Theme.of(
                  context,
                ).colorScheme.primary.withValues(alpha: .12),
                child: const Icon(Icons.movie_outlined),
              )
            : CachedNetworkImage(
                imageUrl: imageUrl,
                fit: BoxFit.cover,
                placeholder: (_, __) =>
                    const ColoredBox(color: Color(0xFFFFEEF5)),
                errorWidget: (_, __, ___) => const Icon(Icons.broken_image),
              ),
      ),
    );
  }
}
