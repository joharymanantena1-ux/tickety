import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:tickety/core/theme/app_theme.dart';
import 'events_provider.dart';

class EventDetailScreen extends ConsumerWidget {
  final String eventId;
  
  const EventDetailScreen({super.key, required this.eventId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final eventAsync = ref.watch(eventDetailProvider(eventId));
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      backgroundColor: AppColors.surface,
      appBar: AppBar(
        backgroundColor: AppColors.surface,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: AppColors.onSurface),
          onPressed: () => context.pop(),
        ),
      ),
      body: eventAsync.when(
        data: (event) {
          return SingleChildScrollView(
            padding: const EdgeInsets.only(bottom: 120),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // Cover Img
                Container(
                  height: 300,
                  decoration: BoxDecoration(
                    color: AppColors.surfaceContainerLow,
                    image: DecorationImage(
                      image: NetworkImage(event.imageUrl),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                // Content
                Padding(
                  padding: const EdgeInsets.all(24.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(event.title, style: textTheme.headlineLarge),
                      const SizedBox(height: 16),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                        decoration: BoxDecoration(
                          color: AppColors.secondaryContainer,
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: Text(
                          // Simple date formatting
                          '${event.date.day.toString().padLeft(2, '0')}/${event.date.month.toString().padLeft(2, '0')}/${event.date.year}',
                          style: textTheme.labelLarge?.copyWith(color: AppColors.onSecondaryContainer),
                        ),
                      ),
                      const SizedBox(height: 32),
                      Text('Description', style: textTheme.headlineSmall),
                      const SizedBox(height: 16),
                      Text(event.description, style: textTheme.bodyLarge),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
        loading: () => const Center(child: CircularProgressIndicator(color: AppColors.primary)),
        error: (e, st) => Center(child: Text('Erreur: $e')),
      ),
      // Floating Bottom Bar "Editorial Ledger" style
      bottomSheet: eventAsync.hasValue ? Container(
        color: AppColors.surfaceContainerLowest,
        padding: const EdgeInsets.all(24),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Prix du billet', style: textTheme.labelLarge?.copyWith(color: AppColors.onSurface.withOpacity(0.6))),
                Text('${eventAsync.value!.price.toStringAsFixed(2)} €', style: textTheme.headlineSmall?.copyWith(color: AppColors.primary)),
              ],
            ),
            ElevatedButton(
              onPressed: () => context.push('/client/payment/${eventAsync.value!.id}'),
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(horizontal: 48, vertical: 16),
              ),
              child: const Text('Réserver'),
            ),
          ],
        ),
      ) : null,
    );
  }
}
