import 'package:flutter/material.dart';
import 'package:flutter_application_1/screens/main/login%20screens/account.dart';
import 'package:flutter_application_1/screens/main/signupscreens/form.dart';

class LoginForm extends StatelessWidget {
  const LoginForm({super.key});

  @override
  Widget build(BuildContext context) {
    return Form(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextFormField(
            keyboardType: TextInputType.emailAddress,
            textInputAction: TextInputAction.next,
            cursorColor: Colors.blue,
            decoration: const InputDecoration(
              hintText: "Your email",
              prefixIcon: Padding(
                padding: EdgeInsets.all(16.0),
                child: Icon(Icons.person),
              ),
            ),
          ),
          const SizedBox(height: 16.0),
          TextFormField(
            textInputAction: TextInputAction.done,
            obscureText: true,
            cursorColor: Colors.blue,
            decoration: const InputDecoration(
              hintText: "Your password",
              prefixIcon: Padding(
                padding: EdgeInsets.all(16.0),
                child: Icon(Icons.lock),
              ),
            ),
          ),
          const SizedBox(height: 16.0),
          ElevatedButton(
            onPressed: () {
              Navigator.of(context).pushReplacementNamed('/home');
            },
            child: const Text("LOGIN"),
          ),
          const SizedBox(height: 16.0),
          AlreadyHaveAnAccountCheck(
            login: true,
            press: () {
              Navigator.of(context).pop(); // close login popup
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    contentPadding: const EdgeInsets.all(20),
                    content: const SignUpForm(),
                  );
                },
              );
            },
          ),
        ],
      ),
    );
  }
}
