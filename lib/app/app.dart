import 'package:flutter/material.dart';

import 'routes/app_routes.dart';
import 'routes/route_names.dart';
import 'theme/app_theme.dart';

class MyMoviesApp extends StatelessWidget {
  const MyMoviesApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'MyMovies',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.dark,
      darkTheme: AppTheme.dark,
      themeMode: ThemeMode.dark,
      initialRoute: RouteNames.splash,
      onGenerateRoute: AppRoutes.generateRoute,
    );
  }
}