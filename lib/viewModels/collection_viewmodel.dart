import 'package:SC3040_App/models/CollectionOfShows.dart';
import 'package:SC3040_App/models/Review.dart';
import 'package:SC3040_App/models/Show.dart';
import 'package:SC3040_App/models/User.dart';
import 'package:SC3040_App/services/DatabaseService.dart';
import 'package:SC3040_App/services/DatabaseServiceResult.dart';
import 'package:flutter/material.dart';
import 'package:openapi/api.dart';
import 'package:provider/provider.dart';
import './auth_viewmodel.dart';

class CollectionsViewmodel extends ChangeNotifier {
  final TextEditingController collectionNameController =
      TextEditingController();

  //properties
  CollectionOfShows? _collection;
  Show? _show;
  Review? _review;

  //database result values
  User? _user;
  String? _successMessage;
  String? _errorMessage;
  int? _statusCode;
  String? _accessToken;
  String? _refreshToken;

  bool _isLoading = false;

  //getters
  // CollectionOfShows? get collection => _collection;
  // Show? get show => _show;
  // Review? get review => _review;

  User? get user => _user;
  String? get successMessage => _successMessage;
  String? get errorMessage => _errorMessage;
  // int? get statusCode => _statusCode;
  // String? get accessToken => _accessToken;
  // String? get refreshToken => _refreshToken;

  bool get isLoading => _isLoading;

  void getUser(BuildContext context) async {
    final authViewModel = Provider.of<AuthViewModel>(context, listen: false);

    _user = authViewModel.user;
  }

  void createCollection(BuildContext context) async {
    final authViewModel = Provider.of<AuthViewModel>(context, listen: false);

    //get collectionName, username and accessToken
    String? collectionName = collectionNameController.text;
    String? username = authViewModel.user?.username;
    String? accessToken = authViewModel.accessToken;

    //validation before accessing database
    if ((username == '') ||
        (username == null) ||
        (collectionName == '') ||
        (accessToken == '') ||
        (accessToken == null)) {
      _errorMessage = 'Fields cannot be blank';
      notifyListeners();
      return;
    }

    _isLoading = true;
    notifyListeners();

    try {
      DatabaseServiceResult data =
          await DatabaseService.createCollectionOfShows(
              username, collectionName, accessToken);
      if (data.statusCode == 201) {
        _successMessage = data.message;
        authViewModel.setUser(data.user!);
      } else {
        _errorMessage = data.message;
      }
      collectionNameController.clear();
    } catch (e) {
      _errorMessage = "Creation failed, unable to access database";
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  void renameCollection(BuildContext context, int index) async {
    final authViewModel = Provider.of<AuthViewModel>(context, listen: false);

    String? newCollectionName = collectionNameController.text.trim();
    //get old collection name
    String? oldCollectionName =
        authViewModel.user?.shows_collections_list[index].name;
    String? username = authViewModel.user?.username;
    String? accessToken = authViewModel.accessToken;

    _isLoading = true;
    notifyListeners();
    try {
      DatabaseServiceResult data =
          await DatabaseService.renameCollectionOfShows(
              username, oldCollectionName, newCollectionName, accessToken);
      print(data.message);
      print(data.statusCode);
      if (data.statusCode == 200) {
        _successMessage = data.message;
        authViewModel.setUser(data.user!);
      } else {
        _errorMessage = data.message;
      }
    } catch (e) {
      _errorMessage = 'Failed to rename, unable to access database';
    } finally {
      // update the collection name in the user object
      _isLoading = false;
      notifyListeners();
    }
    print('Collection renamed');
  }

  void deleteCollection(BuildContext context, int index) async {
    final authViewModel = Provider.of<AuthViewModel>(context, listen: false);

    String? username = authViewModel.user?.username;
    String? accessToken = authViewModel.accessToken;

    List<String>? listOfCollectionNamesToDelete = [
      if (authViewModel.user?.shows_collections_list[index].name != null)
        authViewModel.user!.shows_collections_list[index].name
    ]; //how?

    _isLoading = true;
    notifyListeners();

    try {
      DatabaseServiceResult data = await DatabaseService.deleteCollections(
          username, listOfCollectionNamesToDelete, accessToken);
      if (data.statusCode == 200) {
        _successMessage = data.message;
        authViewModel.setUser(data.user!);
      } else {
        _errorMessage = data.message;
      }
    } catch (e) {
      _errorMessage = "Failed to delete collection, unable to access database";
    } finally {
      _isLoading = true;
      notifyListeners();
    }
  }

  Future<bool> deleteShowsFromCollection(
    BuildContext context,
    int collectionIndex,
    String showId,
  ) async {
    final authViewModel = Provider.of<AuthViewModel>(context, listen: false);

    String? username = authViewModel.user?.username;
    String? accessToken = authViewModel.accessToken;
    List<String>? listOfShowIDsToDelete = [showId];
    String? collectionName =
        authViewModel.user?.shows_collections_list[collectionIndex].name;

    // _isLoading = true;
    // notifyListeners();
    DatabaseServiceResult? data;
    print("Deleting show from collection");
    try {
      data = await DatabaseService.deleteShowsFromCollection(
          username, listOfShowIDsToDelete, collectionName, accessToken);
      if (data.statusCode == 200) {
        _successMessage = data.message;
        authViewModel.setUser(data.user!);
      } else {
        _errorMessage = data.message;
      }
    } catch (e) {
      _errorMessage = "Failed to delete shows, unable to access database";
    } finally {
      _isLoading = false;
      notifyListeners();
    }
    return data!.statusCode == 200;
  }

  void addShowToCollection(
      BuildContext context, ModelShow show, int collectionIndex) async {
    final authViewModel = Provider.of<AuthViewModel>(context, listen: false);

    String? username = authViewModel.user?.username;
    String? accessToken = authViewModel.accessToken;
    String? collectionName =
        authViewModel.user?.shows_collections_list[collectionIndex].name;

    _isLoading = true;
    notifyListeners();
    try {
      DatabaseServiceResult data = await DatabaseService.saveShowToCollection(
          username, show, collectionName, accessToken);
      if (data.statusCode == 200) {
        _successMessage = data.message;
        authViewModel.setUser(data.user!);
      } else {
        _errorMessage = data.message;
      }
    } catch (e) {
      _errorMessage = "Failed to add show, unable to access database";
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
