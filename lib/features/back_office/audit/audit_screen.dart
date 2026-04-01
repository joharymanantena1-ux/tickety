import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:tickety/core/theme/app_theme.dart';
import '../dashboard/back_office_provider.dart';

class AuditScreen extends ConsumerWidget {
  const AuditScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final textTheme = Theme.of(context).textTheme;
    final ticketsAsync = ref.watch(allTicketsProvider);

    return Scaffold(
      backgroundColor: AppColors.surface,
      appBar: AppBar(
        title: Text('Journal d\'Audit', style: textTheme.headlineSmall),
        backgroundColor: AppColors.surface,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: AppColors.onSurface),
          onPressed: () => context.go('/admin/dashboard'),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(48.0),
        child: Container(
          decoration: BoxDecoration(
            color: AppColors.surfaceContainerLowest,
            borderRadius: BorderRadius.circular(8),
          ),
          child: ticketsAsync.when(
            data: (tickets) {
              if (tickets.isEmpty)
                return const Center(child: Text('Aucune donnée d\'audit.'));
              return ListView.builder(
                itemCount: tickets.length + 1,
                itemBuilder: (context, index) {
                  if (index == 0) {
                    return Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 24,
                        vertical: 16,
                      ),
                      decoration: const BoxDecoration(
                        color: AppColors.surfaceContainerLow,
                        borderRadius: BorderRadius.vertical(
                          top: Radius.circular(8),
                        ),
                      ),
                      child: Row(
                        children: [
                          Expanded(
                            child: Text(
                              'ID Billet',
                              style: textTheme.labelLarge,
                            ),
                          ),
                          Expanded(
                            child: Text(
                              'Date Achat',
                              style: textTheme.labelLarge,
                            ),
                          ),
                          Expanded(
                            child: Text(
                              'ID Evénement',
                              style: textTheme.labelLarge,
                            ),
                          ),
                          SizedBox(
                            width: 120,
                            child: Text('Statut', style: textTheme.labelLarge),
                          ),
                        ],
                      ),
                    );
                  }
                  final t = tickets[index - 1];
                  return Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 24,
                      vertical: 16,
                    ),
                    decoration: BoxDecoration(
                      border: Border(
                        bottom: BorderSide(
                          color: AppTheme.outlineGhostBorder.withOpacity(0.1),
                        ),
                      ),
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          child: Text(t.id, style: textTheme.bodyMedium),
                        ),
                        Expanded(
                          child: Text(
                            t.purchaseDate.toString().split('.')[0],
                            style: textTheme.bodyMedium,
                          ),
                        ),
                        Expanded(
                          child: Text(t.eventId, style: textTheme.bodyMedium),
                        ),
                        SizedBox(
                          width: 120,
                          child: Text(
                            t.status.name.toUpperCase(),
                            style: textTheme.labelMedium?.copyWith(
                              color: t.status.name == 'valid'
                                  ? AppColors.primary
                                  : AppColors.onSurface.withOpacity(0.5),
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                },
              );
            },
            loading: () => const Center(child: CircularProgressIndicator()),
            error: (e, _) => Center(child: Text('Erreur: $e')),
          ),
        ),
      ),
    );
  }
}
