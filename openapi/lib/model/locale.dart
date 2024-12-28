//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.18

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;

class Locale {
  /// Returns a new [Locale] instance.
  Locale({
    required this.language,
    this.region,
  });

  /// [ISO 639-2](https://en.wikipedia.org/wiki/ISO_639-2) code of the associated language with the locale.
  String language;

  /// [ISO 3166-1 alpha-3](https://en.wikipedia.org/wiki/ISO_3166-1_alpha-3) code of the country, or [UN M49](https://en.wikipedia.org/wiki/UN_M49) code of the area associated with the locale. 
  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  String? region;

  @override
  bool operator ==(Object other) => identical(this, other) || other is Locale &&
    other.language == language &&
    other.region == region;

  @override
  int get hashCode =>
    // ignore: unnecessary_parenthesis
    (language.hashCode) +
    (region == null ? 0 : region!.hashCode);

  @override
  String toString() => 'Locale[language=$language, region=$region]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
      json[r'language'] = this.language;
    if (this.region != null) {
      json[r'region'] = this.region;
    } else {
      json[r'region'] = null;
    }
    return json;
  }

  /// Returns a new [Locale] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static Locale? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        requiredKeys.forEach((key) {
          assert(json.containsKey(key), 'Required key "Locale[$key]" is missing from JSON.');
          assert(json[key] != null, 'Required key "Locale[$key]" has a null value in JSON.');
        });
        return true;
      }());

      return Locale(
        language: mapValueOfType<String>(json, r'language')!,
        region: mapValueOfType<String>(json, r'region'),
      );
    }
    return null;
  }

  static List<Locale> listFromJson(dynamic json, {bool growable = false,}) {
    final result = <Locale>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = Locale.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, Locale> mapFromJson(dynamic json) {
    final map = <String, Locale>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = Locale.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of Locale-objects as value to a dart map
  static Map<String, List<Locale>> mapListFromJson(dynamic json, {bool growable = false,}) {
    final map = <String, List<Locale>>{};
    if (json is Map && json.isNotEmpty) {
      // ignore: parameter_assignments
      json = json.cast<String, dynamic>();
      for (final entry in json.entries) {
        map[entry.key] = Locale.listFromJson(entry.value, growable: growable,);
      }
    }
    return map;
  }

  /// The list of required keys that must be present in a JSON.
  static const requiredKeys = <String>{
    'language',
  };
}

