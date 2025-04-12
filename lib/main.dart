import 'package:firebase_app_check/firebase_app_check.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:indiazona/src/logic/provider/auth_provider.dart';
import 'package:indiazona/src/presentation/ui/auth/signup_screen_ui.dart';
import 'package:provider/provider.dart';

const kWebRecaptchaSiteKey = '6Lc7mhUrAAAAALvW8KWQcTu1lMPUlKWNNTILH_Sw';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  try {
    await Firebase.initializeApp(
      options: const FirebaseOptions(
       apiKey: "AIzaSyBVOlVAUZ7lT9DddBRW1JR8938DGpNqFf0",
          authDomain: "indiazona-f3b2b.firebaseapp.com",
          projectId: "indiazona-f3b2b",
          storageBucket: "indiazona-f3b2b.firebasestorage.app",
          messagingSenderId: "551163400627",
          appId: "1:551163400627:web:4c506c424ad8804f46fbc6",
          measurementId: "G-Q3Y2SRB0JL"
      ),
    );
    print("Firebase initialization successful");

    // If you want to check Firebase App Check:
   await FirebaseAppCheck.instance.activate(
      webProvider: ReCaptchaV3Provider(
          '6Lf9nhUrAAAAALGRlsmtgWCXpKGb6NECggSwxUUr'), // Replace with your real key
    );
    print("Firebase AppCheck initialized successfully");
  } catch (e) {
    print("Error initializing Firebase: $e");
  }
  
  

  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (_) => AuthProvider()),
    ],
    child: const MyApp(),
  ));
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


