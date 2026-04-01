import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../core/mcp_mock/mcp_mock_client.dart';
import '../../core/mcp_mock/models.dart';

final authStateProvider = StateNotifierProvider<AuthNotifier, AsyncValue<User?>>((ref) {
  return AuthNotifier(ref.watch(mcpClientProvider));
});

class AuthNotifier extends StateNotifier<AsyncValue<User?>> {
  final McpMockClient _api;

  AuthNotifier(this._api) : super(const AsyncData(null));

  Future<void> login(String email, String password) async {
    state = const AsyncLoading();
    try {
      final user = await _api.login(email, password);
      state = AsyncData(user);
    } catch (e, st) {
      state = AsyncError(e, st);
    }
  }

  void logout() {
    state = const AsyncData(null);
  }
}
