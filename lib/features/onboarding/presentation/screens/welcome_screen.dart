import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/app_typography.dart';
import '../providers/onboarding_providers.dart';

class WelcomeScreen extends ConsumerStatefulWidget {
  const WelcomeScreen({super.key});

  @override
  ConsumerState<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends ConsumerState<WelcomeScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _nameController = TextEditingController();
  bool _isLoading = false;

  @override
  void dispose() {
    _emailController.dispose();
    _nameController.dispose();
    super.dispose();
  }

  Future<void> _handleContinue() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _isLoading = true);

    try {
      final email = _emailController.text.trim();
      final name = _nameController.text.trim().isNotEmpty ? _nameController.text.trim() : null;

      ref.read(onboardingNotifierProvider.notifier).createUserProfile(email, name: name);

      // Navigation will be handled by the parent widget based on state changes
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error creating profile: $e')),
        );
      }
    } finally {
      if (mounted) {
        setState(() => _isLoading = false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final progress = ref.watch(onboardingProgressProvider);

    return SafeArea(
      child: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              padding: AppSpacing.screenPaddingAll,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Progress indicator
                  LinearProgressIndicator(
                    value: progress,
                    backgroundColor: AppColors.border,
                    valueColor: AlwaysStoppedAnimation<Color>(AppColors.primary),
                  ).animate().fadeIn(duration: 300.ms),

                  Gap(AppSpacing.xxl),

                  // Welcome content
                  Text(
                    'Welcome to Budget Tracker',
                    style: AppTypography.headlineLarge.copyWith(
                      color: AppColors.textPrimary,
                      fontWeight: FontWeight.w600,
                    ),
                  ).animate().slideY(begin: 0.3, duration: 400.ms).fadeIn(),

                  Gap(AppSpacing.md),

                  Text(
                    'Let\'s get you set up with personalized budgeting in just a few steps.',
                    style: AppTypography.bodyLarge.copyWith(
                      color: AppColors.textSecondary,
                    ),
                  ).animate().slideY(begin: 0.2, duration: 500.ms).fadeIn(),

                  Gap(AppSpacing.xxxl),

                  // Form
                  Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Name field (optional)
                        Text(
                          'What should we call you? (Optional)',
                          style: AppTypography.titleMedium.copyWith(
                            color: AppColors.textPrimary,
                            fontWeight: FontWeight.w500,
                          ),
                        ).animate().slideX(begin: 0.1, duration: 600.ms).fadeIn(),

                        Gap(AppSpacing.sm),

                        TextFormField(
                          controller: _nameController,
                          decoration: InputDecoration(
                            hintText: 'Enter your name',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(AppSpacing.radiusMd),
                            ),
                            contentPadding: AppSpacing.inputPaddingAll,
                          ),
                          style: AppTypography.bodyLarge,
                        ).animate().slideX(begin: 0.1, duration: 700.ms).fadeIn(),

                        Gap(AppSpacing.lg),

                        // Email field (required)
                        Text(
                          'Email Address',
                          style: AppTypography.titleMedium.copyWith(
                            color: AppColors.textPrimary,
                            fontWeight: FontWeight.w500,
                          ),
                        ).animate().slideX(begin: 0.1, duration: 800.ms).fadeIn(),

                        Gap(AppSpacing.sm),

                        TextFormField(
                          controller: _emailController,
                          keyboardType: TextInputType.emailAddress,
                          decoration: InputDecoration(
                            hintText: 'Enter your email',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(AppSpacing.radiusMd),
                            ),
                            contentPadding: AppSpacing.inputPaddingAll,
                          ),
                          style: AppTypography.bodyLarge,
                          validator: (value) {
                            if (value == null || value.trim().isEmpty) {
                              return 'Email is required';
                            }
                            final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
                            if (!emailRegex.hasMatch(value.trim())) {
                              return 'Please enter a valid email';
                            }
                            return null;
                          },
                        ).animate().slideX(begin: 0.1, duration: 900.ms).fadeIn(),

                        Gap(AppSpacing.sm),

                        Text(
                          'We\'ll use this to save your progress and send occasional tips.',
                          style: AppTypography.bodySmall.copyWith(
                            color: AppColors.textTertiary,
                          ),
                        ).animate().slideX(begin: 0.1, duration: 1000.ms).fadeIn(),

                        // Add bottom padding to ensure content doesn't get cut off
                        Gap(AppSpacing.xxxl),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          Container(
            padding: AppSpacing.screenPaddingAll,
            decoration: BoxDecoration(
              color: Theme.of(context).scaffoldBackgroundColor,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.05),
                  blurRadius: 4,
                  offset: const Offset(0, -2),
                ),
              ],
            ),
            child: Column(
              children: [
                // Continue button
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: _isLoading ? null : _handleContinue,
                    style: ElevatedButton.styleFrom(
                      padding: AppSpacing.buttonPaddingAll,
                      backgroundColor: AppColors.primary,
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(AppSpacing.radiusMd),
                      ),
                      elevation: AppSpacing.elevationSm,
                    ),
                    child: _isLoading
                        ? SizedBox(
                            height: AppSpacing.iconMd,
                            width: AppSpacing.iconMd,
                            child: CircularProgressIndicator(
                              strokeWidth: 2,
                              valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                            ),
                          )
                        : Text(
                            'Get Started',
                            style: AppTypography.buttonLarge,
                          ),
                  ),
                ).animate().slideY(begin: 0.2, duration: 1100.ms).fadeIn(),

                Gap(AppSpacing.md),

                // Terms and privacy
                Center(
                  child: Text(
                    'By continuing, you agree to our Terms of Service and Privacy Policy',
                    style: AppTypography.caption.copyWith(
                      color: AppColors.textTertiary,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ).animate().fadeIn(duration: 1200.ms),
              ],
            ),
          ),
        ],
      ),
    );
  }
}