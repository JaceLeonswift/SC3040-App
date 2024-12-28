//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.18

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;

class ModelShow {
  /// Returns a new [ModelShow] instance.
  ModelShow({
    required this.itemType,
    required this.showType,
    required this.id,
    required this.imdbId,
    required this.tmdbId,
    required this.title,
    required this.overview,
    this.releaseYear,
    this.firstAirYear,
    this.lastAirYear,
    required this.originalTitle,
    this.genres = const [],
    this.directors = const [],
    this.creators = const [],
    this.cast = const [],
    required this.rating,
    this.seasonCount,
    this.episodeCount,
    this.runtime,
    required this.imageSet,
    this.streamingOptions = const {},
    this.seasons = const [],
  });

  /// Type of the item. Always show.
  String itemType;

  /// Type of the show. Based on the type, some properties might be omitted.
  ShowType showType;

  /// Id of the show.
  String id;

  /// [IMDb](https://www.imdb.com/) id of the show.
  String imdbId;

  /// [TMDB](https://www.themoviedb.org/) id of the show.
  String tmdbId;

  /// Title of the show.
  String title;

  /// A brief overview of the overall plot of the show.
  String overview;

  /// The year that the movie was released.
  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  int? releaseYear;

  /// The first year that the series aired.
  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  int? firstAirYear;

  /// The last year that the series aired.
  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  int? lastAirYear;

  /// Original title of the show.
  String originalTitle;

  /// Array of the genres of the show.
  List<Genre> genres;

  /// Array of the directors of the movie.
  List<String> directors;

  /// Array of the creators of the series.
  List<String> creators;

  /// Array of the cast of the show.
  List<String> cast;

  /// Rating of the show. This is calculated by taking the average of ratings found online from multiple sources.
  ///
  /// Minimum value: 0
  /// Maximum value: 100
  int rating;

  /// Number of seasons that are either aired or announced for a series.
  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  int? seasonCount;

  /// Number of episodes that are either aired or announced for a series.
  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  int? episodeCount;

  /// Runtime of the movie in minutes.
  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  int? runtime;

  /// Image set of the show.
  ShowImageSet imageSet;

  /// Map of the streaming options by the country code.
  Map<String, List<StreamingOption>> streamingOptions;

  /// Array of the seasons belong to the series.
  List<Season> seasons;

  @override
  bool operator ==(Object other) => identical(this, other) || other is ModelShow &&
    other.itemType == itemType &&
    other.showType == showType &&
    other.id == id &&
    other.imdbId == imdbId &&
    other.tmdbId == tmdbId &&
    other.title == title &&
    other.overview == overview &&
    other.releaseYear == releaseYear &&
    other.firstAirYear == firstAirYear &&
    other.lastAirYear == lastAirYear &&
    other.originalTitle == originalTitle &&
    _deepEquality.equals(other.genres, genres) &&
    _deepEquality.equals(other.directors, directors) &&
    _deepEquality.equals(other.creators, creators) &&
    _deepEquality.equals(other.cast, cast) &&
    other.rating == rating &&
    other.seasonCount == seasonCount &&
    other.episodeCount == episodeCount &&
    other.runtime == runtime &&
    other.imageSet == imageSet &&
    _deepEquality.equals(other.streamingOptions, streamingOptions) &&
    _deepEquality.equals(other.seasons, seasons);

  @override
  int get hashCode =>
    // ignore: unnecessary_parenthesis
    (itemType.hashCode) +
    (showType.hashCode) +
    (id.hashCode) +
    (imdbId.hashCode) +
    (tmdbId.hashCode) +
    (title.hashCode) +
    (overview.hashCode) +
    (releaseYear == null ? 0 : releaseYear!.hashCode) +
    (firstAirYear == null ? 0 : firstAirYear!.hashCode) +
    (lastAirYear == null ? 0 : lastAirYear!.hashCode) +
    (originalTitle.hashCode) +
    (genres.hashCode) +
    (directors.hashCode) +
    (creators.hashCode) +
    (cast.hashCode) +
    (rating.hashCode) +
    (seasonCount == null ? 0 : seasonCount!.hashCode) +
    (episodeCount == null ? 0 : episodeCount!.hashCode) +
    (runtime == null ? 0 : runtime!.hashCode) +
    (imageSet.hashCode) +
    (streamingOptions.hashCode) +
    (seasons.hashCode);

  @override
  String toString() => 'ModelShow[itemType=$itemType, showType=$showType, id=$id, imdbId=$imdbId, tmdbId=$tmdbId, title=$title, overview=$overview, releaseYear=$releaseYear, firstAirYear=$firstAirYear, lastAirYear=$lastAirYear, originalTitle=$originalTitle, genres=$genres, directors=$directors, creators=$creators, cast=$cast, rating=$rating, seasonCount=$seasonCount, episodeCount=$episodeCount, runtime=$runtime, imageSet=$imageSet, streamingOptions=$streamingOptions, seasons=$seasons]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
      json[r'itemType'] = this.itemType;
      json[r'showType'] = this.showType;
      json[r'id'] = this.id;
      json[r'imdbId'] = this.imdbId;
      json[r'tmdbId'] = this.tmdbId;
      json[r'title'] = this.title;
      json[r'overview'] = this.overview;
    if (this.releaseYear != null) {
      json[r'releaseYear'] = this.releaseYear;
    } else {
      json[r'releaseYear'] = null;
    }
    if (this.firstAirYear != null) {
      json[r'firstAirYear'] = this.firstAirYear;
    } else {
      json[r'firstAirYear'] = null;
    }
    if (this.lastAirYear != null) {
      json[r'lastAirYear'] = this.lastAirYear;
    } else {
      json[r'lastAirYear'] = null;
    }
      json[r'originalTitle'] = this.originalTitle;
      json[r'genres'] = this.genres;
      json[r'directors'] = this.directors;
      json[r'creators'] = this.creators;
      json[r'cast'] = this.cast;
      json[r'rating'] = this.rating;
    if (this.seasonCount != null) {
      json[r'seasonCount'] = this.seasonCount;
    } else {
      json[r'seasonCount'] = null;
    }
    if (this.episodeCount != null) {
      json[r'episodeCount'] = this.episodeCount;
    } else {
      json[r'episodeCount'] = null;
    }
    if (this.runtime != null) {
      json[r'runtime'] = this.runtime;
    } else {
      json[r'runtime'] = null;
    }
      json[r'imageSet'] = this.imageSet;
      json[r'streamingOptions'] = this.streamingOptions;
      json[r'seasons'] = this.seasons;
    return json;
  }

  /// Returns a new [ModelShow] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static ModelShow? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        requiredKeys.forEach((key) {
          assert(json.containsKey(key), 'Required key "ModelShow[$key]" is missing from JSON.');
          assert(json[key] != null, 'Required key "ModelShow[$key]" has a null value in JSON.');
        });
        return true;
      }());

      return ModelShow(
        itemType: mapValueOfType<String>(json, r'itemType')!,
        showType: ShowType.fromJson(json[r'showType'])!,
        id: mapValueOfType<String>(json, r'id')!,
        imdbId: mapValueOfType<String>(json, r'imdbId')!,
        tmdbId: mapValueOfType<String>(json, r'tmdbId')!,
        title: mapValueOfType<String>(json, r'title')!,
        overview: mapValueOfType<String>(json, r'overview')!,
        releaseYear: mapValueOfType<int>(json, r'releaseYear'),
        firstAirYear: mapValueOfType<int>(json, r'firstAirYear'),
        lastAirYear: mapValueOfType<int>(json, r'lastAirYear'),
        originalTitle: mapValueOfType<String>(json, r'originalTitle')!,
        genres: Genre.listFromJson(json[r'genres']),
        directors: json[r'directors'] is Iterable
            ? (json[r'directors'] as Iterable).cast<String>().toList(growable: false)
            : const [],
        creators: json[r'creators'] is Iterable
            ? (json[r'creators'] as Iterable).cast<String>().toList(growable: false)
            : const [],
        cast: json[r'cast'] is Iterable
            ? (json[r'cast'] as Iterable).cast<String>().toList(growable: false)
            : const [],
        rating: mapValueOfType<int>(json, r'rating')!,
        seasonCount: mapValueOfType<int>(json, r'seasonCount'),
        episodeCount: mapValueOfType<int>(json, r'episodeCount'),
        runtime: mapValueOfType<int>(json, r'runtime'),
        imageSet: ShowImageSet.fromJson(json[r'imageSet'])!,
        streamingOptions: json[r'streamingOptions'] == null
          ? const {}
            : StreamingOption.mapListFromJson(json[r'streamingOptions']),
        seasons: Season.listFromJson(json[r'seasons']),
      );
    }
    return null;
  }

  static List<ModelShow> listFromJson(dynamic json, {bool growable = false,}) {
    final result = <ModelShow>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = ModelShow.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, ModelShow> mapFromJson(dynamic json) {
    final map = <String, ModelShow>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = ModelShow.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of ModelShow-objects as value to a dart map
  static Map<String, List<ModelShow>> mapListFromJson(dynamic json, {bool growable = false,}) {
    final map = <String, List<ModelShow>>{};
    if (json is Map && json.isNotEmpty) {
      // ignore: parameter_assignments
      json = json.cast<String, dynamic>();
      for (final entry in json.entries) {
        map[entry.key] = ModelShow.listFromJson(entry.value, growable: growable,);
      }
    }
    return map;
  }

  /// The list of required keys that must be present in a JSON.
  static const requiredKeys = <String>{
    'itemType',
    'showType',
    'id',
    'imdbId',
    'tmdbId',
    'title',
    'overview',
    'originalTitle',
    'genres',
    'cast',
    'rating',
    'imageSet',
    'streamingOptions',
  };
}

