import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../core/routes.dart';
import '../../main.dart';

class LoginView extends StatelessWidget {
  const LoginView({super.key});

  void _navigateToHome() {
    Get.offAllNamed(AppRoutes.home);
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final customColors = CustomColors.of(context);
    final colorScheme = theme.colorScheme;

    return Scaffold(
      appBar: AppBar(
        title: Text('Welcome Back', style: theme.textTheme.titleLarge),
        actions: [
          TextButton(
            onPressed: _navigateToHome,
            child: Text(
              'Skip Auth',
              style: theme.textTheme.labelLarge?.copyWith(
                color: colorScheme.primary,
              ),
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              // Logo/Icon
              Container(
                width: 80,
                height: 80,
                decoration: BoxDecoration(
                  color: customColors.primaryContainer,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Icon(
                  Icons.hiking,
                  size: 40,
                  color: colorScheme.primary,
                ),
              ),
              const SizedBox(height: 32),

              Text(
                'Sign in to Adventure Hive',
                style: theme.textTheme.headlineSmall,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 8),
              Text(
                'Plan your next adventure with AI assistance',
                style: theme.textTheme.bodyMedium,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 32),

              // Email field
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'Email',
                  labelStyle: theme.textTheme.bodyMedium,
                ),
              ),
              const SizedBox(height: 16.0),

              // Password field
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'Password',
                  labelStyle: theme.textTheme.bodyMedium,
                ),
                obscureText: true,
              ),
              const SizedBox(height: 24.0),

              // Login button
              SizedBox(
                width: double.infinity,
                height: 48,
                child: ElevatedButton(
                  onPressed: _navigateToHome,
                  child: Text('Sign In',
                      style: theme.textTheme.titleMedium
                          ?.copyWith(color: Colors.white)),
                ),
              ),
              const SizedBox(height: 16.0),

              Text('or', style: theme.textTheme.bodyMedium),
              const SizedBox(height: 16.0),

              // Google login
              SizedBox(
                width: double.infinity,
                height: 48,
                child: OutlinedButton.icon(
                  onPressed: _navigateToHome,
                  icon: Icon(Icons.login,
                      color: theme.textTheme.bodyMedium?.color),
                  label: Text(
                    'Continue with Google',
                    style: theme.textTheme.titleMedium
                        ?.copyWith(color: theme.textTheme.bodyMedium?.color),
                  ),
                ),
              ),
              const SizedBox(height: 32.0),

              // Signup link
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Don't have an account? ",
                    style: theme.textTheme.bodyMedium,
                  ),
                  TextButton(
                    onPressed: () => Get.toNamed(AppRoutes.signup),
                    child: Text(
                      'Sign Up',
                      style: theme.textTheme.bodyMedium?.copyWith(
                        color: colorScheme.primary,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
