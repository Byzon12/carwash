import 'package:flutter/material.dart';
import 'package:flutter_application_1/screens/main/welcome/splash.dart';
import 'package:flutter_application_1/utilites/provider.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;

import 'cart.dart';
import 'api_service.dart';
import 'home.dart';
import 'screens/main/login screens/loginform.dart';

void main() {
  runApp(const CarWashApp());
}

class CarWashApp extends StatelessWidget {
  const CarWashApp({super.key});

  @override
  Widget build(BuildContext context) {
    final ColorScheme colorScheme = ColorScheme.fromSeed(
      seedColor: Colors.blue,
      brightness: Brightness.light,
      secondary: Colors.green,
      tertiary: Colors.blue,
    );

    final ThemeData theme = ThemeData(
      colorScheme: colorScheme,
      useMaterial3: true,
      appBarTheme: AppBarTheme(
        backgroundColor: Colors.blue,
        foregroundColor: colorScheme.onPrimary,
        elevation: 4,
      ),
      floatingActionButtonTheme: FloatingActionButtonThemeData(
        backgroundColor: colorScheme.secondary,
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: colorScheme.primary,
          foregroundColor: colorScheme.onPrimary,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          padding: const EdgeInsets.all(20),
          textStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          minimumSize: const Size(300, 56),
        ),
      ),
      cardTheme: CardThemeData(
        color: colorScheme.surface,
        elevation: 6,
        margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 12),
        shadowColor: Colors.black.withOpacity(0.2),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      ),
      listTileTheme: ListTileThemeData(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        tileColor: colorScheme.surfaceContainerHighest,
        iconColor: colorScheme.primary,
        textColor: colorScheme.onSurface,
        contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
      ),
      textTheme: TextTheme(
        titleLarge: TextStyle(
          color: colorScheme.onSurface,
          fontWeight: FontWeight.bold,
        ),
        bodyMedium: TextStyle(color: colorScheme.onSurfaceVariant),
      ),
      splashColor: colorScheme.secondary.withOpacity(0.3),
      highlightColor: colorScheme.secondary.withOpacity(0.1),
    );

    return MultiProvider(
      providers: [ChangeNotifierProvider(create: (_) => CartProvider())],
      child: MaterialApp(
        title: 'Car Wash Booking',
        theme: theme,
        debugShowCheckedModeBanner: false,
        home: const AuthWrapper(), // Changed from initialRoute
        routes: {
          '/': (context) => const AuthWrapper(),
          '/home': (context) => const HomePage(),
          '/login': (context) => const LoginForm(),
          '/cart': (context) => const CartPage(),
        },
      ),
    );
  }
}

// New AuthWrapper widget to handle authentication state
class AuthWrapper extends StatefulWidget {
  const AuthWrapper({super.key});

  @override
  State<AuthWrapper> createState() => _AuthWrapperState();
}

class _AuthWrapperState extends State<AuthWrapper> {
  bool _isLoading = true;
  bool _isLoggedIn = false;

  @override
  void initState() {
    super.initState();
    _checkAuthStatus();
  }

  Future<void> _checkAuthStatus() async {
    try {
      final loggedIn = await isLoggedIn();
      if (loggedIn) {
        // Verify token is still valid
        final tokenValid = await verifyToken();
        setState(() {
          _isLoggedIn = tokenValid;
          _isLoading = false;
        });
      } else {
        setState(() {
          _isLoggedIn = false;
          _isLoading = false;
        });
      }
    } catch (e) {
      setState(() {
        _isLoggedIn = false;
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return const Scaffold(
        body: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }

    if (_isLoggedIn) {
      return const HomePage();
    } else {
      return const Splash();
    }
  }
}
