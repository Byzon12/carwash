import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

final storage = FlutterSecureStorage();
const String baseUrl = 'http://127.0.0.1:8000/user/';

//Function to fetch user registration data
Future<Map<String, dynamic>> registerUser({
  required String username,
  required String email,
  required String firstName,
  required String lastName,
  required String password,
  required String confirmPassword,
}) async {
  // Add this to your form.dart file temporarily
  if (username.isEmpty ||
      email.isEmpty ||
      firstName.isEmpty ||
      lastName.isEmpty ||
      password.isEmpty ||
      confirmPassword.isEmpty) {
    throw Exception('All fields are required');
  }
  print('🚀 Attempting to register user: $username');
  print('📡 Sending request to: ${baseUrl}register/');

  final response = await http.post(
    Uri.parse('${baseUrl}register/'),
    headers: {'Content-Type': 'application/json'},
    body: json.encode({
      'username': username,
      'email': email,
      'first_name': firstName,
      'last_name': lastName,
      'password': password,
      'confirm_password': confirmPassword,
    }),
  );

  print('📨 Response status: ${response.statusCode}');
  print('📨 Response body: ${response.body}');

  if (response.statusCode == 201 || response.statusCode == 200) {
    print('✅ Registration successful!');
    return json.decode(response.body);
  } else {
    print('❌ Registration failed: ${response.statusCode}');
    throw Exception(
      'Failed to register user: ${response.statusCode} - ${response.body}',
    );
  }
}

// Function to save token securely
Future<void> saveToken(String token) async {
  await storage.write(key: 'auth_token', value: token);
}

// function to login user
Future<Map<String, dynamic>> loginUser({
  required String username,
  required String password,
}) async {
  final response = await http.post(
    Uri.parse('${baseUrl}login/'),
    headers: {'Content-Type': 'application/json'},
    body: json.encode({'username': username, 'password': password}),
  );

  if (response.statusCode == 200) {
    final data = json.decode(response.body);
    await saveToken(data['token']);
    return data;
  } else {
    throw Exception('Failed to login: ${response.statusCode}');
  }
}
