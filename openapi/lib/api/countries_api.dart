//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.18

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;


class CountriesApi {
  CountriesApi([ApiClient? apiClient]) : apiClient = apiClient ?? defaultApiClient;

  final ApiClient apiClient;

  /// Get all Countries
  ///
  /// Get all the supported countries and the list of the supported services and their details for each country.  Details of services include names, logos, supported streaming types (subscription, rent, buy, free etc.) and list of available addons/channels. 
  ///
  /// Note: This method returns the HTTP [Response].
  ///
  /// Parameters:
  ///
  /// * [String] outputLanguage:
  ///   [ISO 639-1 code](https://en.wikipedia.org/wiki/ISO_639-1) of the output language. Determines in which language the output  will be in. 
  Future<Response> getCountriesWithHttpInfo({ String? outputLanguage, }) async {
    // ignore: prefer_const_declarations
    final path = r'/countries';

    // ignore: prefer_final_locals
    Object? postBody;

    final queryParams = <QueryParam>[];
    final headerParams = <String, String>{};
    final formParams = <String, String>{};

    if (outputLanguage != null) {
      queryParams.addAll(_queryParams('', 'output_language', outputLanguage));
    }

    const contentTypes = <String>[];


    return apiClient.invokeAPI(
      path,
      'GET',
      queryParams,
      postBody,
      headerParams,
      formParams,
      contentTypes.isEmpty ? null : contentTypes.first,
    );
  }

  /// Get all Countries
  ///
  /// Get all the supported countries and the list of the supported services and their details for each country.  Details of services include names, logos, supported streaming types (subscription, rent, buy, free etc.) and list of available addons/channels. 
  ///
  /// Parameters:
  ///
  /// * [String] outputLanguage:
  ///   [ISO 639-1 code](https://en.wikipedia.org/wiki/ISO_639-1) of the output language. Determines in which language the output  will be in. 
  Future<Map<String, Country>?> getCountries({ String? outputLanguage, }) async {
    final response = await getCountriesWithHttpInfo( outputLanguage: outputLanguage, );
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
    // When a remote server returns no body with a status of 204, we shall not decode it.
    // At the time of writing this, `dart:convert` will throw an "Unexpected end of input"
    // FormatException when trying to decode an empty string.
    if (response.body.isNotEmpty && response.statusCode != HttpStatus.noContent) {
      return Map<String, Country>.from(await apiClient.deserializeAsync(await _decodeBodyBytes(response), 'Map<String, Country>'),);

    }
    return null;
  }

  /// Get a Country
  ///
  /// Get a country and the list of the supported services and their details.  Details of services include names, logos, supported streaming types (subscription, rent, buy, free etc.) and list of available addons/channels. 
  ///
  /// Note: This method returns the HTTP [Response].
  ///
  /// Parameters:
  ///
  /// * [String] countryCode (required):
  ///   [ISO 3166-1 alpha-2 code](https://en.wikipedia.org/wiki/ISO_3166-1_alpha-2) of the country. 
  ///
  /// * [String] outputLanguage:
  ///   [ISO 639-1 code](https://en.wikipedia.org/wiki/ISO_639-1) of the output language. Determines in which language the output  will be in. 
  Future<Response> getCountryWithHttpInfo(String countryCode, { String? outputLanguage, }) async {
    // ignore: prefer_const_declarations
    final path = r'/countries/{country-code}'
      .replaceAll('{country-code}', countryCode);

    // ignore: prefer_final_locals
    Object? postBody;

    final queryParams = <QueryParam>[];
    final headerParams = <String, String>{};
    final formParams = <String, String>{};

    if (outputLanguage != null) {
      queryParams.addAll(_queryParams('', 'output_language', outputLanguage));
    }

    const contentTypes = <String>[];


    return apiClient.invokeAPI(
      path,
      'GET',
      queryParams,
      postBody,
      headerParams,
      formParams,
      contentTypes.isEmpty ? null : contentTypes.first,
    );
  }

  /// Get a Country
  ///
  /// Get a country and the list of the supported services and their details.  Details of services include names, logos, supported streaming types (subscription, rent, buy, free etc.) and list of available addons/channels. 
  ///
  /// Parameters:
  ///
  /// * [String] countryCode (required):
  ///   [ISO 3166-1 alpha-2 code](https://en.wikipedia.org/wiki/ISO_3166-1_alpha-2) of the country. 
  ///
  /// * [String] outputLanguage:
  ///   [ISO 639-1 code](https://en.wikipedia.org/wiki/ISO_639-1) of the output language. Determines in which language the output  will be in. 
  Future<Country?> getCountry(String countryCode, { String? outputLanguage, }) async {
    final response = await getCountryWithHttpInfo(countryCode,  outputLanguage: outputLanguage, );
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
    // When a remote server returns no body with a status of 204, we shall not decode it.
    // At the time of writing this, `dart:convert` will throw an "Unexpected end of input"
    // FormatException when trying to decode an empty string.
    if (response.body.isNotEmpty && response.statusCode != HttpStatus.noContent) {
      return await apiClient.deserializeAsync(await _decodeBodyBytes(response), 'Country',) as Country;
    
    }
    return null;
  }
}
