import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../features/auth/login_screen.dart';
import '../../features/front_office/events_catalogue/catalogue_screen.dart';
import '../../features/front_office/events_catalogue/event_detail_screen.dart';
import '../../features/front_office/payment_tunnel/payment_screen.dart';
import '../../features/front_office/user_tickets/tickets_screen.dart';
import '../../features/front_office/user_tickets/ticket_detail_screen.dart';
import '../../features/back_office/dashboard/dashboard_screen.dart';
import '../../features/back_office/audit/audit_screen.dart';
import '../../features/back_office/scanner/scanner_screen.dart';

final routerProvider = Provider<GoRouter>((ref) {
  return GoRouter(
    initialLocation: '/',
    routes: [
      GoRoute(
        path: '/',
        builder: (context, state) => const LoginScreen(),
      ),
      // Front Office routes
      GoRoute(
        path: '/client/catalogue',
        builder: (context, state) => const CatalogueScreen(),
      ),
      GoRoute(
        path: '/client/catalogue/details/:id',
        builder: (context, state) {
          final id = state.pathParameters['id']!;
          return EventDetailScreen(eventId: id);
        },
      ),
      GoRoute(
        path: '/client/payment/:id',
        builder: (context, state) {
          final id = state.pathParameters['id']!;
          return PaymentScreen(eventId: id);
        },
      ),
      GoRoute(
        path: '/client/tickets',
        builder: (context, state) => const TicketsScreen(),
      ),
      GoRoute(
        path: '/client/tickets/:ticketId',
        builder: (context, state) {
          final id = state.pathParameters['ticketId']!;
          return TicketDetailScreen(ticketId: id);
        },
      ),
      // Back Office routes
      GoRoute(
        path: '/admin/dashboard',
        builder: (context, state) => const DashboardScreen(),
      ),
      GoRoute(
        path: '/admin/audit',
        builder: (context, state) => const AuditScreen(),
      ),
      GoRoute(
        path: '/admin/scanner',
        builder: (context, state) => const ScannerScreen(),
      ),
    ],
  );
});

class PlaceholderScreen extends StatelessWidget {
  final String title;

  const PlaceholderScreen({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Scaffold(
      appBar: AppBar(title: Text(title, style: textTheme.headlineSmall)),
      body: Center(
        child: Text('Écran en cours de construction : $title', style: textTheme.bodyLarge),
      ),
    );
  }
}
