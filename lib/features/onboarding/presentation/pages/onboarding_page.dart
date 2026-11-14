import 'package:flutter/material.dart';

import '../../../../app/injection/service_locator.dart';
import '../../../../app/routes/route_names.dart';
import '../../../../core/storage/local_storage.dart';

class OnboardingPage extends StatelessWidget {
  const OnboardingPage({super.key});

  Future<void> _start(BuildContext context) async {
    await sl<LocalStorage>().setBool(LocalStorageKeys.hasSeenOnboarding, true);
    if (context.mounted) {
      Navigator.pushReplacementNamed(context, RouteNames.login);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Spacer(),
              Icon(
                Icons.local_movies_outlined,
                size: 72,
                color: Theme.of(context).colorScheme.primary,
              ),
              const SizedBox(height: 24),
              Text(
                'Temukan film favoritmu dengan mudah.',
                style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(height: 12),
              Text(
                'Lihat film terbaru, cari movie, simpan favorit, dan buka detail film dari TMDb.',
                style: Theme.of(context).textTheme.bodyLarge,
              ),
              const Spacer(),
              SizedBox(
                width: double.infinity,
                child: FilledButton(
                  onPressed: () => _start(context),
                  child: const Text('Mulai'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
