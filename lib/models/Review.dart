import 'package:openapi/api.dart';

class Review {
  ModelShow show;
  String username;
  double rating; // must check before construction that it is between 0 and 100
  String? comment;
  DateTime timestamp; // New timestamp attribute
  static const requiredKeys = <String>{
    'show',
    'username',
    'rating',
    'timestamp', // Include timestamp as a required key
  };

  Review({
    required this.show,
    required this.username,
    required this.rating,
    this.comment,
    required this.timestamp, // Timestamp must be provided on construction
  });

  @override
  String toString() {
    return 'Review[show=$show, username=$username, rating=$rating, comment=$comment, timestamp=$timestamp]';
  }

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
    json['show'] = this.show.toJson();
    json['username'] = this.username;
    json['rating'] = this.rating;
    json['timestamp'] =
        this.timestamp.toIso8601String(); // Convert DateTime to ISO string
    json['comment'] = this.comment;
    return json;
  }

  /// Returns a new [Review] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  static Review? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      assert(() {
        requiredKeys.forEach((key) {
          assert(json.containsKey(key),
              'Required key "Review[$key]" is missing from JSON.');
          assert(json[key] != null,
              'Required key "Review[$key]" has a null value in JSON.');
        });
        return true;
      }());

      return Review(
        show: ModelShow.fromJson(json['show'])!,
        username: mapValueOfType<String>(json, 'username')!,
        rating: mapValueOfType<double>(json, 'rating')!,
        comment: mapValueOfType<String>(json, 'comment'),
        timestamp:
            DateTime.parse(json['timestamp']), // Parse ISO string to DateTime
      );
    }
    return null;
  }

  static List<Review> listFromJson(dynamic json, {bool growable = true}) {
    final result = <Review>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = Review.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }
}
