import 'package:SC3040_App/models/CollectionOfShows.dart';
import 'package:SC3040_App/models/Review.dart';
import 'package:openapi/api.dart';

class User 
{
  String username;
  String password;
  List<CollectionOfShows> shows_collections_list = [];
  List<Review> reviews_list = [];
  List<ModelShow> favourite_shows = []; 
  List<List<double>> data_matrix = [];
  List<ModelShow> recommended_shows = [];   

  User
  ({
    required this.username,
    required this.password,
    List<CollectionOfShows>? shows_collections_list,
    List<Review>? reviews_list,
    List<ModelShow>? favourite_shows,
    List<List<double>>? data_matrix,
    List<ModelShow>? recommended_shows,
  }) : 
  shows_collections_list = shows_collections_list ?? [],
  reviews_list = reviews_list ?? [],
  favourite_shows = favourite_shows ?? [],
  recommended_shows = recommended_shows ?? [],   
  data_matrix = data_matrix ?? [];          

  static const requiredKeys = <String>
  {
    'username',
    'password',
  };

  @override
  String toString() 
  {
    return 'User[username=$username, password=$password, shows_collections_list=$shows_collections_list, reviews_list=$reviews_list, favourite_shows=$favourite_shows, data_matrix=$data_matrix, recommended_shows=$recommended_shows]';
  }

  Map<String, dynamic> toJson() 
  {
    final json = <String, dynamic>{};
    json['username'] = this.username;
    json['password'] = this.password;
    json['shows_collections_list'] = this.shows_collections_list.map((collection) => collection.toJson()).toList();
    json['reviews_list'] = this.reviews_list.map((review) => review.toJson()).toList();
    json['favourite_shows'] = this.favourite_shows.map((show) => show.toJson()).toList();
    json['data_matrix'] = this.data_matrix;
    json['recommended_shows'] = this.recommended_shows.map((show) => show.toJson()).toList();
    return json;
  }

  static User? fromJson(dynamic value) 
  {
    if (value is Map) 
    {
      final json = value.cast<String, dynamic>();

      assert(() 
      {
        requiredKeys.forEach((key) 
        {
          assert(json.containsKey(key), 'Required key "User[$key]" is missing from JSON.');
          assert(json[key] != null, 'Required key "User[$key]" has a null value in JSON.');
        });
        return true;
      }());

      return User
      (
        username: mapValueOfType<String>(json, 'username')!,
        password: mapValueOfType<String>(json, 'password')!,
        shows_collections_list: CollectionOfShows.listFromJson(json['shows_collections_list']),
        reviews_list: Review.listFromJson(json['reviews_list']),
        favourite_shows: ModelShow.listFromJson(json['favourite_shows']), 
        data_matrix: (json['data_matrix'] as List?)?.map((e) => List<double>.from(e)).toList() ?? [],
        recommended_shows: ModelShow.listFromJson(json['recommended_shows']), 
      );
    }
    return null;
  }

  static List<User> listFromJson(dynamic json, {bool growable = true}) 
  {
    final result = <User>[];
    if (json is List && json.isNotEmpty) 
    {
      for (final row in json) 
      {
        final value = User.fromJson(row);
        if (value != null) 
        {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }
}