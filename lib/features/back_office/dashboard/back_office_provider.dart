import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/mcp_mock/mcp_mock_client.dart';
import '../../../core/mcp_mock/models.dart';

final allTicketsProvider = FutureProvider<List<Ticket>>((ref) async {
  return ref.watch(mcpClientProvider).getAllTickets();
});

final dashboardStatsProvider = Provider<Map<String, dynamic>>((ref) {
  final ticketsAsync = ref.watch(allTicketsProvider);
  return ticketsAsync.when(
    data: (tickets) {
      final valid = tickets.where((t) => t.status == TicketStatus.valid).length;
      final scanned = tickets.where((t) => t.status == TicketStatus.scanned).length;
      return {
        'total_sold': tickets.length,
        'valid': valid,
        'scanned': scanned,
      };
    },
    loading: () => {'total_sold': 0, 'valid': 0, 'scanned': 0},
    error: (e, st) => {'total_sold': 0, 'valid': 0, 'scanned': 0},
  );
});
