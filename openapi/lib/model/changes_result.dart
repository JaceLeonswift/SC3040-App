//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.18

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;

class ChangesResult {
  /// Returns a new [ChangesResult] instance.
  ChangesResult({
    this.changes = const [],
    this.shows = const {},
    required this.hasMore,
    this.nextCursor,
  });

  /// Array of the changes.
  List<Change> changes;

  /// Map of the shows by their ids.
  Map<String, ModelShow> shows;

  /// Whether there are more changes available.
  bool hasMore;

  /// Cursor value to pass to get the next set of changes.
  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  String? nextCursor;

  @override
  bool operator ==(Object other) => identical(this, other) || other is ChangesResult &&
    _deepEquality.equals(other.changes, changes) &&
    _deepEquality.equals(other.shows, shows) &&
    other.hasMore == hasMore &&
    other.nextCursor == nextCursor;

  @override
  int get hashCode =>
    // ignore: unnecessary_parenthesis
    (changes.hashCode) +
    (shows.hashCode) +
    (hasMore.hashCode) +
    (nextCursor == null ? 0 : nextCursor!.hashCode);

  @override
  String toString() => 'ChangesResult[changes=$changes, shows=$shows, hasMore=$hasMore, nextCursor=$nextCursor]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
      json[r'changes'] = this.changes;
      json[r'shows'] = this.shows;
      json[r'hasMore'] = this.hasMore;
    if (this.nextCursor != null) {
      json[r'nextCursor'] = this.nextCursor;
    } else {
      json[r'nextCursor'] = null;
    }
    return json;
  }

  /// Returns a new [ChangesResult] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static ChangesResult? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        requiredKeys.forEach((key) {
          assert(json.containsKey(key), 'Required key "ChangesResult[$key]" is missing from JSON.');
          assert(json[key] != null, 'Required key "ChangesResult[$key]" has a null value in JSON.');
        });
        return true;
      }());

      return ChangesResult(
        changes: Change.listFromJson(json[r'changes']),
        shows: ModelShow.mapFromJson(json[r'shows']),
        hasMore: mapValueOfType<bool>(json, r'hasMore')!,
        nextCursor: mapValueOfType<String>(json, r'nextCursor'),
      );
    }
    return null;
  }

  static List<ChangesResult> listFromJson(dynamic json, {bool growable = false,}) {
    final result = <ChangesResult>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = ChangesResult.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, ChangesResult> mapFromJson(dynamic json) {
    final map = <String, ChangesResult>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = ChangesResult.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of ChangesResult-objects as value to a dart map
  static Map<String, List<ChangesResult>> mapListFromJson(dynamic json, {bool growable = false,}) {
    final map = <String, List<ChangesResult>>{};
    if (json is Map && json.isNotEmpty) {
      // ignore: parameter_assignments
      json = json.cast<String, dynamic>();
      for (final entry in json.entries) {
        map[entry.key] = ChangesResult.listFromJson(entry.value, growable: growable,);
      }
    }
    return map;
  }

  /// The list of required keys that must be present in a JSON.
  static const requiredKeys = <String>{
    'changes',
    'shows',
    'hasMore',
  };
}

