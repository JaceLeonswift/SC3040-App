import 'package:SC3040_App/models/Review.dart';
import 'package:SC3040_App/models/User.dart';

class DatabaseServiceResult 
{
  User? user;
  String? message;
  int? statusCode;
  String? entireMessage;
  String? accessToken;
  String? refreshToken;
  List<Review>? showReviews;

  DatabaseServiceResult({this.statusCode, this.user, this.message, this.entireMessage, this.accessToken, this.refreshToken, this.showReviews});

  @override
  String toString() 
  {
    return 'DatabaseServiceResult[user=$user message=$message, statusCode=$statusCode, entireMessage=$entireMessage, accessToken=$accessToken, refreshToken=$refreshToken, showReviews=$showReviews]';
  }
}
