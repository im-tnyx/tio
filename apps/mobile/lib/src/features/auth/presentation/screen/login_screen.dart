import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import '../../../../core/theme/tokens/foundation/dimens.dart';
import '../../../../core/widgets/action_buttons.dart';
import '../../onboarding/presentation/provider/onboarding_provider.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _isLoading = false;
  bool _isSignUp = false;
  String? _errorMessage;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _handleSubmit() async {
    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });

    try {
      if (_isSignUp) {
        await Supabase.instance.client.auth.signUp(
          email: _emailController.text.trim(),
          password: _passwordController.text,
        );
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Registration successful! Please sign in.')),
          );
          setState(() {
            _isSignUp = false;
          });
        }
      } else {
        await Supabase.instance.client.auth.signInWithPassword(
          email: _emailController.text.trim(),
          password: _passwordController.text,
        );
        if (mounted) {
          final onboardingProvider = Provider.of<OnboardingProvider>(context, listen: false);
          final currentUser = Supabase.instance.client.auth.currentUser;
          if (currentUser != null && onboardingProvider.state.name.isNotEmpty) {
            try {
              await onboardingProvider.finalizeProfile(currentUser);
            } catch (e) {
              // Log or handle sync error if needed, proceed to main
            }
          }
          if (mounted) {
            context.go('/main');
          }
        }
      }
    } catch (e) {
      setState(() {
        _errorMessage = e.toString();
      });
    } finally {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  void _handleMockLogin() {
    // Navigate straight to onboarding as a mock developer user
    context.go('/onboarding');
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      backgroundColor: theme.colorScheme.surface,
      appBar: AppBar(
        title: Text(_isSignUp ? 'Create Account' : 'Sign In'),
        elevation: 0,
        backgroundColor: Colors.transparent,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(Dimens.paddingScreen),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(height: Dimens.spaceXL),
              Text(
                _isSignUp ? 'Join TIO OS' : 'Welcome Back',
                style: theme.textTheme.headlineMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: theme.colorScheme.onSurface,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: Dimens.spaceS),
              Text(
                _isSignUp
                    ? 'Start tracking your nutrition logs today.'
                    : 'Log in to sync your profile and text logs.',
                style: theme.textTheme.bodyMedium?.copyWith(
                  color: theme.colorScheme.onSurfaceVariant,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: Dimens.spaceXL),
              if (_errorMessage != null) ...[
                Container(
                  padding: const EdgeInsets.all(Dimens.spaceM),
                  decoration: BoxDecoration(
                    color: theme.colorScheme.errorContainer,
                    borderRadius: BorderRadius.circular(Dimens.radiusCard),
                  ),
                  child: Text(
                    _errorMessage!,
                    style: TextStyle(color: theme.colorScheme.onErrorContainer),
                    textAlign: TextAlign.center,
                  ),
                ),
                const SizedBox(height: Dimens.spaceM),
              ],
              TextField(
                controller: _emailController,
                decoration: const InputDecoration(
                  labelText: 'Email Address',
                  hintText: 'name@example.com',
                ),
                keyboardType: TextInputType.emailAddress,
              ),
              const SizedBox(height: Dimens.spaceM),
              TextField(
                controller: _passwordController,
                decoration: const InputDecoration(
                  labelText: 'Password',
                ),
                obscureText: true,
              ),
              const SizedBox(height: Dimens.spaceXL),
              if (_isLoading)
                const Center(child: CircularProgressIndicator())
              else ...[
                PrimaryButton(
                  text: _isSignUp ? 'Sign Up' : 'Sign In',
                  onPressed: _handleSubmit,
                  expand: true,
                ),
                const SizedBox(height: Dimens.spaceM),
                TextButton(
                  onPressed: () {
                    setState(() {
                      _isSignUp = !_isSignUp;
                      _errorMessage = null;
                    });
                  },
                  child: Text(
                    _isSignUp
                        ? 'Already have an account? Sign In'
                        : 'New to TIO? Create an Account',
                    style: TextStyle(color: theme.colorScheme.primary),
                  ),
                ),
                const SizedBox(height: Dimens.spaceXL),
                const Divider(),
                const SizedBox(height: Dimens.spaceL),
                SecondaryButton(
                  text: 'Quick Dev Mode (Bypass Auth/Local)',
                  onPressed: _handleMockLogin,
                  expand: true,
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
