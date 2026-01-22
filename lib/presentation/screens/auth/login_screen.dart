import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:go_router/go_router.dart';
import 'package:tech_podcast_mobile/data/repositories/auth_repository.dart';
import 'package:tech_podcast_mobile/core/theme/app_theme.dart';

class LoginScreen extends ConsumerStatefulWidget {
  const LoginScreen({super.key});

  @override
  ConsumerState<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> {
  final _formKey = GlobalKey<FormBuilderState>();
  bool _isLoading = false;
  bool _showPhoneInput = false;

  // Pink color from the design image
  static const Color _pinkAccent = Color(0xFFE91E63);

  Future<void> _onPhoneSubmit() async {
    if (_formKey.currentState?.saveAndValidate() ?? false) {
      setState(() => _isLoading = true);
      // Combine country code and phone number if needed, for now just taking phone
      final phone = _formKey.currentState?.value['phone'] as String;
      // In a real app, you'd prepend the selected country code here, e.g. "+91$phone"
      
      try {
        // DUMMY AUTH: Bypass Supabase for now
        // await ref.read(authRepositoryProvider).signInWithOtp(phone: phone);
        
        await Future.delayed(const Duration(seconds: 1)); // Simulate network request

        if (mounted) {
          context.push('/otp', extra: phone);
        }
      } catch (e) {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Error: $e')),
          );
        }
      } finally {
        if (mounted) setState(() => _isLoading = false);
      }
    }
  }

  Future<void> _onGoogleSignIn() async {
    setState(() => _isLoading = true);
    try {
      await ref.read(authRepositoryProvider).signInWithGoogle();
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Google Sign-In Error: $e')),
        );
      }
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Use theme default
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 24.0),
          child: _showPhoneInput ? _buildPhoneEntryView() : _buildWelcomeView(),
        ),
      ),
    );
  }

  Widget _buildWelcomeView() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Spacer(),
        Text(
          'Welcome!',
          style: Theme.of(context).textTheme.headlineLarge?.copyWith(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 36,
          ),
        ),
        const SizedBox(height: 12),
        Text(
          'Sign in or create an account to get started',
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
            color: Colors.white60,
            fontSize: 16,
          ),
        ),
        const SizedBox(height: 48),
        
        // Buttons
        ElevatedButton(
          onPressed: () => setState(() => _showPhoneInput = true),
          style: ElevatedButton.styleFrom(
            backgroundColor: _pinkAccent,
            foregroundColor: Colors.white,
            padding: const EdgeInsets.symmetric(vertical: 18),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            minimumSize: const Size(double.infinity, 56),
          ),
          child: const Text('Continue with Phone', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
        ),
        const SizedBox(height: 16),
        OutlinedButton.icon(
          onPressed: _isLoading ? null : _onGoogleSignIn,
          icon: const Icon(Icons.g_mobiledata, color: Colors.white, size: 28),
          label: const Text('Continue with Google', style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold)),
          style: OutlinedButton.styleFrom(
            padding: const EdgeInsets.symmetric(vertical: 18),
            side: const BorderSide(color: Colors.white24),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            minimumSize: const Size(double.infinity, 56),
          ),
        ),
        const Spacer(),
      ],
    );
  }

  Widget _buildPhoneEntryView() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Back Button
        IconButton(
          onPressed: () => setState(() => _showPhoneInput = false),
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          padding: EdgeInsets.zero,
          alignment: Alignment.centerLeft,
        ),
        const SizedBox(height: 32),

        // Header
        Text(
          'Enter your phone',
          style: Theme.of(context).textTheme.headlineLarge?.copyWith(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 32,
          ),
        ),
        const SizedBox(height: 12),
        Text(
          "We'll send you a verification code",
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
            color: Colors.white60,
            fontSize: 16,
          ),
        ),
        const SizedBox(height: 48),

        FormBuilder(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'PHONE NUMBER',
                style: TextStyle(
                  color: Colors.white.withOpacity(0.5),
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  letterSpacing: 1.0,
                ),
              ),
              const SizedBox(height: 8),
              
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Country Code/Flag Mock
                  Container(
                    width: 110,
                    height: 56, // Fixed height to match input
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    decoration: BoxDecoration(
                      color: const Color(0xFF1F2937), // Dark grey
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'IN +91',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Icon(Icons.arrow_drop_down, color: Colors.white.withOpacity(0.5)),
                      ],
                    ),
                  ),
                  
                  const SizedBox(width: 12),
                  
                  // Phone Number Input
                  Expanded(
                    child: FormBuilderTextField(
                      name: 'phone',
                      decoration: InputDecoration(
                        hintText: 'Enter phone',
                        hintStyle: TextStyle(color: Colors.white.withOpacity(0.3)),
                        fillColor: const Color(0xFF1F2937), // Dark grey
                        filled: true,
                        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide.none,
                        ),
                        // Error style adjustments
                        errorStyle: const TextStyle(height: 0.8),
                      ),
                      style: const TextStyle(color: Colors.white, fontSize: 16),
                      cursorColor: _pinkAccent,
                      validator: FormBuilderValidators.compose([
                        FormBuilderValidators.required(),
                        FormBuilderValidators.numeric(),
                      ]),
                      keyboardType: TextInputType.phone,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        
        const Spacer(),
        
        // Continue Button
        Padding(
          padding: const EdgeInsets.only(bottom: 24),
          child: Column(
            children: [
              ElevatedButton(
                onPressed: _isLoading ? null : _onPhoneSubmit,
                style: ElevatedButton.styleFrom(
                  backgroundColor: _pinkAccent,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 18),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  minimumSize: const Size(double.infinity, 56),
                ),
                child: _isLoading
                    ? const SizedBox(
                        height: 24,
                        width: 24,
                        child: CircularProgressIndicator(color: Colors.white, strokeWidth: 2),
                      )
                    : const Text('Continue', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
              ),
              const SizedBox(height: 16),
              Text(
                'By continuing, you agree to our Terms & Privacy',
                style: TextStyle(color: Colors.white.withOpacity(0.4), fontSize: 12),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
