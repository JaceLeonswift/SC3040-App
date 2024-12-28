//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.18

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;

class StreamingOption {
  /// Returns a new [StreamingOption] instance.
  StreamingOption({
    required this.service,
    required this.type,
    this.addon,
    required this.link,
    this.videoLink,
    this.quality,
    this.audios = const [],
    this.subtitles = const [],
    this.price,
    required this.expiresSoon,
    this.expiresOn,
    required this.availableSince,
  });

  ServiceInfo service;

  StreamingOptionType type;

  /// Addon that the streaming option is available through. Omitted if the streaming option is not available through an addon. 
  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  Addon? addon;

  /// Deep link to the streaming option's page in the web app of the streaming service. Unlike videoLink, this field is guaranteed to be populated. 
  String link;

  /// Deep link to the video associated with the streaming option. Omitted if there's no direct link to the video. Might have the same value as link. 
  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  String? videoLink;

  /// Maximum supported video quality of the streaming option.
  StreamingOptionQualityEnum? quality;

  /// Array of the available audios.
  List<Locale> audios;

  /// Array of the available subtitles.
  List<Subtitle> subtitles;

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  Price? price;

  /// Whether the streaming option expires within a month.
  bool expiresSoon;

  /// [Unix Time Stamp](https://www.unixtimestamp.com/) of the date that the streaming option is expiring. In other words, last day to watch. 
  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  int? expiresOn;

  /// [Unix Time Stamp](https://www.unixtimestamp.com/) of the date that this streaming option was detected. 
  int availableSince;

  @override
  bool operator ==(Object other) => identical(this, other) || other is StreamingOption &&
    other.service == service &&
    other.type == type &&
    other.addon == addon &&
    other.link == link &&
    other.videoLink == videoLink &&
    other.quality == quality &&
    _deepEquality.equals(other.audios, audios) &&
    _deepEquality.equals(other.subtitles, subtitles) &&
    other.price == price &&
    other.expiresSoon == expiresSoon &&
    other.expiresOn == expiresOn &&
    other.availableSince == availableSince;

  @override
  int get hashCode =>
    // ignore: unnecessary_parenthesis
    (service.hashCode) +
    (type.hashCode) +
    (addon == null ? 0 : addon!.hashCode) +
    (link.hashCode) +
    (videoLink == null ? 0 : videoLink!.hashCode) +
    (quality == null ? 0 : quality!.hashCode) +
    (audios.hashCode) +
    (subtitles.hashCode) +
    (price == null ? 0 : price!.hashCode) +
    (expiresSoon.hashCode) +
    (expiresOn == null ? 0 : expiresOn!.hashCode) +
    (availableSince.hashCode);

  @override
  String toString() => 'StreamingOption[service=$service, type=$type, addon=$addon, link=$link, videoLink=$videoLink, quality=$quality, audios=$audios, subtitles=$subtitles, price=$price, expiresSoon=$expiresSoon, expiresOn=$expiresOn, availableSince=$availableSince]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
      json[r'service'] = this.service;
      json[r'type'] = this.type;
    if (this.addon != null) {
      json[r'addon'] = this.addon;
    } else {
      json[r'addon'] = null;
    }
      json[r'link'] = this.link;
    if (this.videoLink != null) {
      json[r'videoLink'] = this.videoLink;
    } else {
      json[r'videoLink'] = null;
    }
    if (this.quality != null) {
      json[r'quality'] = this.quality;
    } else {
      json[r'quality'] = null;
    }
      json[r'audios'] = this.audios;
      json[r'subtitles'] = this.subtitles;
    if (this.price != null) {
      json[r'price'] = this.price;
    } else {
      json[r'price'] = null;
    }
      json[r'expiresSoon'] = this.expiresSoon;
    if (this.expiresOn != null) {
      json[r'expiresOn'] = this.expiresOn;
    } else {
      json[r'expiresOn'] = null;
    }
      json[r'availableSince'] = this.availableSince;
    return json;
  }

  /// Returns a new [StreamingOption] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static StreamingOption? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        requiredKeys.forEach((key) {
          assert(json.containsKey(key), 'Required key "StreamingOption[$key]" is missing from JSON.');
          assert(json[key] != null, 'Required key "StreamingOption[$key]" has a null value in JSON.');
        });
        return true;
      }());

      return StreamingOption(
        service: ServiceInfo.fromJson(json[r'service'])!,
        type: StreamingOptionType.fromJson(json[r'type'])!,
        addon: Addon.fromJson(json[r'addon']),
        link: mapValueOfType<String>(json, r'link')!,
        videoLink: mapValueOfType<String>(json, r'videoLink'),
        quality: StreamingOptionQualityEnum.fromJson(json[r'quality']),
        audios: Locale.listFromJson(json[r'audios']),
        subtitles: Subtitle.listFromJson(json[r'subtitles']),
        price: Price.fromJson(json[r'price']),
        expiresSoon: mapValueOfType<bool>(json, r'expiresSoon')!,
        expiresOn: mapValueOfType<int>(json, r'expiresOn'),
        availableSince: mapValueOfType<int>(json, r'availableSince')!,
      );
    }
    return null;
  }

  static List<StreamingOption> listFromJson(dynamic json, {bool growable = false,}) {
    final result = <StreamingOption>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = StreamingOption.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, StreamingOption> mapFromJson(dynamic json) {
    final map = <String, StreamingOption>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = StreamingOption.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of StreamingOption-objects as value to a dart map
  static Map<String, List<StreamingOption>> mapListFromJson(dynamic json, {bool growable = false,}) {
    final map = <String, List<StreamingOption>>{};
    if (json is Map && json.isNotEmpty) {
      // ignore: parameter_assignments
      json = json.cast<String, dynamic>();
      for (final entry in json.entries) {
        map[entry.key] = StreamingOption.listFromJson(entry.value, growable: growable,);
      }
    }
    return map;
  }

  /// The list of required keys that must be present in a JSON.
  static const requiredKeys = <String>{
    'service',
    'type',
    'link',
    'audios',
    'subtitles',
    'expiresSoon',
    'availableSince',
  };
}

/// Maximum supported video quality of the streaming option.
class StreamingOptionQualityEnum {
  /// Instantiate a new enum with the provided [value].
  const StreamingOptionQualityEnum._(this.value);

  /// The underlying value of this enum member.
  final String value;

  @override
  String toString() => value;

  String toJson() => value;

  static const sd = StreamingOptionQualityEnum._(r'sd');
  static const hd = StreamingOptionQualityEnum._(r'hd');
  static const qhd = StreamingOptionQualityEnum._(r'qhd');
  static const uhd = StreamingOptionQualityEnum._(r'uhd');

  /// List of all possible values in this [enum][StreamingOptionQualityEnum].
  static const values = <StreamingOptionQualityEnum>[
    sd,
    hd,
    qhd,
    uhd,
  ];

  static StreamingOptionQualityEnum? fromJson(dynamic value) => StreamingOptionQualityEnumTypeTransformer().decode(value);

  static List<StreamingOptionQualityEnum> listFromJson(dynamic json, {bool growable = false,}) {
    final result = <StreamingOptionQualityEnum>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = StreamingOptionQualityEnum.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }
}

/// Transformation class that can [encode] an instance of [StreamingOptionQualityEnum] to String,
/// and [decode] dynamic data back to [StreamingOptionQualityEnum].
class StreamingOptionQualityEnumTypeTransformer {
  factory StreamingOptionQualityEnumTypeTransformer() => _instance ??= const StreamingOptionQualityEnumTypeTransformer._();

  const StreamingOptionQualityEnumTypeTransformer._();

  String encode(StreamingOptionQualityEnum data) => data.value;

  /// Decodes a [dynamic value][data] to a StreamingOptionQualityEnum.
  ///
  /// If [allowNull] is true and the [dynamic value][data] cannot be decoded successfully,
  /// then null is returned. However, if [allowNull] is false and the [dynamic value][data]
  /// cannot be decoded successfully, then an [UnimplementedError] is thrown.
  ///
  /// The [allowNull] is very handy when an API changes and a new enum value is added or removed,
  /// and users are still using an old app with the old code.
  StreamingOptionQualityEnum? decode(dynamic data, {bool allowNull = true}) {
    if (data != null) {
      switch (data) {
        case r'sd': return StreamingOptionQualityEnum.sd;
        case r'hd': return StreamingOptionQualityEnum.hd;
        case r'qhd': return StreamingOptionQualityEnum.qhd;
        case r'uhd': return StreamingOptionQualityEnum.uhd;
        default:
          if (!allowNull) {
            throw ArgumentError('Unknown enum value to decode: $data');
          }
      }
    }
    return null;
  }

  /// Singleton [StreamingOptionQualityEnumTypeTransformer] instance.
  static StreamingOptionQualityEnumTypeTransformer? _instance;
}


