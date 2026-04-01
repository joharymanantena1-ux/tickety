import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:tickety/core/theme/app_theme.dart';
import 'user_tickets_provider.dart';
import '../events_catalogue/events_provider.dart';
import '../../../core/mcp_mock/models.dart';

class TicketsScreen extends ConsumerWidget {
  const TicketsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final ticketsAsync = ref.watch(userTicketsProvider);
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      backgroundColor: AppColors.surface,
      appBar: AppBar(
        title: const Text('Mes Billets'),
        backgroundColor: AppColors.surface,
        elevation: 0,
      ),
      body: ticketsAsync.when(
        data: (tickets) {
          if (tickets.isEmpty) {
            return Center(child: Text('Aucun billet.', style: textTheme.bodyLarge));
          }
          return ListView.separated(
            padding: const EdgeInsets.all(24),
            itemCount: tickets.length,
            separatorBuilder: (_, __) => const SizedBox(height: 16),
            itemBuilder: (context, index) {
              final ticket = tickets[index];
              final eventAsync = ref.watch(eventDetailProvider(ticket.eventId));
              
              return GestureDetector(
                onTap: () => context.push('/client/tickets/${ticket.id}'),
                child: Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: AppColors.surfaceContainerLowest,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Row(
                    children: [
                      Container(
                        width: 48,
                        height: 48,
                        decoration: BoxDecoration(
                          color: AppColors.primaryDim,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: const Icon(Icons.qr_code, color: AppColors.onPrimary),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            eventAsync.when(
                              data: (e) => Text(e.title, style: textTheme.headlineSmall?.copyWith(fontSize: 16)),
                              loading: () => const Text('Chargement...'),
                              error: (_, __) => const Text('Erreur'),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              ticket.status == TicketStatus.valid 
                                  ? 'Valable' 
                                  : ticket.status == TicketStatus.scanned 
                                      ? 'Scanné' 
                                      : 'Annulé',
                              style: textTheme.labelMedium?.copyWith(
                                color: ticket.status == TicketStatus.valid ? AppColors.primary : Colors.red,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => Center(child: Text('Erreur: $e')),
      ),
    );
  }
}
