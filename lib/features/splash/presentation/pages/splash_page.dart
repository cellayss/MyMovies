import 'package:flutter/material.dart';

import '../../../../app/injection/service_locator.dart';
import '../../../../app/routes/route_names.dart';
import '../../../../core/constants/app_constants.dart';
import '../../../../core/storage/local_storage.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    super.initState();
    _checkSession();
  }

  Future<void> _checkSession() async {
    await Future.delayed(const Duration(seconds: 1));
    final storage = sl<LocalStorage>();
    final hasSeenOnboarding =
        storage.getBool(LocalStorageKeys.hasSeenOnboarding) ?? false;
    final isLoggedIn = storage.getBool(LocalStorageKeys.isLoggedIn) ?? false;

    if (!mounted) return;
    if (!hasSeenOnboarding) {
      Navigator.pushReplacementNamed(context, RouteNames.onboarding);
    } else if (!isLoggedIn) {
      Navigator.pushReplacementNamed(context, RouteNames.login);
    } else {
      Navigator.pushReplacementNamed(context, RouteNames.main);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.movie_filter_rounded,
              size: 64,
              color: Theme.of(context).colorScheme.primary,
            ),
            const SizedBox(height: 16),
            Text(
              AppConstants.appName,
              style: Theme.of(
                context,
              ).textTheme.headlineMedium?.copyWith(fontWeight: FontWeight.w700),
            ),
          ],
        ),
      ),
    );
  }
}
