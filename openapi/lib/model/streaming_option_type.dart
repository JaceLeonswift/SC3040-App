//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.18

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;

/// Type of the streaming option.
class StreamingOptionType {
  /// Instantiate a new enum with the provided [value].
  const StreamingOptionType._(this.value);

  /// The underlying value of this enum member.
  final String value;

  @override
  String toString() => value;

  String toJson() => value;

  static const free = StreamingOptionType._(r'free');
  static const subscription = StreamingOptionType._(r'subscription');
  static const buy = StreamingOptionType._(r'buy');
  static const rent = StreamingOptionType._(r'rent');
  static const addon = StreamingOptionType._(r'addon');

  /// List of all possible values in this [enum][StreamingOptionType].
  static const values = <StreamingOptionType>[
    free,
    subscription,
    buy,
    rent,
    addon,
  ];

  static StreamingOptionType? fromJson(dynamic value) => StreamingOptionTypeTypeTransformer().decode(value);

  static List<StreamingOptionType> listFromJson(dynamic json, {bool growable = false,}) {
    final result = <StreamingOptionType>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = StreamingOptionType.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }
}

/// Transformation class that can [encode] an instance of [StreamingOptionType] to String,
/// and [decode] dynamic data back to [StreamingOptionType].
class StreamingOptionTypeTypeTransformer {
  factory StreamingOptionTypeTypeTransformer() => _instance ??= const StreamingOptionTypeTypeTransformer._();

  const StreamingOptionTypeTypeTransformer._();

  String encode(StreamingOptionType data) => data.value;

  /// Decodes a [dynamic value][data] to a StreamingOptionType.
  ///
  /// If [allowNull] is true and the [dynamic value][data] cannot be decoded successfully,
  /// then null is returned. However, if [allowNull] is false and the [dynamic value][data]
  /// cannot be decoded successfully, then an [UnimplementedError] is thrown.
  ///
  /// The [allowNull] is very handy when an API changes and a new enum value is added or removed,
  /// and users are still using an old app with the old code.
  StreamingOptionType? decode(dynamic data, {bool allowNull = true}) {
    if (data != null) {
      switch (data) {
        case r'free': return StreamingOptionType.free;
        case r'subscription': return StreamingOptionType.subscription;
        case r'buy': return StreamingOptionType.buy;
        case r'rent': return StreamingOptionType.rent;
        case r'addon': return StreamingOptionType.addon;
        default:
          if (!allowNull) {
            throw ArgumentError('Unknown enum value to decode: $data');
          }
      }
    }
    return null;
  }

  /// Singleton [StreamingOptionTypeTypeTransformer] instance.
  static StreamingOptionTypeTypeTransformer? _instance;
}

