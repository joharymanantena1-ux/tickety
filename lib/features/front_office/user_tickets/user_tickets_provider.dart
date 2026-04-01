import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/mcp_mock/mcp_mock_client.dart';
import '../../../core/mcp_mock/models.dart';

final userTicketsProvider = FutureProvider<List<Ticket>>((ref) async {
  return ref.watch(mcpClientProvider).getUserTickets();
});

final ticketDetailProvider = FutureProvider.family<Ticket, String>((ref, ticketId) async {
  final tickets = await ref.watch(userTicketsProvider.future);
  return tickets.firstWhere((t) => t.id == ticketId);
});
