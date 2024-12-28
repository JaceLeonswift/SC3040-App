import 'package:SC3040_App/models/Review.dart';
import 'package:SC3040_App/models/User.dart';
import 'package:SC3040_App/services/DatabaseServiceResult.dart';
import 'package:SC3040_App/services/ShowSearchParams.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:openapi/api.dart';

//refer to views.py in SC3040_database for full list of possible return status codes and messages from database
//success status codes: 200 or 201
//expired tokens status code: 401
//if refreshtoken returns status code 401 then must ask user to login again
class DatabaseService {
  static final String baseUrl = 'http://127.0.0.1:8000/api/';

  static Future<DatabaseServiceResult> verifyLogin(
      String? username, String? password) async {
    if ((username == '') ||
        (username == null) ||
        (password == '') ||
        (password == null)) {
      return DatabaseServiceResult(
          message: 'Username and password cannot be blank');
    }

    final apiUrl = '${baseUrl}verify_login/';
    try {
      // Create the request body
      final Map<String, String> queryParameters = {
        'username': username,
        'password': password,
      };

      // Make the GET request
      final response = await http
          .get(Uri.parse(apiUrl).replace(queryParameters: queryParameters));
      final responseData = json.decode(response.body);
      User? user = User.fromJson(responseData['user']);
      return DatabaseServiceResult(
          statusCode: response.statusCode,
          user: user,
          message: responseData['message'],
          entireMessage: response.body,
          accessToken: responseData['tokens']?['access'],
          refreshToken: responseData['tokens']?['refresh']);
    } catch (e) {
      // check if error is due to xmlhttprequest error
      if (e.toString().contains('XMLHttpRequest')) {
        return DatabaseServiceResult(
            message:
                'Error in verifying login: Are you connected to the internet?');
      } else {}
      return DatabaseServiceResult(message: 'Error in verifying login: $e');
    }
  }

  static Future<DatabaseServiceResult> refreshtoken(
      String? refreshToken) async {
    if (refreshToken == null || refreshToken == '') {
      return DatabaseServiceResult(message: 'Refresh token cannot be blank');
    }

    final apiUrl = '${baseUrl}token/refresh/';
    try {
      final response = await http.post(
        Uri.parse(apiUrl),
        headers: {
          'Content-Type': 'application/json',
        },
        body: json.encode({
          'refresh': refreshToken,
        }),
      );

      final responseData = json.decode(response.body);
      return DatabaseServiceResult(
        statusCode: response.statusCode,
        message: responseData['detail'],
        entireMessage: response.body,
        accessToken: responseData['access'],
      );
    } catch (e) {
      if (e.toString().contains('XMLHttpRequest')) {
        return DatabaseServiceResult(
            message:
                'Error in refreshing token. Are you connected to the internet?');
      }

      return DatabaseServiceResult(message: 'Error refreshing token: $e');
    }
  }

  static Future<DatabaseServiceResult> createAccount(
      String? username, String? password) async {
    if ((username == '') ||
        (username == null) ||
        (password == '') ||
        (password == null)) {
      return DatabaseServiceResult(
          message: 'Username and password cannot be blank');
    }

    final apiUrl = '${baseUrl}create_account/';
    try {
      final response = await http.post(
        Uri.parse(apiUrl),
        headers: {'Content-Type': 'application/json'},
        body: json.encode({
          'username': username,
          'password': password,
        }),
      );
      final responseData = json.decode(response.body);

      return DatabaseServiceResult(
          statusCode: response.statusCode,
          message: responseData['message'],
          entireMessage: response.body);
    } catch (e) {
      if (e.toString().contains('XMLHttpRequest')) {
        return DatabaseServiceResult(
            message:
                'Error in creating account: Are you connected to the internet?');
      }
      return DatabaseServiceResult(message: 'Error in creating account: $e');
    }
  }

  static Future<DatabaseServiceResult> updatePassword(String? username,
      String? oldPassword, String? newPassword, String? accessToken) async {
    if ((username == '') ||
        (username == null) ||
        (oldPassword == '') ||
        (oldPassword == null) ||
        (newPassword == '') ||
        (newPassword == null) ||
        (accessToken == null) ||
        (accessToken == '')) {
      return DatabaseServiceResult(message: 'Fields cannot be blank');
    }

    final apiUrl = '${baseUrl}update_password/';
    try {
      final response = await http.post(
        Uri.parse(apiUrl),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $accessToken',
        },
        body: json.encode({
          'username': username,
          'old_password': oldPassword,
          'new_password': newPassword,
        }),
      );
      final responseData = json.decode(response.body);
      User? updateduser = User.fromJson(responseData['user']);

      return DatabaseServiceResult(
          statusCode: response.statusCode,
          message: responseData['message'],
          user: updateduser,
          entireMessage: response.body);
    } catch (e) {
      if (e.toString().contains('XMLHttpRequest')) {
        return DatabaseServiceResult(
            message:
                'Error in updating password: Are you connected to the internet?');
      }

      return DatabaseServiceResult(message: 'Error updating password: $e');
    }
  }

  static Future<DatabaseServiceResult> deleteAccount(
      String? username, String? password, String? accessToken) async {
    if ((username == '') ||
        (username == null) ||
        (password == '') ||
        (password == null) ||
        (accessToken == '') ||
        (accessToken == null)) {
      return DatabaseServiceResult(
          message: 'Username and password cannot be blank');
    }

    final apiUrl = '${baseUrl}delete_account/';
    try {
      final response = await http.post(
        Uri.parse(apiUrl),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $accessToken',
        },
        body: json.encode({'username': username, 'password': password}),
      );
      final responseData = json.decode(response.body);

      return DatabaseServiceResult(
          statusCode: response.statusCode,
          message: responseData['message'],
          entireMessage: response.body);
    } catch (e) {
      if (e.toString().contains('XMLHttpRequest')) {
        return DatabaseServiceResult(
            message:
                'Error in deleting account: Are you connected to the internet?');
      }
      return DatabaseServiceResult(message: 'Error deleting account: $e');
    }
  }

  static Future<DatabaseServiceResult> createCollectionOfShows(
      String? username, String? collectionName, String? accessToken) async {
    if ((username == '') ||
        (username == null) ||
        (collectionName == '') ||
        (collectionName == null) ||
        (accessToken == '') ||
        (accessToken == null)) {
      return DatabaseServiceResult(message: 'Fields cannot be blank');
    }

    final apiUrl = '${baseUrl}create_collection_of_shows/';
    try {
      final response = await http.post(
        Uri.parse(apiUrl),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $accessToken',
        },
        body: json.encode({
          'username': username,
          'collection_name': collectionName,
        }),
      );
      final responseData = json.decode(response.body);
      User? updateduser = User.fromJson(responseData['user']);

      return DatabaseServiceResult(
          statusCode: response.statusCode,
          message: responseData['message'],
          user: updateduser,
          entireMessage: response.body);
    } catch (e) {
      if (e.toString().contains('XMLHttpRequest')) {
        return DatabaseServiceResult(
            message:
                'Error in creating collection: Are you connected to the internet?');
      }
      return DatabaseServiceResult(message: 'Error in creating collection: $e');
    }
  }

  static Future<DatabaseServiceResult> renameCollectionOfShows(
      String? username,
      String? oldCollectionName,
      String? newCollectionName,
      String? accessToken) async {
    if ((username == '') ||
        (username == null) ||
        (oldCollectionName == '') ||
        (oldCollectionName == null) ||
        (newCollectionName == '') ||
        (newCollectionName == null) ||
        (accessToken == '') ||
        (accessToken == null)) {
      return DatabaseServiceResult(message: 'Fields cannot be blank');
    }

    final apiUrl = '${baseUrl}rename_collection_of_shows/';
    try {
      final response = await http.post(
        Uri.parse(apiUrl),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $accessToken',
        },
        body: json.encode({
          'username': username,
          'old_collection_name': oldCollectionName,
          'new_collection_name': newCollectionName,
        }),
      );
      final responseData = json.decode(response.body);
      User? updateduser = User.fromJson(responseData['user']);
      return DatabaseServiceResult(
          statusCode: response.statusCode,
          message: responseData['message'],
          user: updateduser,
          entireMessage: response.body);
    } catch (e) {
      return DatabaseServiceResult(message: 'Error renaming collection: $e');
    }
  }

  static Future<DatabaseServiceResult> saveShowToCollection(String? username,
      ModelShow? show, String? collectionName, String? accessToken) async {
    if ((username == '') ||
        (username == null) ||
        (collectionName == '') ||
        (collectionName == null) ||
        (show == null) ||
        (accessToken == '') ||
        (accessToken == null)) {
      return DatabaseServiceResult(message: 'Fields cannot be blank');
    }

    final apiUrl = '${baseUrl}save_show_to_collection/';
    try {
      final response = await http.post(
        Uri.parse(apiUrl),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $accessToken',
        },
        body: json.encode({
          'username': username,
          'collection_name': collectionName,
          'show': show.toJson(),
        }),
      );
      final responseData = json.decode(response.body);
      User? updateduser = User.fromJson(responseData['user']);
      return DatabaseServiceResult(
          statusCode: response.statusCode,
          message: responseData['message'],
          user: updateduser,
          entireMessage: response.body);
    } catch (e) {
      return DatabaseServiceResult(
          message: 'Error saving show to collection: $e');
    }
  }

  static Future<DatabaseServiceResult> deleteShowsFromCollection(
      String? username,
      List<String?>? listOfShowIDsToDelete,
      String? collectionName,
      String? accessToken) async {
    listOfShowIDsToDelete = listOfShowIDsToDelete?.whereType<String>().toList();
    if ((username == null) ||
        (username == '') ||
        (collectionName == null) ||
        (collectionName == '') ||
        (listOfShowIDsToDelete == null) ||
        listOfShowIDsToDelete.isEmpty ||
        (accessToken == null) ||
        (accessToken == '')) {
      return DatabaseServiceResult(message: 'Fields cannot be blank');
    }

    final apiUrl = '${baseUrl}delete_shows_from_collection/';
    try {
      final response = await http.post(
        Uri.parse(apiUrl),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $accessToken',
        },
        body: json.encode({
          'username': username,
          'collection_name': collectionName,
          'show_ids_to_delete':
              listOfShowIDsToDelete, // Send list of show IDs as JSON
        }),
      );
      final responseData = json.decode(response.body);
      User? updateduser = User.fromJson(responseData['user']);

      return DatabaseServiceResult(
          statusCode: response.statusCode,
          message: responseData['message'],
          user: updateduser,
          entireMessage: response.body);
    } catch (e) {
      if (e.toString().contains('XMLHttpRequest')) {
        return DatabaseServiceResult(
            message:
                'Error in deleting show from collection: Are you connected to the internet?');
      }
      return DatabaseServiceResult(
          message: 'Error deleting shows from collection: $e');
    }
  }

  static Future<DatabaseServiceResult> deleteCollections(String? username,
      List<String?>? listOfCollectionNamesToDelete, String? accessToken) async {
    listOfCollectionNamesToDelete =
        listOfCollectionNamesToDelete?.whereType<String>().toList();
    if ((username == null) ||
        (username == '') ||
        (listOfCollectionNamesToDelete == null) ||
        listOfCollectionNamesToDelete.isEmpty ||
        (accessToken == null) ||
        (accessToken == '')) {
      return DatabaseServiceResult(message: 'Fields cannot be blank');
    }

    final apiUrl = '${baseUrl}delete_collections/';
    try {
      final response = await http.post(
        Uri.parse(apiUrl),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $accessToken',
        },
        body: json.encode({
          'username': username,
          'collection_names_to_delete': listOfCollectionNamesToDelete,
        }),
      );
      final responseData = json.decode(response.body);
      User? updateduser = User.fromJson(responseData['user']);

      return DatabaseServiceResult(
          statusCode: response.statusCode,
          message: responseData['message'],
          user: updateduser,
          entireMessage: response.body);
    } catch (e) {
      if (e.toString().contains('XMLHttpRequest')) {
        return DatabaseServiceResult(
            message:
                'Error in deleting collection: Are you connected to the internet?');
      }
      return DatabaseServiceResult(message: 'Error deleting collections: $e');
    }
  }

  static Future<DatabaseServiceResult> postReview(
      String? username, Review? review, String? accessToken) async {
    if ((username == null) ||
        (username == '') ||
        (review == null) ||
        (accessToken == null) ||
        (accessToken == '')) {
      return DatabaseServiceResult(message: 'Fields cannot be blank');
    }

    final apiUrl = '${baseUrl}post_review/';
    try {
      final response = await http.post(
        Uri.parse(apiUrl),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $accessToken',
        },
        body: json.encode({
          'username': username,
          'review': review.toJson(), // Convert Review object to JSON
        }),
      );
      final responseData = json.decode(response.body);
      User? updateduser = User.fromJson(responseData['user']);
      return DatabaseServiceResult(
          statusCode: response.statusCode,
          message: responseData['message'],
          user: updateduser,
          entireMessage: response.body);
    } catch (e) {
      return DatabaseServiceResult(message: 'Error posting review: $e');
    }
  }

  static Future<DatabaseServiceResult> deleteReviews(
      String? username,
      List<DateTime?>? listOfReviewsTimestampsToDelete,
      String? accessToken) async {
    listOfReviewsTimestampsToDelete =
        listOfReviewsTimestampsToDelete?.whereType<DateTime>().toList();
    if ((username == null) ||
        (username == '') ||
        (listOfReviewsTimestampsToDelete == null) ||
        listOfReviewsTimestampsToDelete.isEmpty ||
        (accessToken == null) ||
        (accessToken == '')) {
      return DatabaseServiceResult(message: 'Fields cannot be blank');
    }

    final apiUrl = '${baseUrl}delete_reviews/';
    try {
      // Convert list of DateTime to a list of ISO 8601 strings
      final timestampsToDelete = listOfReviewsTimestampsToDelete
          .map((timestamp) => timestamp!.toIso8601String())
          .toList();

      final response = await http.post(
        Uri.parse(apiUrl),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $accessToken',
        },
        body: json.encode({
          'username': username,
          'timestamps_to_delete':
              timestampsToDelete, // Send timestamps in ISO 8601 format
        }),
      );
      final responseData = json.decode(response.body);
      User? updateduser = User.fromJson(responseData['user']);

      return DatabaseServiceResult(
          statusCode: response.statusCode,
          message: responseData['message'],
          user: updateduser,
          entireMessage: response.body);
    } catch (e) {
      if (e.toString().contains('XMLHttpRequest')) {
        return DatabaseServiceResult(
            message:
                'Error in deleting reviews: Are you connected to the internet?');
      }
      return DatabaseServiceResult(message: 'Error deleting reviews: $e');
    }
  }

  static Future<DatabaseServiceResult> editReview(
    String? username,
    DateTime? oldTimestamp,
    Review? newReview,
    String? accessToken,
  ) async {
    if ((username == '') ||
        (username == null) ||
        (accessToken == '') ||
        (accessToken == null) ||
        (oldTimestamp == null) ||
        (newReview == null)) {
      return DatabaseServiceResult(message: 'Fields cannot be blank');
    }

    final apiUrl = '${baseUrl}edit_review/';
    try {
      final response = await http.post(
        Uri.parse(apiUrl),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $accessToken',
        },
        body: json.encode({
          'username': username,
          'old_timestamp': oldTimestamp.toIso8601String(),
          'new_review': newReview.toJson(), // Convert new Review object to JSON
        }),
      );

      final responseData = json.decode(response.body);
      User? updatedUser = User.fromJson(responseData['user']);
      return DatabaseServiceResult(
        statusCode: response.statusCode,
        message: responseData['message'],
        user: updatedUser,
        entireMessage: response.body,
      );
    } catch (e) {
      return DatabaseServiceResult(message: 'Error editing review: $e');
    }
  }

  static Future<DatabaseServiceResult> getReviewsForShow(String? showID) async {
    if ((showID == '') || (showID == null)) {
      return DatabaseServiceResult(message: 'Show ID cannot be blank');
    }

    final apiUrl = '${baseUrl}get_reviews_for_show/';
    try {
      final response = await http
          .get(Uri.parse(apiUrl).replace(queryParameters: {'show_id': showID}));
      final responseData = json.decode(response.body);
      List<Review> showReviews = Review.listFromJson(responseData['reviews']);
      return DatabaseServiceResult(
        statusCode: response.statusCode,
        showReviews: showReviews,
        message: responseData['message'],
        entireMessage: response.body,
      );
    } catch (e) {
      return DatabaseServiceResult(
          message: 'Error fetching reviews for show: $e');
    }
  }

  static Future<DatabaseServiceResult> getRecommendedShows(
      User? user, String? accessToken, String country) async {
    if (user == null || accessToken == null || accessToken.isEmpty) {
      return DatabaseServiceResult(
          message: 'User and access token are required');
    }

    // Analyze user's favorite shows to extract recommendation parameters
    final List<ModelShow> favouriteShows = user.favourite_shows;
    ShowSearchParams showSearchParams =
        ShowSearchParams.fromFavouriteShows(favouriteShows);
    print(showSearchParams);

    int attemptCount = 1;
    List<ModelShow> searchResultShows =
        []; // Store all shows retrieved from each searchResult

    // Fetch shows based on user preferences
    SearchResult? searchResult = await ShowsApi().searchShowsByFilters(
      country,
      genres: showSearchParams.topGenres?.toList(),
      genresRelation: 'or',
      showType: showSearchParams.mostCommonShowType,
      yearMin: 2000,
      ratingMin: 60,
      orderBy: 'popularity_1week',
      orderDirection: OrderDirection.desc,
    );

    // Check if searchResult is null or empty, return error result if so
    if (searchResult == null || searchResult.shows.isEmpty) {
      return DatabaseServiceResult(
          message: 'No shows found based on current recommendations');
    }

    // Add searchResult shows to searchResultShows list
    searchResultShows.addAll(searchResult.shows);

    // Loop to fetch recommendations using search filters and cursor if available
    while ((searchResult?.hasMore ?? false) && attemptCount < 5) {
      attemptCount++;

      // Fetch shows based on user preferences
      searchResult = await ShowsApi().searchShowsByFilters(
        country,
        genres: showSearchParams.topGenres?.toList(),
        genresRelation: 'or',
        showType: showSearchParams.mostCommonShowType,
        yearMin: 2000,
        ratingMin: 60,
        cursor: searchResult!.nextCursor,
        orderBy: 'popularity_1week',
        orderDirection: OrderDirection.desc,
      );

      // Add searchResult shows to searchResultShows list
      searchResultShows.addAll(searchResult?.shows ?? []);
    }

    // Send obtained shows to server for clustering analysis
    final apiUrl = '${baseUrl}get_recommended_shows/';
    try {
      final response = await http.post(
        Uri.parse(apiUrl),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $accessToken',
        },
        body: json.encode(
            {'shows': searchResultShows.map((show) => show.toJson()).toList()}),
      );

      final responseData = json.decode(response.body);
      User? updatedUser = User.fromJson(responseData['user']);
      return DatabaseServiceResult(
        statusCode: response.statusCode,
        message: responseData['message'],
        user: updatedUser,
        entireMessage: response.body,
      );
    } catch (e) {
      return DatabaseServiceResult(
          message: 'Error fetching recommended shows: $e');
    }
  }

  static Future<DatabaseServiceResult> getTextVector(ModelShow show) async {
    final apiUrl = '${baseUrl}get_text_vector/';

    try {
      // Prepare the request body
      final response = await http.post(
        Uri.parse(apiUrl),
        headers: {'Content-Type': 'application/json'},
        body: json.encode({'show': show.toJson()}),
      );

      // Parse the response
      final responseData = json.decode(response.body);
      return DatabaseServiceResult(
        statusCode: response.statusCode,
        message: responseData['message'],
        entireMessage: response.body,
      );
    } catch (e) {
      return DatabaseServiceResult(message: 'Error caching text vector: $e');
    }
  }
}
