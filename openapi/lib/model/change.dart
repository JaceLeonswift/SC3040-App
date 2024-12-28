//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.18

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;

class Change {
  /// Returns a new [Change] instance.
  Change({
    required this.changeType,
    required this.itemType,
    required this.showId,
    required this.showType,
    this.season,
    this.episode,
    required this.service,
    required this.streamingOptionType,
    this.addon,
    this.timestamp,
    this.link,
  });

  /// Type of the change.
  ChangeType changeType;

  /// Type of the item affected from the change.
  ItemType itemType;

  /// Id of the show affected from the change.
  String showId;

  /// Type of the show affected from the change.
  ShowType showType;

  /// Number of the season affected from the change. Omitted if item_type is not seasonor episode.
  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  int? season;

  /// Number of the episode affected from the change. Omitted if item_type is not episode.
  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  int? episode;

  /// Service affected from the change.
  ServiceInfo service;

  StreamingOptionType streamingOptionType;

  /// Addon info, if the streamingOptionType is addon. Otherwise omitted.
  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  Addon? addon;

  /// [Unix Time Stamp](https://www.unixtimestamp.com/) of the change. Past changes (new, updated, removed) will always have a timestamp. Future changes (expiring, upcoming) will have a timestamp if the exact date is known. If not, timestamp will be omitted, e.g. a show is known to be expiring soon, but the exact date is not known. 
  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  int? timestamp;

  /// Deep link to the affected streaming option's page in the web app of the streaming service. This field is guaranteed to be populated when changeType is new, updated, expiring or removed. When changeType is upcoming, this field might be populated or null depending on if the link of the future streaming option is known. 
  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  String? link;

  @override
  bool operator ==(Object other) => identical(this, other) || other is Change &&
    other.changeType == changeType &&
    other.itemType == itemType &&
    other.showId == showId &&
    other.showType == showType &&
    other.season == season &&
    other.episode == episode &&
    other.service == service &&
    other.streamingOptionType == streamingOptionType &&
    other.addon == addon &&
    other.timestamp == timestamp &&
    other.link == link;

  @override
  int get hashCode =>
    // ignore: unnecessary_parenthesis
    (changeType.hashCode) +
    (itemType.hashCode) +
    (showId.hashCode) +
    (showType.hashCode) +
    (season == null ? 0 : season!.hashCode) +
    (episode == null ? 0 : episode!.hashCode) +
    (service.hashCode) +
    (streamingOptionType.hashCode) +
    (addon == null ? 0 : addon!.hashCode) +
    (timestamp == null ? 0 : timestamp!.hashCode) +
    (link == null ? 0 : link!.hashCode);

  @override
  String toString() => 'Change[changeType=$changeType, itemType=$itemType, showId=$showId, showType=$showType, season=$season, episode=$episode, service=$service, streamingOptionType=$streamingOptionType, addon=$addon, timestamp=$timestamp, link=$link]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
      json[r'changeType'] = this.changeType;
      json[r'itemType'] = this.itemType;
      json[r'showId'] = this.showId;
      json[r'showType'] = this.showType;
    if (this.season != null) {
      json[r'season'] = this.season;
    } else {
      json[r'season'] = null;
    }
    if (this.episode != null) {
      json[r'episode'] = this.episode;
    } else {
      json[r'episode'] = null;
    }
      json[r'service'] = this.service;
      json[r'streamingOptionType'] = this.streamingOptionType;
    if (this.addon != null) {
      json[r'addon'] = this.addon;
    } else {
      json[r'addon'] = null;
    }
    if (this.timestamp != null) {
      json[r'timestamp'] = this.timestamp;
    } else {
      json[r'timestamp'] = null;
    }
    if (this.link != null) {
      json[r'link'] = this.link;
    } else {
      json[r'link'] = null;
    }
    return json;
  }

  /// Returns a new [Change] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static Change? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        requiredKeys.forEach((key) {
          assert(json.containsKey(key), 'Required key "Change[$key]" is missing from JSON.');
          assert(json[key] != null, 'Required key "Change[$key]" has a null value in JSON.');
        });
        return true;
      }());

      return Change(
        changeType: ChangeType.fromJson(json[r'changeType'])!,
        itemType: ItemType.fromJson(json[r'itemType'])!,
        showId: mapValueOfType<String>(json, r'showId')!,
        showType: ShowType.fromJson(json[r'showType'])!,
        season: mapValueOfType<int>(json, r'season'),
        episode: mapValueOfType<int>(json, r'episode'),
        service: ServiceInfo.fromJson(json[r'service'])!,
        streamingOptionType: StreamingOptionType.fromJson(json[r'streamingOptionType'])!,
        addon: Addon.fromJson(json[r'addon']),
        timestamp: mapValueOfType<int>(json, r'timestamp'),
        link: mapValueOfType<String>(json, r'link'),
      );
    }
    return null;
  }

  static List<Change> listFromJson(dynamic json, {bool growable = false,}) {
    final result = <Change>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = Change.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, Change> mapFromJson(dynamic json) {
    final map = <String, Change>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = Change.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of Change-objects as value to a dart map
  static Map<String, List<Change>> mapListFromJson(dynamic json, {bool growable = false,}) {
    final map = <String, List<Change>>{};
    if (json is Map && json.isNotEmpty) {
      // ignore: parameter_assignments
      json = json.cast<String, dynamic>();
      for (final entry in json.entries) {
        map[entry.key] = Change.listFromJson(entry.value, growable: growable,);
      }
    }
    return map;
  }

  /// The list of required keys that must be present in a JSON.
  static const requiredKeys = <String>{
    'changeType',
    'itemType',
    'showId',
    'showType',
    'service',
    'streamingOptionType',
  };
}

