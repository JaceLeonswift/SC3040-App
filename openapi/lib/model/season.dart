//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.18

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;

class Season {
  /// Returns a new [Season] instance.
  Season({
    required this.itemType,
    required this.title,
    required this.firstAirYear,
    required this.lastAirYear,
    this.streamingOptions = const {},
    this.episodes = const [],
  });

  /// Type of the item. Always season.
  String itemType;

  /// Title of the season.
  String title;

  /// The first year that the season aired.
  int firstAirYear;

  /// The last year that the season aired.
  int lastAirYear;

  /// Map of the streaming options by the country code.
  Map<String, List<StreamingOption>> streamingOptions;

  /// Array of the episodes belong to the season.
  List<Episode> episodes;

  @override
  bool operator ==(Object other) => identical(this, other) || other is Season &&
    other.itemType == itemType &&
    other.title == title &&
    other.firstAirYear == firstAirYear &&
    other.lastAirYear == lastAirYear &&
    _deepEquality.equals(other.streamingOptions, streamingOptions) &&
    _deepEquality.equals(other.episodes, episodes);

  @override
  int get hashCode =>
    // ignore: unnecessary_parenthesis
    (itemType.hashCode) +
    (title.hashCode) +
    (firstAirYear.hashCode) +
    (lastAirYear.hashCode) +
    (streamingOptions.hashCode) +
    (episodes.hashCode);

  @override
  String toString() => 'Season[itemType=$itemType, title=$title, firstAirYear=$firstAirYear, lastAirYear=$lastAirYear, streamingOptions=$streamingOptions, episodes=$episodes]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
      json[r'itemType'] = this.itemType;
      json[r'title'] = this.title;
      json[r'firstAirYear'] = this.firstAirYear;
      json[r'lastAirYear'] = this.lastAirYear;
      json[r'streamingOptions'] = this.streamingOptions;
      json[r'episodes'] = this.episodes;
    return json;
  }

  /// Returns a new [Season] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static Season? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        requiredKeys.forEach((key) {
          assert(json.containsKey(key), 'Required key "Season[$key]" is missing from JSON.');
          assert(json[key] != null, 'Required key "Season[$key]" has a null value in JSON.');
        });
        return true;
      }());

      return Season(
        itemType: mapValueOfType<String>(json, r'itemType')!,
        title: mapValueOfType<String>(json, r'title')!,
        firstAirYear: mapValueOfType<int>(json, r'firstAirYear')!,
        lastAirYear: mapValueOfType<int>(json, r'lastAirYear')!,
        streamingOptions: json[r'streamingOptions'] == null
          ? const {}
            : StreamingOption.mapListFromJson(json[r'streamingOptions']),
        episodes: Episode.listFromJson(json[r'episodes']),
      );
    }
    return null;
  }

  static List<Season> listFromJson(dynamic json, {bool growable = false,}) {
    final result = <Season>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = Season.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, Season> mapFromJson(dynamic json) {
    final map = <String, Season>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = Season.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of Season-objects as value to a dart map
  static Map<String, List<Season>> mapListFromJson(dynamic json, {bool growable = false,}) {
    final map = <String, List<Season>>{};
    if (json is Map && json.isNotEmpty) {
      // ignore: parameter_assignments
      json = json.cast<String, dynamic>();
      for (final entry in json.entries) {
        map[entry.key] = Season.listFromJson(entry.value, growable: growable,);
      }
    }
    return map;
  }

  /// The list of required keys that must be present in a JSON.
  static const requiredKeys = <String>{
    'itemType',
    'title',
    'firstAirYear',
    'lastAirYear',
    'streamingOptions',
  };
}

