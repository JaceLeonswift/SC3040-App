import 'package:openapi/api.dart';

class CollectionOfShows {
  String name;
  List<ModelShow> showsList = [];

  CollectionOfShows({required this.name, List<ModelShow>? listofshows})
      : showsList = listofshows ?? [];

  static const requiredKeys = <String>{'name'};

  @override
  String toString() {
    return 'CollectionOfShows[name=$name, showsList=$showsList]';
  }

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
    json['name'] = this.name;
    json['showsList'] = this.showsList.map((show) => show.toJson()).toList();
    return json;
  }

  static CollectionOfShows? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      assert(() {
        requiredKeys.forEach((key) {
          assert(json.containsKey(key),
              'Required key "CollectionOfShows[$key]" is missing from JSON.');
          assert(json[key] != null,
              'Required key "CollectionOfShows[$key]" has a null value in JSON.');
        });
        return true;
      }());

      return CollectionOfShows(
        name: mapValueOfType<String>(json, 'name')!,
        listofshows: ModelShow.listFromJson(json['showsList'], growable: true),
      );
    }
    return null;
  }

  static List<CollectionOfShows> listFromJson(dynamic json,
      {bool growable = true}) {
    final result = <CollectionOfShows>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = CollectionOfShows.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }
}
