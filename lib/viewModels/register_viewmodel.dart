import 'package:SC3040_App/viewModels/auth_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../services/DatabaseService.dart';
import '../models/User.dart';
import '../services/DatabaseServiceResult.dart';

class RegisterViewModel extends ChangeNotifier {
  //data needed for this controller, username and passwords
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();
  final TextEditingController oldPasswordController = TextEditingController();

  // private properties to hold the result
  User? _user;
  String? _successMessage;
  String? _errorMessage;

  // String? _errorMessage;
  bool _isLoading = false;

  // Getters
  User? get user => _user;
  String? get successMessage => _successMessage;
  String? get errorMessage => _errorMessage;

  bool get isLoading => _isLoading;

  Future<bool> register() async {
    final String username = usernameController.text.trim();
    final String password = passwordController.text.trim();

    // Validate input
    if (username.isEmpty || password.isEmpty) {
      _errorMessage = 'Please enter a valid username and password';
      notifyListeners(); // Notify listeners to update UI
      return false;
    }

    //await database to register and log in user, put in try catch
    // _isLoading = true;
    // notifyListeners();
    DatabaseServiceResult? data;
    try {
      data = await DatabaseService.createAccount(username, password);

      if (data.statusCode == 201) {
        _successMessage = data.message;
      } else {
        _errorMessage = data.message;
      }
    } catch (e) {
      _errorMessage = "$e";
    } finally {
      // _isLoading = false;
      // notifyListeners();
    }
    return data!.statusCode == 201;
  }

  Future<bool> updatePassword(BuildContext context) async {
    final authViewModel = Provider.of<AuthViewModel>(context, listen: false);
    String? username = authViewModel.user?.username;
    final String oldPassword = oldPasswordController.text.trim();
    final String newPassword = passwordController.text.trim();
    final String newPasswordConfirm = confirmPasswordController.text.trim();
    String? accessToken = authViewModel.accessToken;

    if (newPasswordConfirm != newPassword) {
      _errorMessage = 'Password does not match';
      notifyListeners();
      return false;
    }

    // _isLoading = true;
    // notifyListeners();
    DatabaseServiceResult? data;
    try {
      data = await DatabaseService.updatePassword(
          username, oldPassword, newPassword, accessToken);
      if (data.statusCode == 200) {
        _successMessage = data.message;
      } else {
        _errorMessage = data.message;
      }
    } catch (e) {
      _errorMessage = "Unable to connect to database";
    } finally {
      // _isLoading = true;
      // notifyListeners();
    }
    return data!.statusCode == 200;
  }
}
