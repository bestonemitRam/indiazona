import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // Store confirmationResult for web
  ConfirmationResult? _confirmationResult;
  ConfirmationResult? get confirmationResult => _confirmationResult;

  // For Android/iOS
  Future<void> verifyPhoneNumber({
    required String phoneNumber,
    required Function(PhoneAuthCredential) verificationCompleted,
    required Function(FirebaseAuthException) verificationFailed,
    required Function(String, int?) codeSent,
    required Function(String) codeAutoRetrievalTimeout,
  }) async {
    if (!kIsWeb && (Platform.isAndroid || Platform.isIOS)) {
      await _auth.verifyPhoneNumber(
        phoneNumber: phoneNumber,
        verificationCompleted: verificationCompleted,
        verificationFailed: verificationFailed,
        codeSent: codeSent,
        codeAutoRetrievalTimeout: codeAutoRetrievalTimeout,
      );
    } else {
      throw UnimplementedError('Use `signInWithPhoneNumberWeb()` on web.');
    }
  }

  // For Web
  Future<void> signInWithPhoneNumberWeb({
    required String phoneNumber,
    required RecaptchaVerifier verifier,
  }) async {
    _confirmationResult =
        await _auth.signInWithPhoneNumber(phoneNumber, verifier);
  }


  // Complete sign-in on web
  Future<void> confirmOtpWeb(String otp) async {
    if (_confirmationResult != null) {
      await _confirmationResult!.confirm(otp);
    } else {
      throw FirebaseAuthException(
        code: 'missing-confirmation',
        message: 'No confirmation result found. Please request OTP again.',
      );
    }
  }

  Future<UserCredential> signInWithCredential(PhoneAuthCredential credential) {
    return _auth.signInWithCredential(credential);
  }

  User? getCurrentUser() => _auth.currentUser;
}
