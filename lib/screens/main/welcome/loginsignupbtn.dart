import 'package:flutter/material.dart';
import 'package:flutter_application_1/screens/main/login%20screens/loginform.dart';
import 'package:flutter_application_1/screens/main/signupscreens/form.dart';
import 'package:flutter_application_1/api_service.dart';

class LoginAndSignupBtn extends StatefulWidget {
  const LoginAndSignupBtn({super.key});

  @override
  State<LoginAndSignupBtn> createState() => _LoginAndSignupBtnState();
}

class _LoginAndSignupBtnState extends State<LoginAndSignupBtn> {
  bool _isLoggedIn = false;

  @override
  void initState() {
    super.initState();
    _checkLoginStatus();
  }

  Future<void> _checkLoginStatus() async {
    final loggedIn = await isLoggedIn();
    setState(() {
      _isLoggedIn = loggedIn;
    });

    if (loggedIn) {
      // Navigate to home if already logged in
      Navigator.of(context).pushReplacementNamed('/home');
    }
  }

  void _showLoginPopup(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext dialogContext) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          contentPadding: const EdgeInsets.all(20),
          content: SingleChildScrollView(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 400),
              child: const LoginForm(),
            ),
          ),
        );
      },
    );
  }

  void _showsignupPopup(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext dialogContext) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          contentPadding: const EdgeInsets.all(20),
          content: SingleChildScrollView(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 400),
              child: const SignUpForm(),
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoggedIn) {
      return const SizedBox.shrink(); // Hide buttons if already logged in
    }

    return Column(
      children: [
        ElevatedButton(
          onPressed: () => _showLoginPopup(context),
          child: Text("Login".toUpperCase()),
        ),
        const SizedBox(height: 16),
        ElevatedButton(
          onPressed: () => _showsignupPopup(context),
          child: Text(
            "Sign Up".toUpperCase(),
            style: const TextStyle(color: Colors.black),
          ),
        ),
      ],
    );
  }
}
