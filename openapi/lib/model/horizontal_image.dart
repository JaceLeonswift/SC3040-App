//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.18

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;

class HorizontalImage {
  /// Returns a new [HorizontalImage] instance.
  HorizontalImage({
    required this.w360,
    required this.w480,
    required this.w720,
    required this.w1080,
    required this.w1440,
  });

  /// Link to the 360px wide version of the image.
  String w360;

  /// Link to the 480px wide version of the image.
  String w480;

  /// Link to the 720px wide version of the image.
  String w720;

  /// Link to the 1080px wide version of the image.
  String w1080;

  /// Link to the 1440px wide version of the image.
  String w1440;

  @override
  bool operator ==(Object other) => identical(this, other) || other is HorizontalImage &&
    other.w360 == w360 &&
    other.w480 == w480 &&
    other.w720 == w720 &&
    other.w1080 == w1080 &&
    other.w1440 == w1440;

  @override
  int get hashCode =>
    // ignore: unnecessary_parenthesis
    (w360.hashCode) +
    (w480.hashCode) +
    (w720.hashCode) +
    (w1080.hashCode) +
    (w1440.hashCode);

  @override
  String toString() => 'HorizontalImage[w360=$w360, w480=$w480, w720=$w720, w1080=$w1080, w1440=$w1440]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
      json[r'w360'] = this.w360;
      json[r'w480'] = this.w480;
      json[r'w720'] = this.w720;
      json[r'w1080'] = this.w1080;
      json[r'w1440'] = this.w1440;
    return json;
  }

  /// Returns a new [HorizontalImage] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static HorizontalImage? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        requiredKeys.forEach((key) {
          assert(json.containsKey(key), 'Required key "HorizontalImage[$key]" is missing from JSON.');
          assert(json[key] != null, 'Required key "HorizontalImage[$key]" has a null value in JSON.');
        });
        return true;
      }());

      return HorizontalImage(
        w360: mapValueOfType<String>(json, r'w360')!,
        w480: mapValueOfType<String>(json, r'w480')!,
        w720: mapValueOfType<String>(json, r'w720')!,
        w1080: mapValueOfType<String>(json, r'w1080')!,
        w1440: mapValueOfType<String>(json, r'w1440')!,
      );
    }
    return null;
  }

  static List<HorizontalImage> listFromJson(dynamic json, {bool growable = false,}) {
    final result = <HorizontalImage>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = HorizontalImage.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, HorizontalImage> mapFromJson(dynamic json) {
    final map = <String, HorizontalImage>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = HorizontalImage.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of HorizontalImage-objects as value to a dart map
  static Map<String, List<HorizontalImage>> mapListFromJson(dynamic json, {bool growable = false,}) {
    final map = <String, List<HorizontalImage>>{};
    if (json is Map && json.isNotEmpty) {
      // ignore: parameter_assignments
      json = json.cast<String, dynamic>();
      for (final entry in json.entries) {
        map[entry.key] = HorizontalImage.listFromJson(entry.value, growable: growable,);
      }
    }
    return map;
  }

  /// The list of required keys that must be present in a JSON.
  static const requiredKeys = <String>{
    'w360',
    'w480',
    'w720',
    'w1080',
    'w1440',
  };
}

