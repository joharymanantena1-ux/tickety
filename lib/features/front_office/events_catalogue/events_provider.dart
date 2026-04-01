import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/mcp_mock/mcp_mock_client.dart';
import '../../../core/mcp_mock/models.dart';

final eventsProvider = FutureProvider<List<Event>>((ref) async {
  return ref.watch(mcpClientProvider).getEvents();
});

// A provider to fetch a single event by ID
final eventDetailProvider = FutureProvider.family<Event, String>((ref, id) async {
  final events = await ref.watch(eventsProvider.future);
  return events.firstWhere((e) => e.id == id);
});
