import 'package:flutter/material.dart';
import 'package:flutter_application_1/screens/main/login%20screens/account.dart';
import 'package:flutter_application_1/screens/main/login%20screens/loginform.dart';

class SignUpForm extends StatelessWidget {
  const SignUpForm({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scrollbar(
      thumbVisibility: true, 
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(12.0),
        child: Form(
          child: Column(
            children: [
              TextFormField(
                keyboardType: TextInputType.emailAddress,
                textInputAction: TextInputAction.next,
                cursorColor: Colors.blue,
                decoration: const InputDecoration(
                  hintText: "Your email",
                  prefixIcon: Padding(
                    padding: EdgeInsets.all(10.0),
                    child: Icon(Icons.email),
                  ),
                ),
              ),
              const SizedBox(height: 5),
              TextFormField(
                textInputAction: TextInputAction.next,
                cursorColor: Colors.blue,
                decoration: const InputDecoration(
                  hintText: "Username",
                  prefixIcon: Padding(
                    padding: EdgeInsets.all(10.0),
                    child: Icon(Icons.person),
                  ),
                ),
              ),
              const SizedBox(height: 5),
              TextFormField(
                textInputAction: TextInputAction.next,
                cursorColor: Colors.blue,
                decoration: const InputDecoration(
                  hintText: "First name",
                  prefixIcon: Padding(
                    padding: EdgeInsets.all(10.0),
                    child: Icon(Icons.person_outline),
                  ),
                ),
              ),
              const SizedBox(height: 5),
              TextFormField(
                textInputAction: TextInputAction.next,
                cursorColor: Colors.blue,
                decoration: const InputDecoration(
                  hintText: "Last name",
                  prefixIcon: Padding(
                    padding: EdgeInsets.all(10.0),
                    child: Icon(Icons.person_outline),
                  ),
                ),
              ),
              const SizedBox(height: 5),
              TextFormField(
                obscureText: true,
                textInputAction: TextInputAction.next,
                cursorColor: Colors.blue,
                decoration: const InputDecoration(
                  hintText: "Password",
                  prefixIcon: Padding(
                    padding: EdgeInsets.all(10.0),
                    child: Icon(Icons.lock),
                  ),
                ),
              ),
              const SizedBox(height: 5),
              TextFormField(
                obscureText: true,
                textInputAction: TextInputAction.done,
                cursorColor: Colors.blue,
                decoration: const InputDecoration(
                  hintText: "Confirm password",
                  prefixIcon: Padding(
                    padding: EdgeInsets.all(10.0),
                    child: Icon(Icons.lock_outline),
                  ),
                ),
              ),
              const SizedBox(height: 5),
              ElevatedButton(
                onPressed: () {
                 Navigator.of(context).pushReplacementNamed('/ LoginForm');

                },
                child: const Text("SIGN UP"),
              ),
              const SizedBox(height: 5),
              AlreadyHaveAnAccountCheck(
                login: false,
                press: () {
                  Navigator.pop(context);
                   showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    contentPadding: const EdgeInsets.all(20),
                    content: const LoginForm(),
                  );
                },
              ); // login
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
