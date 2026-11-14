import 'package:flutter/material.dart';

import '../../features/auth/presentation/pages/login_page.dart';
import '../../features/genre/presentation/pages/browse_genre_page.dart';
import '../../features/main_navigation/presentation/pages/main_navigation_page.dart';
import '../../features/movie_detail/presentation/pages/movie_detail_page.dart';
import '../../features/onboarding/presentation/pages/onboarding_page.dart';
import '../../features/splash/presentation/pages/splash_page.dart';
import 'route_names.dart';

class AppRoutes {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case RouteNames.splash:
        return MaterialPageRoute(builder: (_) => const SplashPage());
      case RouteNames.onboarding:
        return MaterialPageRoute(builder: (_) => const OnboardingPage());
      case RouteNames.login:
        return MaterialPageRoute(builder: (_) => const LoginPage());
      case RouteNames.main:
        return MaterialPageRoute(builder: (_) => const MainNavigationPage());
      case RouteNames.detail:
        final movieId = settings.arguments as int;
        return MaterialPageRoute(
          builder: (_) => MovieDetailPage(movieId: movieId),
        );
      case RouteNames.genre:
        final args = settings.arguments as BrowseGenreArguments;
        return MaterialPageRoute(
          builder: (_) => BrowseGenrePage(arguments: args),
        );
      default:
        return MaterialPageRoute(builder: (_) => const SplashPage());
    }
  }
}
