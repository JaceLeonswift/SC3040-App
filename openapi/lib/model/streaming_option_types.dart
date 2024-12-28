//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.18

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;

class StreamingOptionTypes {
  /// Returns a new [StreamingOptionTypes] instance.
  StreamingOptionTypes({
    required this.addon,
    required this.buy,
    required this.rent,
    required this.free,
    required this.subscription,
  });

  /// Whether there are shows available via an addon/channel subscription.
  bool addon;

  /// Whether there are shows available to buy.
  bool buy;

  /// Whether there are shows available for rental.
  bool rent;

  /// Whether there are free shows to watch.
  bool free;

  /// Whether there are shows available via a paid subscription plan.
  bool subscription;

  @override
  bool operator ==(Object other) => identical(this, other) || other is StreamingOptionTypes &&
    other.addon == addon &&
    other.buy == buy &&
    other.rent == rent &&
    other.free == free &&
    other.subscription == subscription;

  @override
  int get hashCode =>
    // ignore: unnecessary_parenthesis
    (addon.hashCode) +
    (buy.hashCode) +
    (rent.hashCode) +
    (free.hashCode) +
    (subscription.hashCode);

  @override
  String toString() => 'StreamingOptionTypes[addon=$addon, buy=$buy, rent=$rent, free=$free, subscription=$subscription]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
      json[r'addon'] = this.addon;
      json[r'buy'] = this.buy;
      json[r'rent'] = this.rent;
      json[r'free'] = this.free;
      json[r'subscription'] = this.subscription;
    return json;
  }

  /// Returns a new [StreamingOptionTypes] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static StreamingOptionTypes? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        requiredKeys.forEach((key) {
          assert(json.containsKey(key), 'Required key "StreamingOptionTypes[$key]" is missing from JSON.');
          assert(json[key] != null, 'Required key "StreamingOptionTypes[$key]" has a null value in JSON.');
        });
        return true;
      }());

      return StreamingOptionTypes(
        addon: mapValueOfType<bool>(json, r'addon')!,
        buy: mapValueOfType<bool>(json, r'buy')!,
        rent: mapValueOfType<bool>(json, r'rent')!,
        free: mapValueOfType<bool>(json, r'free')!,
        subscription: mapValueOfType<bool>(json, r'subscription')!,
      );
    }
    return null;
  }

  static List<StreamingOptionTypes> listFromJson(dynamic json, {bool growable = false,}) {
    final result = <StreamingOptionTypes>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = StreamingOptionTypes.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, StreamingOptionTypes> mapFromJson(dynamic json) {
    final map = <String, StreamingOptionTypes>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = StreamingOptionTypes.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of StreamingOptionTypes-objects as value to a dart map
  static Map<String, List<StreamingOptionTypes>> mapListFromJson(dynamic json, {bool growable = false,}) {
    final map = <String, List<StreamingOptionTypes>>{};
    if (json is Map && json.isNotEmpty) {
      // ignore: parameter_assignments
      json = json.cast<String, dynamic>();
      for (final entry in json.entries) {
        map[entry.key] = StreamingOptionTypes.listFromJson(entry.value, growable: growable,);
      }
    }
    return map;
  }

  /// The list of required keys that must be present in a JSON.
  static const requiredKeys = <String>{
    'addon',
    'buy',
    'rent',
    'free',
    'subscription',
  };
}

