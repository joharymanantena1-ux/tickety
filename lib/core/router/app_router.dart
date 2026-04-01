import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final routerProvider = Provider<GoRouter>((ref) {
  return GoRouter(
    initialLocation: '/',
    routes: [
      GoRoute(
        path: '/',
        builder: (context, state) => const PlaceholderScreen(title: 'Splash / Auth'),
      ),
      // Front Office routes
      GoRoute(
        path: '/client/catalogue',
        builder: (context, state) => const PlaceholderScreen(title: 'Catalogue des Événements'),
      ),
      GoRoute(
        path: '/client/payment',
        builder: (context, state) => const PlaceholderScreen(title: 'Tunnel de Paiement'),
      ),
      GoRoute(
        path: '/client/tickets',
        builder: (context, state) => const PlaceholderScreen(title: 'Mes Billets (QR Codes)'),
      ),
      // Back Office routes
      GoRoute(
        path: '/admin/dashboard',
        builder: (context, state) => const PlaceholderScreen(title: 'Dashboard Admin (SaaS)'),
      ),
      GoRoute(
        path: '/admin/scanner',
        builder: (context, state) => const PlaceholderScreen(title: 'Scanner Billet Admin'),
      ),
    ],
  );
});

class PlaceholderScreen extends StatelessWidget {
  final String title;

  const PlaceholderScreen({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(title)),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            // Temporary debug navigation
            if (title.contains('Splash')) {
              context.go('/client/catalogue');
            } else if (title.contains('Catalogue')) {
               context.go('/admin/dashboard');
            } else {
              context.go('/');
            }
          },
          child: const Text('Naviguer (Debug)'),
        ),
      ),
    );
  }
}
