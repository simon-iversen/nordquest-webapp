import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nordquest_webapp/src/design_system/foundations/app_radius.dart';
import 'package:nordquest_webapp/src/design_system/foundations/app_spacing.dart';
import 'package:nordquest_webapp/src/design_system/foundations/app_typography.dart';
import 'package:nordquest_webapp/src/features/auth/logic/auth_providers.dart';

class LoginScreen extends ConsumerStatefulWidget {
  const LoginScreen({super.key});

  @override
  ConsumerState<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _login() async {
    if (_emailController.text.isNotEmpty &&
        _passwordController.text.isNotEmpty) {
      await ref
          .read(authNotifierProvider)
          .login(_emailController.text.trim(), _passwordController.text);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF1F8F4),
      body: Center(
        child: Container(
          width: 420,
          padding: const EdgeInsets.all(AppSpacing.xl + AppSpacing.md),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(AppRadius.xl),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withAlpha(20),
                blurRadius: AppTypography.xl,
                offset: const Offset(0, 8),
              ),
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Icon(Icons.terrain, size: 56, color: Color(0xFF2D6A4F)),
              const SizedBox(height: AppSpacing.sm + AppSpacing.xs),
              const Text(
                'NordQuest',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: AppTypography.heading,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF1B4332),
                  letterSpacing: -0.5,
                ),
              ),
              const SizedBox(height: AppSpacing.sm - AppSpacing.xs),
              const Text(
                "Explore Norway's wilderness",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: AppTypography.sm,
                  color: Color(0xFF6B7280),
                ),
              ),
              const SizedBox(height: AppSpacing.xl + AppSpacing.sm),
              TextField(
                controller: _emailController,
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(
                  labelText: 'Email',
                  prefixIcon: const Icon(Icons.email_outlined),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(AppRadius.button),
                  ),
                ),
              ),
              const SizedBox(height: AppSpacing.md),
              TextField(
                controller: _passwordController,
                obscureText: true,
                decoration: InputDecoration(
                  labelText: 'Password',
                  prefixIcon: const Icon(Icons.lock_outline),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(AppRadius.button),
                  ),
                ),
                onSubmitted: (_) => _login(),
              ),
              const SizedBox(height: AppSpacing.lg + AppSpacing.xs),
              SizedBox(
                height: 50,
                child: ElevatedButton(
                  onPressed: _login,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF2D6A4F),
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(AppRadius.button),
                    ),
                    textStyle: const TextStyle(
                      fontSize: AppTypography.md,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  child: const Text('Login'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
