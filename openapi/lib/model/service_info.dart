//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.18

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;

class ServiceInfo {
  /// Returns a new [ServiceInfo] instance.
  ServiceInfo({
    required this.id,
    required this.name,
    required this.homePage,
    required this.themeColorCode,
    required this.imageSet,
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

  @override
  bool operator ==(Object other) => identical(this, other) || other is ServiceInfo &&
    other.id == id &&
    other.name == name &&
    other.homePage == homePage &&
    other.themeColorCode == themeColorCode &&
    other.imageSet == imageSet;

  @override
  int get hashCode =>
    // ignore: unnecessary_parenthesis
    (id.hashCode) +
    (name.hashCode) +
    (homePage.hashCode) +
    (themeColorCode.hashCode) +
    (imageSet.hashCode);

  @override
  String toString() => 'ServiceInfo[id=$id, name=$name, homePage=$homePage, themeColorCode=$themeColorCode, imageSet=$imageSet]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
      json[r'id'] = this.id;
      json[r'name'] = this.name;
      json[r'homePage'] = this.homePage;
      json[r'themeColorCode'] = this.themeColorCode;
      json[r'imageSet'] = this.imageSet;
    return json;
  }

  /// Returns a new [ServiceInfo] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static ServiceInfo? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        requiredKeys.forEach((key) {
          assert(json.containsKey(key), 'Required key "ServiceInfo[$key]" is missing from JSON.');
          assert(json[key] != null, 'Required key "ServiceInfo[$key]" has a null value in JSON.');
        });
        return true;
      }());

      return ServiceInfo(
        id: mapValueOfType<String>(json, r'id')!,
        name: mapValueOfType<String>(json, r'name')!,
        homePage: mapValueOfType<String>(json, r'homePage')!,
        themeColorCode: mapValueOfType<String>(json, r'themeColorCode')!,
        imageSet: ServiceImageSet.fromJson(json[r'imageSet'])!,
      );
    }
    return null;
  }

  static List<ServiceInfo> listFromJson(dynamic json, {bool growable = false,}) {
    final result = <ServiceInfo>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = ServiceInfo.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, ServiceInfo> mapFromJson(dynamic json) {
    final map = <String, ServiceInfo>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = ServiceInfo.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of ServiceInfo-objects as value to a dart map
  static Map<String, List<ServiceInfo>> mapListFromJson(dynamic json, {bool growable = false,}) {
    final map = <String, List<ServiceInfo>>{};
    if (json is Map && json.isNotEmpty) {
      // ignore: parameter_assignments
      json = json.cast<String, dynamic>();
      for (final entry in json.entries) {
        map[entry.key] = ServiceInfo.listFromJson(entry.value, growable: growable,);
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
  };
}

