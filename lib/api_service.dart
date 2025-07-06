import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter/foundation.dart';

final storage = FlutterSecureStorage();
const String baseUrl = 'http://127.0.0.1:8000/user/';

// Function to fetch user registration data
Future<Map<String, dynamic>> registerUser({
  required String username,
  required String email,
  required String firstName,
  required String lastName,
  required String password,
  required String confirmPassword,
}) async {
  if (username.isEmpty ||
      email.isEmpty ||
      firstName.isEmpty ||
      lastName.isEmpty ||
      password.isEmpty ||
      confirmPassword.isEmpty) {
    throw Exception('All fields are required');
  }

  debugPrint('🚀 Attempting to register user: $username');
  debugPrint('📡 Sending request to: ${baseUrl}register/');

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

  debugPrint('📨 Response status: ${response.statusCode}');
  debugPrint('📨 Response body: ${response.body}');

  if (response.statusCode == 201 || response.statusCode == 200) {
    debugPrint('✅ Registration successful!');
    return json.decode(response.body);
  } else {
    debugPrint('❌ Registration failed: ${response.statusCode}');
    throw Exception(
      'Failed to register user: ${response.statusCode} - ${response.body}',
    );
  }
}

// Function to save token securely
Future<void> saveToken(String token) async {
  await storage.write(key: 'auth_token', value: token);
}

// Function to get saved token
Future<String?> getToken() async {
  return await storage.read(key: 'auth_token');
}

// Function to save user data
Future<void> saveUserData(Map<String, dynamic> userData) async {
  await storage.write(key: 'user_data', value: json.encode(userData));
}

// Function to get user data
Future<Map<String, dynamic>?> getUserData() async {
  final userDataString = await storage.read(key: 'user_data');
  if (userDataString != null) {
    return json.decode(userDataString);
  }
  return null;
}

// Function to check if user is logged in
Future<bool> isLoggedIn() async {
  final token = await getToken();
  return token != null && token.isNotEmpty;
}

// Function to logout user
Future<void> logout() async {
  await storage.delete(key: 'auth_token');
  await storage.delete(key: 'user_data');
  debugPrint('🚪 User logged out successfully');
}

// Function to verify token is still valid
Future<bool> verifyToken() async {
  final token = await getToken();
  if (token == null || token.isEmpty) {
    return false;
  }

  try {
    final response = await http.get(
      Uri.parse('${baseUrl}profile/'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode == 200) {
      debugPrint('✅ Token is valid');
      return true;
    } else {
      debugPrint('❌ Token is invalid or expired');
      await logout();
      return false;
    }
  } catch (e) {
    debugPrint('❌ Error verifying token: $e');
    return false;
  }
}

// Function to login user
Future<Map<String, dynamic>> loginUser({
  required String username,
  required String password,
}) async {
  debugPrint('🚀 Attempting to login user: $username');
  debugPrint('📡 Sending request to: ${baseUrl}login/');

  try {
    final response = await http.post(
      Uri.parse('${baseUrl}login/'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode({'username': username, 'password': password}),
    );

    debugPrint('📨 Response status: ${response.statusCode}');
    debugPrint('📨 Response body: ${response.body}');

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      if (data['token'] != null) {
        await saveToken(data['token']);
        await saveUserData(data);
        debugPrint('✅ Login successful!');
        return data;
      } else {
        throw Exception('Failed to login: No token received');
      }
    } else {
      debugPrint('❌ Login failed: ${response.statusCode}');
      String errorMessage = 'Failed to login: ${response.statusCode}';

      if (response.statusCode == 401) {
        errorMessage = 'Failed to login: 401 - Invalid credentials';
      } else if (response.statusCode == 404) {
        errorMessage = 'Failed to login: 404 - Service not found';
      } else if (response.statusCode == 500) {
        errorMessage = 'Failed to login: 500 - Server error';
      }

      throw Exception(errorMessage);
    }
  } catch (e) {
    debugPrint('❌ Login error: $e');
    rethrow;
  }
}