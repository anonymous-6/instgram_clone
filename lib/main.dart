// ignore_for_file: prefer_const_constructors

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:instagram_clone/responsives/mobilescreenlayout.dart';
import 'package:instagram_clone/responsives/responsive_layout.dart';
import 'package:instagram_clone/responsives/webscreenlayout.dart';
import 'package:instagram_clone/screens/login_screen.dart';
import 'package:instagram_clone/screens/sign_up.dart';
import 'package:instagram_clone/utils/colors.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  if (kIsWeb) {
    await Firebase.initializeApp(
        options: const FirebaseOptions(
            apiKey: "AIzaSyDlKFCrUCgCwVQLMCs2f7EErng5D3-xuEU",
            appId: "1:364920529865:web:7cf13c0e8bc0876758fe18",
            messagingSenderId: "364920529865",
            projectId: "instagram-clone-fb22b",
            storageBucket: "instagram-clone-fb22b.appspot.com"));
  } else {
    await Firebase.initializeApp();
  }

  runApp(const InstagramClone());
}

class InstagramClone extends StatelessWidget {
  const InstagramClone({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'instagram clone',
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: mobileBackgroundColor,
      ),
      // home: SignUpScreen(),
      // home: ResponsiveLayout(
      //   mobilescreenlayout: MobilescreenLayout(),
      //   webscreenlayout: WebscreenLayout(),
      home: StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.active) {
            if (snapshot.hasData) {
              return ResponsiveLayout(
                mobilescreenlayout: MobilescreenLayout(),
                webscreenlayout: WebscreenLayout(),
              );
            } else if (snapshot.hasError) {
              return Center(
                child: Text('error'),
              );
            }
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(
                color: primaryColor,
              ),
            );
          }
          return const LoginScreen();
        },
      ),
    );
  }
}
