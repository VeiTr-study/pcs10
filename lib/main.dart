import 'package:flutter/material.dart';
import 'package:pcs8/pages/login_page.dart';
import 'package:pcs8/pages/main_page.dart';
import 'package:pcs8/pages/profile_page.dart';
import 'package:pcs8/pages/signup_page.dart';
import 'package:pcs8/theme.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Supabase.initialize(
    url: 'https://mkkqhtdnnwqrfmnstqma.supabase.co',
    anonKey: 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Im1ra3FodGRubndxcmZtbnN0cW1hIiwicm9sZSI6ImFub24iLCJpYXQiOjE3MzUwMzM2OTMsImV4cCI6MjA1MDYwOTY5M30.wTlEko7aWfefE63ZP2X_9niK60mULorxBwRLXK_USks',
  );
  runApp(const MyApp());
}
final supabase = Supabase.instance.client;
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'PCS10',
      theme: appTheme,
      initialRoute: '/',
      routes: {
        '/': (context) => const AuthGate(),
        '/login': (context) => const LoginPage(),
        '/signup': (context) => const SignupPage(),
        '/profile': (context) => ProfilePage(),
      },
    );
  }
}

class AuthGate extends StatelessWidget {
  const AuthGate({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<AuthState>(
      stream: Supabase.instance.client.auth.onAuthStateChange,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }
        final session = Supabase.instance.client.auth.currentSession;

        if (session != null) {
          return MainPage();
        } else {
          return const LoginPage();
        }
      },
    );
  }
}
