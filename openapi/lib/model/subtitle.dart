//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.18

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;

class Subtitle {
  /// Returns a new [Subtitle] instance.
  Subtitle({
    required this.closedCaptions,
    required this.locale,
  });

  /// Whether closed captions are available for the subtitle.
  bool closedCaptions;

  Locale locale;

  @override
  bool operator ==(Object other) => identical(this, other) || other is Subtitle &&
    other.closedCaptions == closedCaptions &&
    other.locale == locale;

  @override
  int get hashCode =>
    // ignore: unnecessary_parenthesis
    (closedCaptions.hashCode) +
    (locale.hashCode);

  @override
  String toString() => 'Subtitle[closedCaptions=$closedCaptions, locale=$locale]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
      json[r'closedCaptions'] = this.closedCaptions;
      json[r'locale'] = this.locale;
    return json;
  }

  /// Returns a new [Subtitle] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static Subtitle? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        requiredKeys.forEach((key) {
          assert(json.containsKey(key), 'Required key "Subtitle[$key]" is missing from JSON.');
          assert(json[key] != null, 'Required key "Subtitle[$key]" has a null value in JSON.');
        });
        return true;
      }());

      return Subtitle(
        closedCaptions: mapValueOfType<bool>(json, r'closedCaptions')!,
        locale: Locale.fromJson(json[r'locale'])!,
      );
    }
    return null;
  }

  static List<Subtitle> listFromJson(dynamic json, {bool growable = false,}) {
    final result = <Subtitle>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = Subtitle.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, Subtitle> mapFromJson(dynamic json) {
    final map = <String, Subtitle>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = Subtitle.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of Subtitle-objects as value to a dart map
  static Map<String, List<Subtitle>> mapListFromJson(dynamic json, {bool growable = false,}) {
    final map = <String, List<Subtitle>>{};
    if (json is Map && json.isNotEmpty) {
      // ignore: parameter_assignments
      json = json.cast<String, dynamic>();
      for (final entry in json.entries) {
        map[entry.key] = Subtitle.listFromJson(entry.value, growable: growable,);
      }
    }
    return map;
  }

  /// The list of required keys that must be present in a JSON.
  static const requiredKeys = <String>{
    'closedCaptions',
    'locale',
  };
}

