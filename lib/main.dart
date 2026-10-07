import 'package:firebase_core/firebase_core.dart';

import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/material.dart';

import 'app/app.dart';

import 'screens/auth_screen.dart';

Future<void> main() async {

  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp();

  runApp(const PulseRoot());

}

class PulseRoot extends StatelessWidget {

  const PulseRoot({super.key});

  @override

  Widget build(BuildContext context) {

    return MaterialApp(

      debugShowCheckedModeBanner: false,

      title: 'PULSE',

      theme: ThemeData(

        brightness: Brightness.dark,

        useMaterial3: true,

        scaffoldBackgroundColor: Colors.black,

        colorScheme: ColorScheme.fromSeed(

          seedColor: Colors.deepPurple,

          brightness: Brightness.dark,

        ),

      ),

      home: const AuthGate(),

    );

  }

}

class AuthGate extends StatelessWidget {

  const AuthGate({super.key});

  @override

  Widget build(BuildContext context) {

    return StreamBuilder<User?>(

      stream: FirebaseAuth.instance.authStateChanges(),

      builder: (context, snapshot) {

        if (snapshot.connectionState == ConnectionState.waiting) {

          return const Scaffold(

            backgroundColor: Colors.black,

            body: Center(

              child: CircularProgressIndicator(),

            ),

          );

        }

        if (snapshot.hasData) {

          return const PulseHome();

        }

        return const AuthScreen();

      },

    );

  }

}