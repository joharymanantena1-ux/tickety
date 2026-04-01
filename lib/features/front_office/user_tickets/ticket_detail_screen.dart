import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:tickety/core/theme/app_theme.dart';
import 'user_tickets_provider.dart';
import '../events_catalogue/events_provider.dart';

class TicketDetailScreen extends ConsumerWidget {
  final String ticketId;

  const TicketDetailScreen({super.key, required this.ticketId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final ticketAsync = ref.watch(ticketDetailProvider(ticketId));
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      backgroundColor: AppColors.surface,
      appBar: AppBar(
        title: const Text('Billet'),
        leading: IconButton(
          icon: const Icon(Icons.close),
          onPressed: () => context.go('/client/catalogue'),
        ),
      ),
      body: ticketAsync.when(
        data: (ticket) {
          final eventAsync = ref.watch(eventDetailProvider(ticket.eventId));
          return Center(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(24),
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 48),
                decoration: BoxDecoration(
                  color: AppColors.surfaceContainerLowest,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    eventAsync.when(
                      data: (e) => Text(
                        e.title,
                        style: textTheme.headlineSmall,
                        textAlign: TextAlign.center,
                      ),
                      loading: () => const CircularProgressIndicator(),
                      error: (_, __) => const Text('Erreur ev'),
                    ),
                    const SizedBox(height: 32),
                    // Rendu du QR Code avec qr_flutter
                    Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        border: Border.all(color: AppTheme.outlineGhostBorder, width: 2),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: QrImageView(
                        data: ticket.qrCodeData,
                        version: QrVersions.auto,
                        size: 200.0,
                        foregroundColor: AppColors.onSurface,
                      ),
                    ),
                    const SizedBox(height: 32),
                    Text(
                      'ID: ${ticket.id}',
                      style: textTheme.labelMedium?.copyWith(color: AppColors.outlineVariant),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => Center(child: Text('Erreur: $e')),
      ),
    );
  }
}
