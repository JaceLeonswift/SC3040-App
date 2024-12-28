//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.18

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;

class VerticalImage {
  /// Returns a new [VerticalImage] instance.
  VerticalImage({
    required this.w240,
    required this.w360,
    required this.w480,
    required this.w600,
    required this.w720,
  });

  /// Link to the 240px wide version of the image.
  String w240;

  /// Link to the 360px wide version of the image.
  String w360;

  /// Link to the 480px wide version of the image.
  String w480;

  /// Link to the 600px wide version of the image.
  String w600;

  /// Link to the 720px wide version of the image.
  String w720;

  @override
  bool operator ==(Object other) => identical(this, other) || other is VerticalImage &&
    other.w240 == w240 &&
    other.w360 == w360 &&
    other.w480 == w480 &&
    other.w600 == w600 &&
    other.w720 == w720;

  @override
  int get hashCode =>
    // ignore: unnecessary_parenthesis
    (w240.hashCode) +
    (w360.hashCode) +
    (w480.hashCode) +
    (w600.hashCode) +
    (w720.hashCode);

  @override
  String toString() => 'VerticalImage[w240=$w240, w360=$w360, w480=$w480, w600=$w600, w720=$w720]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
      json[r'w240'] = this.w240;
      json[r'w360'] = this.w360;
      json[r'w480'] = this.w480;
      json[r'w600'] = this.w600;
      json[r'w720'] = this.w720;
    return json;
  }

  /// Returns a new [VerticalImage] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static VerticalImage? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        requiredKeys.forEach((key) {
          assert(json.containsKey(key), 'Required key "VerticalImage[$key]" is missing from JSON.');
          assert(json[key] != null, 'Required key "VerticalImage[$key]" has a null value in JSON.');
        });
        return true;
      }());

      return VerticalImage(
        w240: mapValueOfType<String>(json, r'w240')!,
        w360: mapValueOfType<String>(json, r'w360')!,
        w480: mapValueOfType<String>(json, r'w480')!,
        w600: mapValueOfType<String>(json, r'w600')!,
        w720: mapValueOfType<String>(json, r'w720')!,
      );
    }
    return null;
  }

  static List<VerticalImage> listFromJson(dynamic json, {bool growable = false,}) {
    final result = <VerticalImage>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = VerticalImage.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, VerticalImage> mapFromJson(dynamic json) {
    final map = <String, VerticalImage>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = VerticalImage.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of VerticalImage-objects as value to a dart map
  static Map<String, List<VerticalImage>> mapListFromJson(dynamic json, {bool growable = false,}) {
    final map = <String, List<VerticalImage>>{};
    if (json is Map && json.isNotEmpty) {
      // ignore: parameter_assignments
      json = json.cast<String, dynamic>();
      for (final entry in json.entries) {
        map[entry.key] = VerticalImage.listFromJson(entry.value, growable: growable,);
      }
    }
    return map;
  }

  /// The list of required keys that must be present in a JSON.
  static const requiredKeys = <String>{
    'w240',
    'w360',
    'w480',
    'w600',
    'w720',
  };
}

