//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.18

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;

class Country {
  /// Returns a new [Country] instance.
  Country({
    required this.countryCode,
    required this.name,
    this.services = const [],
  });

  /// [ISO 3166-1 alpha-2 code](https://en.wikipedia.org/wiki/ISO_3166-1_alpha-2) of the country. 
  String countryCode;

  /// Name of the country.
  String name;

  /// Array of the supported services in the country, ordered by popularity.
  List<Service> services;

  @override
  bool operator ==(Object other) => identical(this, other) || other is Country &&
    other.countryCode == countryCode &&
    other.name == name &&
    _deepEquality.equals(other.services, services);

  @override
  int get hashCode =>
    // ignore: unnecessary_parenthesis
    (countryCode.hashCode) +
    (name.hashCode) +
    (services.hashCode);

  @override
  String toString() => 'Country[countryCode=$countryCode, name=$name, services=$services]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
      json[r'countryCode'] = this.countryCode;
      json[r'name'] = this.name;
      json[r'services'] = this.services;
    return json;
  }

  /// Returns a new [Country] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static Country? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        requiredKeys.forEach((key) {
          assert(json.containsKey(key), 'Required key "Country[$key]" is missing from JSON.');
          assert(json[key] != null, 'Required key "Country[$key]" has a null value in JSON.');
        });
        return true;
      }());

      return Country(
        countryCode: mapValueOfType<String>(json, r'countryCode')!,
        name: mapValueOfType<String>(json, r'name')!,
        services: Service.listFromJson(json[r'services']),
      );
    }
    return null;
  }

  static List<Country> listFromJson(dynamic json, {bool growable = false,}) {
    final result = <Country>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = Country.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, Country> mapFromJson(dynamic json) {
    final map = <String, Country>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = Country.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of Country-objects as value to a dart map
  static Map<String, List<Country>> mapListFromJson(dynamic json, {bool growable = false,}) {
    final map = <String, List<Country>>{};
    if (json is Map && json.isNotEmpty) {
      // ignore: parameter_assignments
      json = json.cast<String, dynamic>();
      for (final entry in json.entries) {
        map[entry.key] = Country.listFromJson(entry.value, growable: growable,);
      }
    }
    return map;
  }

  /// The list of required keys that must be present in a JSON.
  static const requiredKeys = <String>{
    'countryCode',
    'name',
    'services',
  };
}

