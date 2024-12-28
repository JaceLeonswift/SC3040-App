import 'package:SC3040_App/models/Review.dart';
import 'package:SC3040_App/models/User.dart';
import 'package:SC3040_App/services/DatabaseService.dart';
import 'package:SC3040_App/services/DatabaseServiceResult.dart';
import 'package:SC3040_App/viewModels/auth_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:openapi/api.dart';
import 'package:provider/provider.dart';

class ReviewViewmodel extends ChangeNotifier {
  final TextEditingController ratingController = TextEditingController();
  final TextEditingController commentController = TextEditingController();

  //database result values
  User? _user;
  String? _successMessage;
  String? _errorMessage;
  int? _statusCode;
  String? _accessToken;
  String? _refreshToken;
  List<Review>? _showReviews;

  bool _isLoading = false;

  User? get user => _user;
  String? get successMessage => _successMessage;
  String? get errorMessage => _errorMessage;
  int? get statusCode => _statusCode;
  String? get accessToken => _accessToken;
  String? get refreshToken => _refreshToken;
  List<Review>? get showReviews => _showReviews;

  bool get isLoading => _isLoading;

  double get rating {
    return double.tryParse(ratingController.text) ?? 0.0;
  }

  Future<bool> createReview(BuildContext context, ModelShow show) async {
    _isLoading = true;
    notifyListeners();

    final authViewModel = Provider.of<AuthViewModel>(context, listen: false);
    _user = authViewModel.user;
    String? username = _user?.username;
    double rating = double.parse(ratingController.text);
    String comment = commentController.text;
    _accessToken = authViewModel.accessToken;
    DateTime timestamp = DateTime.now();
    DatabaseServiceResult? data;

    Review review = Review(
      show: show,
      username: username!,
      rating: rating,
      timestamp: timestamp,
      comment: comment,
    );

    try {
      data = await DatabaseService.postReview(username, review, accessToken);
      if (data.statusCode == 200) {
        _successMessage = data.message;
        authViewModel.setUser(data.user!);
        await showReviewsList(show.id.toString());
      } else {
        _errorMessage = data.message;
      }
    } catch (e) {
      _errorMessage = "Failed to post review: $e";
    } finally {
      // _isLoading = false;
      notifyListeners();
    }
    return data?.statusCode == 200;
  }

  Future<bool> deleteReview(BuildContext context, int index) async {
    _isLoading = true;
    notifyListeners();

    final authViewModel = Provider.of<AuthViewModel>(context, listen: false);

    //username, review, access token
    //for now only have text review, not sure how is rating supposed to be integrated
    _user = authViewModel.user;
    String? username = _user?.username;
    _accessToken = authViewModel.accessToken;
    Review? review = _user?.reviews_list[index];
    List<DateTime>? timestamps = review != null ? [review.timestamp] : null;
    DatabaseServiceResult? data;
    try {
      data = await DatabaseService.deleteReviews(
          username, timestamps, accessToken);

      if (data.statusCode == 200) {
        _successMessage = data.message;
        authViewModel.setUser(data.user!);
      } else {
        _errorMessage = data.message;
      }
    } catch (e) {
      _errorMessage = "Failed to delete review";
    } finally {
      _isLoading = false;
      notifyListeners();
    }
    return data!.statusCode == 200;
  }

  Future<bool> showReviewsList(String showID) async {
    _isLoading = true;
    try {
      DatabaseServiceResult data =
          await DatabaseService.getReviewsForShow(showID);
      _showReviews = data.showReviews;
      if (data.statusCode == 200) {
        _successMessage = data.message;
      } else {
        _errorMessage = data.message;
      }
    } catch (e) {
      _errorMessage = "Error accessing database";
    } finally {
      _isLoading = false;
      notifyListeners();
    }

    return _showReviews != null;
  }

  Future<bool> editReview(BuildContext context, int index) async {
    final authViewModel = Provider.of<AuthViewModel>(context, listen: false);
    String? username = authViewModel.user?.username;
    DateTime timestamp = DateTime.now();
    double updatedRating = double.parse(ratingController.text);
    String updatedComment = commentController.text;
    Review review = authViewModel.user!.reviews_list[index];
    ModelShow show = review.show;
    _accessToken = authViewModel.accessToken;
    DatabaseServiceResult data = DatabaseServiceResult();

    Review newReview = Review(
      show: show,
      username: username!,
      rating: updatedRating,
      comment: updatedComment,
      timestamp: timestamp,
    );

    _isLoading = true;
    notifyListeners();
    try {
      data = await DatabaseService.editReview(
        username,
        review.timestamp,
        newReview,
        _accessToken,
      );
      if (data.statusCode == 200) {
        _successMessage = data.message;
        authViewModel.setUser(data.user!);
      } else {
        _errorMessage = data.message;
      }
    } catch (e) {
      _errorMessage = "Unable to access database: $e";
    } finally {
      _isLoading = false;
      notifyListeners();
    }

    return data.statusCode == 200;
  }
}
