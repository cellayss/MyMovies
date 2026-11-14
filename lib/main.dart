import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'app/app.dart';
import 'app/injection/service_locator.dart';
import 'features/auth/presentation/providers/auth_provider.dart';
import 'features/favorite/presentation/providers/favorite_provider.dart';
import 'features/genre/presentation/providers/genre_provider.dart';
import 'features/home/presentation/providers/home_provider.dart';
import 'features/movie_detail/presentation/providers/movie_detail_provider.dart';
import 'features/search/presentation/providers/search_provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await setupServiceLocator();

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthProvider(sl())),
        ChangeNotifierProvider(create: (_) => FavoriteProvider(sl())),
        ChangeNotifierProvider(create: (_) => HomeProvider(sl())),
        ChangeNotifierProvider(create: (_) => SearchProvider(sl())),
        ChangeNotifierProvider(create: (_) => GenreProvider(sl())),
        ChangeNotifierProvider(create: (_) => MovieDetailProvider(sl())),
      ],
      child: const MyMoviesApp(),
    ),
  );
}