//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.18

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;

class ShowImageSet {
  /// Returns a new [ShowImageSet] instance.
  ShowImageSet({
    required this.verticalPoster,
    required this.horizontalPoster,
    this.verticalBackdrop,
    this.horizontalBackdrop,
  });

  /// Vertical poster of the show.
  VerticalImage verticalPoster;

  /// Horizontal poster of the show.
  HorizontalImage horizontalPoster;

  /// Vertical backdrop of the show.
  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  VerticalImage? verticalBackdrop;

  /// Horizontal backdrop of the show.
  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  HorizontalImage? horizontalBackdrop;

  @override
  bool operator ==(Object other) => identical(this, other) || other is ShowImageSet &&
    other.verticalPoster == verticalPoster &&
    other.horizontalPoster == horizontalPoster &&
    other.verticalBackdrop == verticalBackdrop &&
    other.horizontalBackdrop == horizontalBackdrop;

  @override
  int get hashCode =>
    // ignore: unnecessary_parenthesis
    (verticalPoster.hashCode) +
    (horizontalPoster.hashCode) +
    (verticalBackdrop == null ? 0 : verticalBackdrop!.hashCode) +
    (horizontalBackdrop == null ? 0 : horizontalBackdrop!.hashCode);

  @override
  String toString() => 'ShowImageSet[verticalPoster=$verticalPoster, horizontalPoster=$horizontalPoster, verticalBackdrop=$verticalBackdrop, horizontalBackdrop=$horizontalBackdrop]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
      json[r'verticalPoster'] = this.verticalPoster;
      json[r'horizontalPoster'] = this.horizontalPoster;
    if (this.verticalBackdrop != null) {
      json[r'verticalBackdrop'] = this.verticalBackdrop;
    } else {
      json[r'verticalBackdrop'] = null;
    }
    if (this.horizontalBackdrop != null) {
      json[r'horizontalBackdrop'] = this.horizontalBackdrop;
    } else {
      json[r'horizontalBackdrop'] = null;
    }
    return json;
  }

  /// Returns a new [ShowImageSet] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static ShowImageSet? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        requiredKeys.forEach((key) {
          assert(json.containsKey(key), 'Required key "ShowImageSet[$key]" is missing from JSON.');
          assert(json[key] != null, 'Required key "ShowImageSet[$key]" has a null value in JSON.');
        });
        return true;
      }());

      return ShowImageSet(
        verticalPoster: VerticalImage.fromJson(json[r'verticalPoster'])!,
        horizontalPoster: HorizontalImage.fromJson(json[r'horizontalPoster'])!,
        verticalBackdrop: VerticalImage.fromJson(json[r'verticalBackdrop']),
        horizontalBackdrop: HorizontalImage.fromJson(json[r'horizontalBackdrop']),
      );
    }
    return null;
  }

  static List<ShowImageSet> listFromJson(dynamic json, {bool growable = false,}) {
    final result = <ShowImageSet>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = ShowImageSet.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, ShowImageSet> mapFromJson(dynamic json) {
    final map = <String, ShowImageSet>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = ShowImageSet.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of ShowImageSet-objects as value to a dart map
  static Map<String, List<ShowImageSet>> mapListFromJson(dynamic json, {bool growable = false,}) {
    final map = <String, List<ShowImageSet>>{};
    if (json is Map && json.isNotEmpty) {
      // ignore: parameter_assignments
      json = json.cast<String, dynamic>();
      for (final entry in json.entries) {
        map[entry.key] = ShowImageSet.listFromJson(entry.value, growable: growable,);
      }
    }
    return map;
  }

  /// The list of required keys that must be present in a JSON.
  static const requiredKeys = <String>{
    'verticalPoster',
    'horizontalPoster',
  };
}

