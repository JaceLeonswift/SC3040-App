//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.18

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

library openapi.api;

import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:collection/collection.dart';
import 'package:http/http.dart';
import 'package:intl/intl.dart';
import 'package:meta/meta.dart';

part 'api_client.dart';
part 'api_helper.dart';
part 'api_exception.dart';
part 'auth/authentication.dart';
part 'auth/api_key_auth.dart';
part 'auth/oauth.dart';
part 'auth/http_basic_auth.dart';
part 'auth/http_bearer_auth.dart';

part 'api/changes_api.dart';
part 'api/countries_api.dart';
part 'api/genres_api.dart';
part 'api/shows_api.dart';

part 'model/addon.dart';
part 'model/change.dart';
part 'model/change_type.dart';
part 'model/changes_result.dart';
part 'model/country.dart';
part 'model/episode.dart';
part 'model/error.dart';
part 'model/genre.dart';
part 'model/horizontal_image.dart';
part 'model/item_type.dart';
part 'model/locale.dart';
part 'model/model_show.dart';
part 'model/order_direction.dart';
part 'model/price.dart';
part 'model/search_result.dart';
part 'model/season.dart';
part 'model/service.dart';
part 'model/service_image_set.dart';
part 'model/service_info.dart';
part 'model/show_image_set.dart';
part 'model/show_type.dart';
part 'model/streaming_option.dart';
part 'model/streaming_option_type.dart';
part 'model/streaming_option_types.dart';
part 'model/subtitle.dart';
part 'model/vertical_image.dart';


/// An [ApiClient] instance that uses the default values obtained from
/// the OpenAPI specification file.
var defaultApiClient = ApiClient(authentication: ApiKeyAuth('header','X-RapidAPI-Key'));

const _delimiters = {'csv': ',', 'ssv': ' ', 'tsv': '\t', 'pipes': '|'};
const _dateEpochMarker = 'epoch';
const _deepEquality = DeepCollectionEquality();
final _dateFormatter = DateFormat('yyyy-MM-dd');
final _regList = RegExp(r'^List<(.*)>$');
final _regSet = RegExp(r'^Set<(.*)>$');
final _regMap = RegExp(r'^Map<String,(.*)>$');

bool _isEpochMarker(String? pattern) => pattern == _dateEpochMarker || pattern == '/$_dateEpochMarker/';
