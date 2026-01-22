import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:pinput/pinput.dart';
import 'package:tech_podcast_mobile/core/theme/app_theme.dart';

import 'package:tech_podcast_mobile/core/providers/dummy_user_provider.dart';

class OtpScreen extends ConsumerStatefulWidget {
  final String phone;

  const OtpScreen({super.key, required this.phone});

  @override
  ConsumerState<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends ConsumerState<OtpScreen> {
  final _pinController = TextEditingController();
  bool _isLoading = false;

  // Design color
  static const Color _pinkAccent = Color(0xFFE91E63);

  Future<void> _verifyOtp(String pin) async {
    setState(() => _isLoading = true);
    
    // DUMMY AUTH LOGIC
    await Future.delayed(const Duration(milliseconds: 500)); // Simulating network
    
    if (pin == '123456') {

      // Set Dummy User State to TRUE
      ref.read(dummyUserProvider.notifier).login();

      // if (mounted) {
      //   // Navigate to Home - Router will handle this automatically now with the state change
      //   context.go('/'); 
      // }
    } else {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Invalid code. Use 123456')),
        );
        _pinController.clear();
      }
    }
    
    if (mounted) setState(() => _isLoading = false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Use theme default
      appBar: AppBar(
        // backgroundColor: Use theme default
        iconTheme: const IconThemeData(color: Colors.white),
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Enter verification code',
              style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 12),
            RichText(
              text: TextSpan(
                style: const TextStyle(color: Colors.white60, fontSize: 16),
                children: [
                  const TextSpan(text: 'Sent to '),
                  TextSpan(
                    text: widget.phone,
                    style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 48),
            
            Center(
              child: Pinput(
                controller: _pinController,
                length: 6,
                onCompleted: _verifyOtp,
                defaultPinTheme: PinTheme(
                  width: 50,
                  height: 60,
                  textStyle: const TextStyle(
                    fontSize: 24,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                  decoration: BoxDecoration(
                    color: const Color(0xFF1F2937),
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                focusedPinTheme: PinTheme(
                  width: 50,
                  height: 60,
                  textStyle: const TextStyle(fontSize: 24, color: Colors.white),
                  decoration: BoxDecoration(
                    color: const Color(0xFF1F2937),
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: _pinkAccent, width: 2),
                  ),
                ),
                cursor: Container(
                  width: 2,
                  height: 30,
                  color: _pinkAccent,
                ),
              ),
            ),
            
            const Spacer(),
            
            if (_isLoading)
              const Center(child: CircularProgressIndicator(color: _pinkAccent)),
              
            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }
}
