import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:indiazona/src/core/helper/extenstion.dart';
import 'package:indiazona/src/data/user_model.dart';

import 'package:indiazona/src/logic/services/auth_service.dart';

import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:indiazona/src/logic/services/auth_service.dart';
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kDebugMode, kIsWeb;
import 'package:firebase_auth_platform_interface/firebase_auth_platform_interface.dart';
import 'package:indiazona/src/presentation/ui/store/create_store_ui.dart';

class AuthProvider extends ChangeNotifier {
  final TextEditingController refelController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confprasswordController = TextEditingController();

  final AuthService _authService = AuthService();

  String? _verificationId;
  bool _isLoading = false;

  bool get isLoading => _isLoading;

  void _setLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  Future<void> sendOtp(BuildContext context) async {
    _setLoading(true);
    await FirebaseAuth.instance.setPersistence(Persistence.LOCAL);

    if (kIsWeb) {
      try {
        final auth = FirebaseAuth.instance;

        final verifier = RecaptchaVerifier(
          auth: FirebaseAuthPlatform.instanceFor(
              app: auth.app, pluginConstants: {}),
          container: 'recaptcha-container',
          size: RecaptchaVerifierSize.normal,
          theme: RecaptchaVerifierTheme.light,
        );

        await _authService.signInWithPhoneNumberWeb(
          phoneNumber: "+916393100157",
          verifier: verifier,
        );

        _setLoading(false);
        Navigator.pushNamed(context, '/otp'); // Navigate to OTP input screen
      } catch (e) {
        _setLoading(false);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Web OTP send failed: $e")),
        );
      }
    } else if (Platform.isAndroid || Platform.isIOS) {
      await _authService.verifyPhoneNumber(
        phoneNumber: phoneController.text,
        verificationCompleted: (credential) async {
          await _authService.signInWithCredential(credential);
          _setLoading(false);
          Navigator.pushReplacementNamed(context, '/home');
        },
        verificationFailed: (e) {
          _setLoading(false);
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text("Verification failed: ${e.message}")),
          );
        },
        codeSent: (verificationId, resendToken) {
          _verificationId = verificationId;
          _setLoading(false);
          Navigator.pushNamed(context, '/otp');
        },
        codeAutoRetrievalTimeout: (verificationId) {
          _verificationId = verificationId;
        },
      );
    } else {
      _setLoading(false);
      print('Unsupported platform for phone authentication.');
    }
  }

  Future<void> verifyOtp(String otp, BuildContext context) async {
    _setLoading(true);

    try {
      if (kIsWeb) {
        await _authService.confirmOtpWeb(otp);
      } else {
        final credential = PhoneAuthProvider.credential(
          verificationId: _verificationId!,
          smsCode: otp,
        );
        await _authService.signInWithCredential(credential);
      }

      _setLoading(false);
      Navigator.pushReplacementNamed(context, '/home');
    } catch (e) {
      _setLoading(false);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Invalid OTP or verification failed")),
      );
    }
  }

  Future<void> submitUserData(BuildContext context) async {
    final user = UserModel(
      referenceCode: refelController.text.trim(),
      name: nameController.text.trim(),
      email: emailController.text.trim(),
      phone: phoneController.text.trim(),
    );

    try {
      _isLoading = true;
      notifyListeners();

      await _authService.saveUserData(user);

      _isLoading = false;
      notifyListeners();

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("User data saved successfully")),
      );

      // Clear fields if needed
      refelController.clear();
      nameController.clear();
      emailController.clear();
      phoneController.clear();
      passwordController.clear();
      confprasswordController.clear();
    } catch (e) {
      _isLoading = false;
      notifyListeners();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Error: ${e.toString()}")),
      );
    }
  }

  Future<void> loginUser(BuildContext context) async {
    try {
      _isLoading = true;
      notifyListeners();

      final email = emailController.text.trim();
      final password = passwordController.text.trim();

      final user = await _authService.loginUser(email, password);

      _isLoading = false;
      notifyListeners();

      if (user != null) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Login successful!")),
        );

        Navigator.push(context,
            CustomPageTransitions.slide(const SellerRegistrationScreen()));
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("User not found!")),
        );
      }
    } catch (e) {
      _isLoading = false;
      notifyListeners();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Login failed: ${e.toString()}")),
      );
    }
  }

  void disposeControllers() {
    refelController.dispose();
    nameController.dispose();
    emailController.dispose();
    phoneController.dispose();
    passwordController.dispose();
    confprasswordController.dispose();
  }
}
