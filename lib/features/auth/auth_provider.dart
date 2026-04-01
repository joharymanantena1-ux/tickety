import 'dart:async';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../core/mcp_mock/mcp_mock_client.dart';
import '../../core/mcp_mock/models.dart';

final authStateProvider = AsyncNotifierProvider<AuthNotifier, User?>(() {
  return AuthNotifier();
});

class AuthNotifier extends AsyncNotifier<User?> {
  @override
  FutureOr<User?> build() {
    return null;
  }

  Future<void> login(String email, String password) async {
    state = const AsyncLoading();
    try {
      final api = ref.read(mcpClientProvider);
      final user = await api.login(email, password);
      state = AsyncData(user);
    } catch (e, st) {
      state = AsyncError(e, st);
    }
  }

  void logout() {
    state = const AsyncData(null);
  }
}
