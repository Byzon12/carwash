import 'package:flutter/material.dart';
import 'package:flutter_application_1/screens/main/login%20screens/account.dart';
import 'package:flutter_application_1/screens/main/login%20screens/loginform.dart';
import 'package:flutter_application_1/api_service.dart'; // Import your API service

class SignUpForm extends StatefulWidget {
  const SignUpForm({super.key});

  @override
  State<SignUpForm> createState() => _SignUpFormState();
}

class _SignUpFormState extends State<SignUpForm> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _usernameController = TextEditingController();
  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  bool _isLoading = false;

  @override
  void dispose() {
    _emailController.dispose();
    _usernameController.dispose();
    _firstNameController.dispose();
    _lastNameController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  Future<void> _handleSignUp() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    setState(() {
      _isLoading = true;
    });

    try {
      await registerUser(
        username: _usernameController.text.trim(),
        email: _emailController.text.trim(),
        firstName: _firstNameController.text.trim(),
        lastName: _lastNameController.text.trim(),
        password: _passwordController.text,
        confirmPassword: _confirmPasswordController.text,
      );

      if (mounted) {
        // Show success message
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Registration successful! Please login.'),
            backgroundColor: Colors.green,
          ),
        );

        // Navigate to login
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
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Registration failed: ${e.toString()}'),
            backgroundColor: Colors.red,
          ),
        );
      }
    } finally {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scrollbar(
      thumbVisibility: true,
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(12.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _emailController,
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
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your email';
                  }
                  if (!value.contains('@')) {
                    return 'Please enter a valid email';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 5),
              TextFormField(
                controller: _usernameController,
                textInputAction: TextInputAction.next,
                cursorColor: Colors.blue,
                decoration: const InputDecoration(
                  hintText: "Username",
                  prefixIcon: Padding(
                    padding: EdgeInsets.all(10.0),
                    child: Icon(Icons.person),
                  ),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a username';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 5),
              TextFormField(
                controller: _firstNameController,
                textInputAction: TextInputAction.next,
                cursorColor: Colors.blue,
                decoration: const InputDecoration(
                  hintText: "First name",
                  prefixIcon: Padding(
                    padding: EdgeInsets.all(10.0),
                    child: Icon(Icons.person_outline),
                  ),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your first name';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 5),
              TextFormField(
                controller: _lastNameController,
                textInputAction: TextInputAction.next,
                cursorColor: Colors.blue,
                decoration: const InputDecoration(
                  hintText: "Last name",
                  prefixIcon: Padding(
                    padding: EdgeInsets.all(10.0),
                    child: Icon(Icons.person_outline),
                  ),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your last name';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 5),
              TextFormField(
                controller: _passwordController,
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
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a password';
                  }
                  if (value.length < 6) {
                    return 'Password must be at least 6 characters';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 5),
              TextFormField(
                controller: _confirmPasswordController,
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
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please confirm your password';
                  }
                  if (value != _passwordController.text) {
                    return 'Passwords do not match';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 5),
              ElevatedButton(
                onPressed: _isLoading ? null : _handleSignUp,
                child:
                    _isLoading
                        ? const SizedBox(
                          height: 20,
                          width: 20,
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                            valueColor: AlwaysStoppedAnimation<Color>(
                              Colors.white,
                            ),
                          ),
                        )
                        : const Text("SIGN UP"),
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
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
