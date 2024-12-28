import 'package:SC3040_App/models/User.dart';
import 'package:SC3040_App/services/DatabaseService.dart';
import 'package:SC3040_App/services/DatabaseServiceResult.dart';
import 'package:SC3040_App/viewModels/auth_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:openapi/api.dart';
import 'package:provider/provider.dart';

class RecommendationViewmodel extends ChangeNotifier {
  String? _successMessage;
  String? _errorMessage;
  bool _isLoading = false;
  List<ModelShow>? _recommendedShows;

  String? get successMessage => _successMessage;
  String? get errorMessage => _errorMessage;
  bool get isLoading => _isLoading;
  List<ModelShow>? get recommendedShows => _recommendedShows;

  Future<bool> getRecommendedShows(BuildContext context) async {
    final authViewModel = Provider.of<AuthViewModel>(context, listen: false);
    if (authViewModel.user == null) {
      _errorMessage = "Please log in to access this feature";
      return false;
    }
    String country = "sg";
    DatabaseServiceResult? data;

    try {
      data = await DatabaseService.getRecommendedShows(
          authViewModel.user, authViewModel.accessToken, country);
      print("called getRecommendedShows");
      if (data.statusCode == 200) {
        _successMessage = data.message;
        authViewModel.setUser(data.user!);
        _recommendedShows = data.user!.recommended_shows;
      } else {
        _errorMessage = data.message;
      }
    } catch (e) {
      _errorMessage = "Unable to access database";
    } finally {}
    return data!.statusCode == 200;
  }
}
