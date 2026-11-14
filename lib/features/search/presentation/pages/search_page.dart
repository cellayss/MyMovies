import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../app/routes/route_names.dart';
import '../../../../app/theme/app_theme.dart';
import '../../../../core/widgets/error_view.dart';
import '../../../../core/widgets/loading_widget.dart';
import '../../../../core/widgets/movie_card.dart';
import '../providers/search_provider.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final _controller = TextEditingController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<SearchProvider>();

    return Scaffold(
      backgroundColor: AppColors.bg,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 16, 16, 12),
              child: RichText(
                text: const TextSpan(
                  children: [
                    TextSpan(
                      text: 'Cari ',
                      style: TextStyle(
                        color: AppColors.textPri,
                        fontSize: 22,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                    TextSpan(
                      text: 'Film',
                      style: TextStyle(
                        color: AppColors.rose,
                        fontSize: 22,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: TextField(
                controller: _controller,
                textInputAction: TextInputAction.search,
                style: const TextStyle(color: AppColors.textPri),
                onChanged: (value) {
                  setState(() {});
                  provider.onSearchChanged(value);
                },
                decoration: InputDecoration(
                  hintText: 'Judul film, aktor...',
                  hintStyle: const TextStyle(color: AppColors.textDim),
                  prefixIcon:
                      const Icon(Icons.search, color: AppColors.rose),
                  suffixIcon: _controller.text.isNotEmpty
                      ? IconButton(
                          icon: const Icon(Icons.clear,
                              size: 18, color: AppColors.textSec),
                          onPressed: () {
                            _controller.clear();
                            setState(() {});
                            provider.onSearchChanged('');
                          },
                        )
                      : null,
                  filled: true,
                  fillColor: AppColors.surfaceHi,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: const BorderSide(color: AppColors.border),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: const BorderSide(color: AppColors.border),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide:
                        const BorderSide(color: AppColors.rose, width: 1.5),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 16),
            Expanded(
              child: Builder(
                builder: (_) {
                  if (provider.isLoading) return const LoadingWidget();
                  if (provider.errorMessage != null) {
                    return ErrorView(
                        message: provider.errorMessage!, onRetry: () {});
                  }
                  if (provider.movies.isEmpty) {
                    return Center(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(Icons.movie_filter_outlined,
                              size: 64, color: AppColors.textDim),
                          const SizedBox(height: 12),
                          const Text(
                            'Ketik judul film yang kamu cari',
                            style: TextStyle(
                                color: AppColors.textDim, fontSize: 14),
                          ),
                        ],
                      ),
                    );
                  }
                  return GridView.builder(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    itemCount: provider.movies.length,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      mainAxisSpacing: 12,
                      crossAxisSpacing: 12,
                      childAspectRatio: 0.65,
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
            ),
          ],
        ),
      ),
    );
  }
}