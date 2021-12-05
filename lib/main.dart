import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smolstocks/env.dart';
import 'package:smolstocks/login.dart';
import 'package:smolstocks/profile.dart';
import 'package:smolstocks/shop_view.dart';
import 'package:smolstocks/utils/color.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Smol Stocks',
      theme: ThemeData(
          primarySwatch: Colors.blue, scaffoldBackgroundColor: Colors.white),
      home: const Launcher(),
      // home: ProfileLauncher(),
    );
  }
}

class Launcher extends StatefulWidget {
  const Launcher({Key? key}) : super(key: key);

  @override
  _LauncherState createState() => _LauncherState();
}

class _LauncherState extends State<Launcher> {
  final Future<FirebaseApp> _initialization = Firebase.initializeApp(
      options: const FirebaseOptions(
          apiKey: apiKey,
          appId: appId,
          messagingSenderId: messageId,
          projectId: projectId));
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      // Initialize FlutterFire:
      future: _initialization,
      builder: (context, snapshot) {
        // Check for errors
        if (snapshot.hasError) {
          debugPrint(snapshot.error.toString());
          return const Scaffold(
            body: Center(
              child: Text("Error environment variables not found"),
            ),
          );
        }

        // Once complete, show your application
        if (snapshot.connectionState == ConnectionState.done) {
          return const AuthListener();
        }

        // Otherwise, show something whilst waiting for initialization to complete
        return Scaffold(
          body: Center(
            child: CircularProgressIndicator(
              color: blue,
            ),
          ),
        );
      },
    );
  }
}

class AuthListener extends StatefulWidget {
  const AuthListener({Key? key}) : super(key: key);

  @override
  _AuthListenerState createState() => _AuthListenerState();
}

class _AuthListenerState extends State<AuthListener> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (BuildContext context, snapshot) {
        if (snapshot.hasData) {
          if (snapshot.data!.isAnonymous) {
            return const LoginScreen();
          } else {
            return const ShopView();
          }
        } else {
          return const LoginScreen();
        }
      },
    );
  }
}
