import 'package:firebase_app_check/firebase_app_check.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:indiazona/src/logic/provider/auth_provider.dart';
import 'package:indiazona/src/presentation/ui/auth/signup_screen_ui.dart';
import 'package:provider/provider.dart';
const kWebRecaptchaSiteKey = '6LfwYBQrAAAAABPp5fJO00R2KQ8zuq48eE-OAtMz';

Future<void> main() async {
  await Firebase.initializeApp(
      options: const FirebaseOptions(
          apiKey: "AIzaSyBMhgCfdsmssQWCUxw9ivAV0PzX2Pm1H08",
          authDomain: "indiazona-d54d0.firebaseapp.com",
          projectId: "indiazona-d54d0",
          storageBucket: "indiazona-d54d0.firebasestorage.app",
          messagingSenderId: "855599824563",
          appId: "1:855599824563:web:c16f34e081c1c874e7bac6",
          measurementId: "G-M79SS02KKT"));
           try {
  await FirebaseAppCheck.instance.activate(
  webProvider: ReCaptchaV3Provider(
    kWebRecaptchaSiteKey,
   ),
 );

 } catch (e) {
   print("Error with app check $e");
 }


  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(create: (_) => AuthProvider()),
  ], child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(1440, 1024), // Based on Figma design resolution
      builder: (context, child) => MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(fontFamily: GoogleFonts.inter().fontFamily),
        home: RegisterScreen(),
      ),
    );
  }
}
