import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../app/routes/route_names.dart';
import '../../../../app/theme/app_theme.dart';
import '../../../../core/widgets/error_view.dart';
import '../../../../core/widgets/loading_widget.dart';
import '../providers/home_provider.dart';
import '../widgets/genre_chip_list.dart';
import '../widgets/now_playing_grid.dart';
import '../widgets/trending_section.dart';
import '../../../auth/presentation/providers/auth_provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) return;
      context.read<HomeProvider>().loadHome();
    });
  }

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<HomeProvider>();

    return Scaffold(
      backgroundColor: AppColors.bg,
      body: Builder(
        builder: (_) {
          if (provider.isLoading) return const LoadingWidget();
          if (provider.errorMessage != null) {
            return ErrorView(
              message: provider.errorMessage!,
              onRetry: provider.loadHome,
            );
          }

          return RefreshIndicator(
            color: AppColors.rose,
            backgroundColor: AppColors.surface,
            onRefresh: provider.loadHome,
            child: CustomScrollView(
              slivers: [
                // ── AppBar ────────────────────────────────────────────
                SliverAppBar(
                  floating: true,
                  backgroundColor: AppColors.bg,
                  elevation: 0,
                  titleSpacing: 16,
                  title: RichText(
                    text: const TextSpan(
                      children: [
                        TextSpan(
                          text: 'My',
                          style: TextStyle(
                            color: AppColors.rose,
                            fontSize: 22,
                            fontWeight: FontWeight.w900,
                            letterSpacing: -0.5,
                          ),
                        ),
                        TextSpan(
                          text: 'Movies',
                          style: TextStyle(
                            color: AppColors.textPri,
                            fontSize: 22,
                            fontWeight: FontWeight.w900,
                            letterSpacing: -0.5,
                          ),
                        ),
                      ],
                    ),
                  ),
                  actions: [
                    Padding(
                      padding: const EdgeInsets.only(right: 12),
                      child: _IconBubble(
                        icon: Icons.logout_rounded,
                        onTap: () async {
                          final confirm = await showDialog<bool>(
                            context: context,
                            builder: (ctx) => AlertDialog(
                              backgroundColor: AppColors.surface,
                              title: const Text(
                                'Logout',
                                style: TextStyle(color: AppColors.textPri),
                              ),
                              content: const Text(
                                'Yakin mau logout?',
                                style: TextStyle(color: AppColors.textSec),
                              ),
                              actions: [
                                TextButton(
                                  onPressed: () => Navigator.pop(ctx, false),
                                  child: const Text('Batal', style: TextStyle(color: AppColors.textSec)),
                                ),
                                TextButton(
                                  onPressed: () => Navigator.pop(ctx, true),
                                  child: const Text('Logout', style: TextStyle(color: AppColors.rose)),
                                ),
                              ],
                            ),
                          );

                          if (confirm == true && context.mounted) {
                            await context.read<AuthProvider>().logout();
                            Navigator.pushNamedAndRemoveUntil(
                              context,
                              RouteNames.login,
                              (route) => false,
                            );
                          }
                        },
                      ),
                    ),
                  ],
                ),

                // ── Genre ─────────────────────────────────────────────
                const SliverToBoxAdapter(
                  child: Padding(
                    padding: EdgeInsets.fromLTRB(16, 4, 16, 12),
                    child: _SectionLabel(title: 'Genre'),
                  ),
                ),
                SliverToBoxAdapter(
                  child: GenreChipList(genres: provider.genres),
                ),

                // ── Trending ──────────────────────────────────────────
                const SliverToBoxAdapter(
                  child: Padding(
                    padding: EdgeInsets.fromLTRB(16, 28, 16, 12),
                    child: _SectionLabel(title: 'Trending Sekarang'),
                  ),
                ),
                SliverToBoxAdapter(
                  child: TrendingSection(movies: provider.trendingMovies),
                ),

                // ── Now Playing ───────────────────────────────────────
                const SliverToBoxAdapter(
                  child: Padding(
                    padding: EdgeInsets.fromLTRB(16, 28, 16, 12),
                    child: _SectionLabel(title: 'Tayang Sekarang'),
                  ),
                ),
                NowPlayingGrid(movies: provider.nowPlayingMovies),

                const SliverPadding(padding: EdgeInsets.only(bottom: 100)),
              ],
            ),
          );
        },
      ),
    );
  }
}

// ── Section label: small gradient tick + bold title ───────────────────────

class _SectionLabel extends StatelessWidget {
  const _SectionLabel({required this.title});
  final String title;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 4,
          height: 18,
          decoration: BoxDecoration(
            gradient: AppColors.heroBurn,
            borderRadius: BorderRadius.circular(2),
          ),
        ),
        const SizedBox(width: 10),
        Text(
          title,
          style: const TextStyle(
            fontSize: 17,
            fontWeight: FontWeight.w800,
            color: AppColors.textPri,
            letterSpacing: -0.2,
          ),
        ),
      ],
    );
  }
}

// ── Small circular icon button used in the appbar ─────────────────────────

class _IconBubble extends StatelessWidget {
  const _IconBubble({required this.icon, required this.onTap});
  final IconData icon;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 38,
        height: 38,
        decoration: BoxDecoration(
          color: AppColors.surfaceHi,
          shape: BoxShape.circle,
          border: Border.all(color: AppColors.border, width: 1),
        ),
        child: Icon(icon, color: AppColors.textSec, size: 18),
      ),
    );
  }
}