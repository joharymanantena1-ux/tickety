import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:tickety/core/theme/app_theme.dart';
import 'back_office_provider.dart';

class DashboardScreen extends ConsumerWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final textTheme = Theme.of(context).textTheme;
    final stats = ref.watch(dashboardStatsProvider);

    return Scaffold(
      backgroundColor: AppColors.surface,
      appBar: AppBar(
        title: Text('Dashboard Admin', style: textTheme.headlineSmall),
        backgroundColor: AppColors.surface,
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.qr_code_scanner, color: AppColors.onSurface),
            tooltip: 'Lancer le Scanner',
            onPressed: () => context.push('/admin/scanner'),
          ),
          IconButton(
            icon: const Icon(Icons.list_alt, color: AppColors.onSurface),
            tooltip: 'Journal d\'Audit',
            onPressed: () => context.push('/admin/audit'),
          ),
          IconButton(
            icon: const Icon(Icons.logout, color: AppColors.onSurface),
            onPressed: () => context.go('/'),
          ),
        ],
      ),
      body: Row( // Sidebar + Content structure for Desktop B2B
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Sidebar (Mock)
          Container(
            width: 260,
            color: AppColors.surfaceContainerLow,
            padding: const EdgeInsets.symmetric(vertical: 32, horizontal: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _SidebarItem(icon: Icons.dashboard, label: 'Tableau de bord', isActive: true, textTheme: textTheme),
                const SizedBox(height: 16),
                _SidebarItem(icon: Icons.list_alt, label: 'Journal d\'Audit', isActive: false, textTheme: textTheme),
                const SizedBox(height: 16),
                _SidebarItem(icon: Icons.qr_code_scanner, label: 'Scanner QR', isActive: false, textTheme: textTheme),
              ],
            ),
          ),
          // Main Content
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(48.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                   Text('Vue d\'ensemble', style: textTheme.headlineLarge),
                   const SizedBox(height: 48),
                   Row(
                     children: [
                       _StatCard(title: 'Billets Vendus', value: '${stats['total_sold']}', textTheme: textTheme),
                       const SizedBox(width: 24),
                       _StatCard(title: 'Billets Valides', value: '${stats['valid']}', textTheme: textTheme),
                       const SizedBox(width: 24),
                       _StatCard(title: 'Billets Scannés', value: '${stats['scanned']}', textTheme: textTheme),
                     ],
                   ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}

class _StatCard extends StatelessWidget {
  final String title;
  final String value;
  final TextTheme textTheme;

  const _StatCard({required this.title, required this.value, required this.textTheme});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(32),
        decoration: BoxDecoration(
          color: AppColors.surfaceContainerLowest,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title, style: textTheme.labelLarge?.copyWith(color: AppColors.primaryDim)),
            const SizedBox(height: 16),
            Text(value, style: textTheme.displayLarge?.copyWith(color: AppColors.primary)),
          ],
        ),
      ),
    );
  }
}

class _SidebarItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final bool isActive;
  final TextTheme textTheme;

  const _SidebarItem({
    required this.icon,
    required this.label,
    required this.isActive,
    required this.textTheme,
  });

  @override
  Widget build(BuildContext context) {
    final color = isActive ? AppColors.primary : AppColors.onSurface.withOpacity(0.6);
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: isActive ? AppColors.surfaceContainerLowest : Colors.transparent,
        borderRadius: BorderRadius.circular(6),
      ),
      child: Row(
        children: [
          Icon(icon, color: color, size: 20),
          const SizedBox(width: 12),
          Text(label, style: textTheme.labelLarge?.copyWith(color: color)),
        ],
      ),
    );
  }
}
