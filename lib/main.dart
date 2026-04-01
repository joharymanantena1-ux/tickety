import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tickety/core/theme/app_theme.dart';
import 'package:tickety/core/router/app_router.dart';

void main() {
  runApp(const ProviderScope(child: TicketyApp()));
}

class TicketyApp extends ConsumerWidget {
  const TicketyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final router = ref.watch(routerProvider);

    return MaterialApp.router(
      title: 'Tickety',
      theme: AppTheme.lightTheme,
      routerConfig: router,
      debugShowCheckedModeBanner: false,
    );
  }
}
