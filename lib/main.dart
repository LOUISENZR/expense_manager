import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'screens/login_screen.dart';
import 'screens/home_screen.dart';

// Ensures that widget binding is initialized before using plugins (e.g., SharedPreferences) in async main.
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final prefs = await SharedPreferences.getInstance();
  final String? loggedInUser = prefs.getString('loggedInUser');

  runApp(MyApp(isLoggedIn: loggedInUser != null));
}

class MyApp extends StatelessWidget {
  final bool isLoggedIn;
  const MyApp({super.key, required this.isLoggedIn});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: _getHomeScreen(),
    );
  }

  _getHomeScreen() {
    return isLoggedIn ? const HomeScreen() : const LoginScreen();
  }
}
