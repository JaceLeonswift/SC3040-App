//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.18

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;

class Service {
  /// Returns a new [Service] instance.
  Service({
    required this.id,
    required this.name,
    required this.homePage,
    required this.themeColorCode,
    required this.imageSet,
    required this.streamingOptionTypes,
    this.addons = const [],
  });

  /// Id of the service.
  String id;

  /// Name of the service.
  String name;

  /// Link to the homepage of the service.
  String homePage;

  /// Associated theme color hex code of the service.
  String themeColorCode;

  /// Image set of the service.
  ServiceImageSet imageSet;

  StreamingOptionTypes streamingOptionTypes;

  /// Array of the supported addons in the service.
  List<Addon> addons;

  @override
  bool operator ==(Object other) => identical(this, other) || other is Service &&
    other.id == id &&
    other.name == name &&
    other.homePage == homePage &&
    other.themeColorCode == themeColorCode &&
    other.imageSet == imageSet &&
    other.streamingOptionTypes == streamingOptionTypes &&
    _deepEquality.equals(other.addons, addons);

  @override
  int get hashCode =>
    // ignore: unnecessary_parenthesis
    (id.hashCode) +
    (name.hashCode) +
    (homePage.hashCode) +
    (themeColorCode.hashCode) +
    (imageSet.hashCode) +
    (streamingOptionTypes.hashCode) +
    (addons.hashCode);

  @override
  String toString() => 'Service[id=$id, name=$name, homePage=$homePage, themeColorCode=$themeColorCode, imageSet=$imageSet, streamingOptionTypes=$streamingOptionTypes, addons=$addons]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
      json[r'id'] = this.id;
      json[r'name'] = this.name;
      json[r'homePage'] = this.homePage;
      json[r'themeColorCode'] = this.themeColorCode;
      json[r'imageSet'] = this.imageSet;
      json[r'streamingOptionTypes'] = this.streamingOptionTypes;
      json[r'addons'] = this.addons;
    return json;
  }

  /// Returns a new [Service] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static Service? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        requiredKeys.forEach((key) {
          assert(json.containsKey(key), 'Required key "Service[$key]" is missing from JSON.');
          assert(json[key] != null, 'Required key "Service[$key]" has a null value in JSON.');
        });
        return true;
      }());

      return Service(
        id: mapValueOfType<String>(json, r'id')!,
        name: mapValueOfType<String>(json, r'name')!,
        homePage: mapValueOfType<String>(json, r'homePage')!,
        themeColorCode: mapValueOfType<String>(json, r'themeColorCode')!,
        imageSet: ServiceImageSet.fromJson(json[r'imageSet'])!,
        streamingOptionTypes: StreamingOptionTypes.fromJson(json[r'streamingOptionTypes'])!,
        addons: Addon.listFromJson(json[r'addons']),
      );
    }
    return null;
  }

  static List<Service> listFromJson(dynamic json, {bool growable = false,}) {
    final result = <Service>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = Service.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, Service> mapFromJson(dynamic json) {
    final map = <String, Service>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = Service.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of Service-objects as value to a dart map
  static Map<String, List<Service>> mapListFromJson(dynamic json, {bool growable = false,}) {
    final map = <String, List<Service>>{};
    if (json is Map && json.isNotEmpty) {
      // ignore: parameter_assignments
      json = json.cast<String, dynamic>();
      for (final entry in json.entries) {
        map[entry.key] = Service.listFromJson(entry.value, growable: growable,);
      }
    }
    return map;
  }

  /// The list of required keys that must be present in a JSON.
  static const requiredKeys = <String>{
    'id',
    'name',
    'homePage',
    'themeColorCode',
    'imageSet',
    'streamingOptionTypes',
    'addons',
  };
}

