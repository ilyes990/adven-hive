import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../core/routes.dart';
import '../../main.dart';

class SignupView extends StatelessWidget {
  const SignupView({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final customColors = CustomColors.of(context);
    final colorScheme = theme.colorScheme;

    return Scaffold(
      appBar: AppBar(
        title: Text('Create Account', style: theme.textTheme.titleLarge),
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
                'Join Adventure Hive',
                style: theme.textTheme.headlineSmall,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 8),
              Text(
                'Start planning amazing adventures with AI',
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

              // Sign up button
              SizedBox(
                width: double.infinity,
                height: 48,
                child: ElevatedButton(
                  onPressed: () {
                    // Handle email signup - navigate to home for now
                    Get.offAllNamed(AppRoutes.home);
                  },
                  child: Text('Create Account',
                      style: theme.textTheme.titleMedium
                          ?.copyWith(color: Colors.white)),
                ),
              ),
              const SizedBox(height: 16.0),

              Text('or', style: theme.textTheme.bodyMedium),
              const SizedBox(height: 16.0),

              // Google signup
              SizedBox(
                width: double.infinity,
                height: 48,
                child: OutlinedButton.icon(
                  onPressed: () {
                    // Handle Google signup - navigate to home for now
                    Get.offAllNamed(AppRoutes.home);
                  },
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

              // Login link
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Already have an account? ',
                    style: theme.textTheme.bodyMedium,
                  ),
                  TextButton(
                    onPressed: () => Get.toNamed(AppRoutes.login),
                    child: Text(
                      'Sign In',
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
