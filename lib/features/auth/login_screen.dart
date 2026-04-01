import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:tickety/core/theme/app_theme.dart';
import 'auth_provider.dart';
import '../../core/mcp_mock/models.dart';

class LoginScreen extends ConsumerStatefulWidget {
  const LoginScreen({super.key});

  @override
  ConsumerState<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> {
  final _emailCtrl = TextEditingController(text: 'client@company.com');
  final _passCtrl = TextEditingController(text: 'password');

  @override
  Widget build(BuildContext context) {
    final authState = ref.watch(authStateProvider);

    // Navigation on auth change
    ref.listen<AsyncValue<User?>>(authStateProvider, (prev, next) {
      next.whenData((user) {
        if (user != null) {
          if (user.role == Role.admin) {
            context.go('/admin/dashboard');
          } else {
            context.go('/client/catalogue');
          }
        }
      });
    });

    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      backgroundColor: AppColors.surface,
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                'Tickety',
                style: textTheme.displayLarge?.copyWith(
                  fontWeight: FontWeight.bold,
                  letterSpacing: -0.04,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 12),
              Text(
                'Par The Editorial Ledger',
                style: textTheme.bodyLarge?.copyWith(color: AppColors.primaryDim),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 64),
              Container(
                padding: const EdgeInsets.all(32),
                decoration: BoxDecoration(
                  color: AppColors.surfaceContainerLowest,
                  borderRadius: BorderRadius.circular(12),
                  // Ambient Layering
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text(
                      'Connexion',
                      style: textTheme.headlineSmall,
                    ),
                    const SizedBox(height: 32),
                    TextField(
                      controller: _emailCtrl,
                      decoration: const InputDecoration(labelText: 'Email'),
                    ),
                    const SizedBox(height: 16),
                    TextField(
                      controller: _passCtrl,
                      obscureText: true,
                      decoration: const InputDecoration(labelText: 'Mot de passe'),
                    ),
                    const SizedBox(height: 32),
                    SizedBox(
                      height: 52,
                      child: ElevatedButton(
                        onPressed: authState.isLoading
                            ? null
                            : () => ref
                                .read(authStateProvider.notifier)
                                .login(_emailCtrl.text, _passCtrl.text),
                        child: authState.isLoading
                            ? const CircularProgressIndicator(color: AppColors.surface)
                            : const Text('Se connecter'),
                      ),
                    ),
                    const SizedBox(height: 16),
                    OutlinedButton(
                      onPressed: () {
                         _emailCtrl.text = 'admin@tickety.com';
                      },
                      child: const Text('Autofill Admin'),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
