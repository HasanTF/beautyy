import 'package:beuty_support/firebase/auth_layout.dart';
import 'package:beuty_support/screens/auth/user_services/change_password.dart';
import 'package:beuty_support/screens/auth/user_services/delete_account.dart';
import 'package:beuty_support/screens/auth/reset_password.dart';
import 'package:beuty_support/screens/auth/sign_in_screen.dart';
import 'package:beuty_support/screens/auth/sign_up_screen.dart';
import 'package:beuty_support/screens/auth/user_services/update_username.dart';
import 'package:beuty_support/screens/reviews/center_details.dart';
import 'package:beuty_support/screens/reviews/write_a_review.dart';
import 'package:beuty_support/screens/tabs.dart';
import 'package:beuty_support/screens/tabs/home_tab.dart';
import 'package:device_preview/device_preview.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

  try {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
    debugPrint("✅ Firebase initialized successfully");
  } catch (e) {
    debugPrint("Firebase initialization failed: $e");
  }

  runApp(
    // const MyApp(),
    DevicePreview(enabled: !kReleaseMode, builder: (context) => const MyApp()),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      restorationScopeId: "app",
      // useInheritedMediaQuery: false,
      locale: DevicePreview.locale(context),
      builder: DevicePreview.appBuilder,
      debugShowCheckedModeBanner: false,
      title: "Beauty Support",
      initialRoute: "/",
      routes: {
        "/": (context) => AuthLayout(),
        "/login": (context) => SignInScreen(),
        "/signup": (context) => SignUpScreen(),
        "/hometab": (context) => HomeTab(),
        "/tabs": (context) => Tabs(),
        "/centerdetails": (context) => CenterDetails(),
        "/writeareview": (context) => WriteAReview(),
        "/resetpassword": (context) => ResetPassword(),
        "/changepassword": (context) => ChangePassword(),
        "/updateusername": (context) => UpdateUsername(),
        "/deleteaccount": (context) => DeleteAccount(),
      },
    );
  }
}
