import 'package:SC3040_App/models/CollectionOfShows.dart';
import 'package:SC3040_App/models/User.dart';
import 'package:SC3040_App/global.dart';
import 'package:SC3040_App/services/DatabaseService.dart';
import 'package:SC3040_App/services/DatabaseServiceResult.dart';
import 'package:flutter/material.dart';
import 'package:openapi/api.dart';

class AuthViewModel extends ChangeNotifier {
  // Properties for authentication state management
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  User? _user;
  int? _statusCode;
  String? _accessToken;
  String? _refreshToken;

  String? _successMessage;
  String? _errorMessage;
  bool _isLoading = false;
  bool _isLoggedIn = false; // Tracks the overall login status

  // Getters
  User? get user => _user;
  //int? get statusCode => _statusCode;
  String? get accessToken => _accessToken;
  String? get refreshToken => _refreshToken;

  String? get successMessage => _successMessage;
  String? get errorMessage => _errorMessage;
  bool get isLoading => _isLoading;
  bool get isLoggedIn => _isLoggedIn;

  //setters
  void setUser(User user) {
    _user = user;
  }

  // Methods for authentication management
  Future<bool> login() async {
    String username = usernameController.text;
    String password = passwordController.text;

    // _isLoading = true;
    // notifyListeners();
    DatabaseServiceResult? data;
    try {
      // Call the DatabaseService to verify login
      data = await DatabaseService.verifyLogin(username, password);

      if (data.statusCode == 200) {
        // Successful login
        _user = data.user;
        _statusCode = data.statusCode;
        _accessToken = data.accessToken;
        _refreshToken = data.refreshToken;
        _successMessage = data.message;
        _isLoggedIn = true; // Set login status to true
      } else {
        // Unsuccessful login
        _errorMessage = data.message;
        _isLoggedIn = false;
      }
    } catch (e) {
      _errorMessage = "Login Failed: $e";
      _isLoggedIn = false;
    } finally {
      // _isLoading = false;
      // notifyListeners();
    }
    return data!.statusCode == 200;
  }

  // Log out the user and clear stored data
  void logout() {
    _user = null;
    _statusCode = null;
    _accessToken = null;
    _refreshToken = null;
    _successMessage = null;
    _errorMessage = null;
    _isLoggedIn = false;
    notifyListeners();
  }

  // checkLoginStatus() {
  //   // Check for access token or other persistent login data
  //   if (_accessToken != null) {
  //     _isLoggedIn = true;
  //   } else {
  //     _isLoggedIn = false;
  //   }
  //   notifyListeners();
  // }
}
