//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.18

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;


class ChangesApi {
  ChangesApi([ApiClient? apiClient]) : apiClient = apiClient ?? defaultApiClient;

  final ApiClient apiClient;

  /// Get Changes
  ///
  /// Query the new, removed, updated, expiring or upcoming movies/series/seasons/episodes in a given list of streaming services. Results are ordered by the date of the changes. Changes listed per page is 25.  Changes are listed under changes field, and shows affected by these changes are listed under shows field.  Note that upcoming changes are only supported for Apple TV, Disney+, Max, Netflix and Prime Video. For other services, upcoming changes will return an empty list. 
  ///
  /// Note: This method returns the HTTP [Response].
  ///
  /// Parameters:
  ///
  /// * [String] country (required):
  ///   [ISO 3166-1 alpha-2](https://en.wikipedia.org/wiki/ISO_3166-1_alpha-2) code of the target country. See /countries endpoint to get the list of supported countries. 
  ///
  /// * [ChangeType] changeType (required):
  ///   Type of changes to query.
  ///
  /// * [ItemType] itemType (required):
  ///   Type of items to search in. If item_type is show, you can use show_type parameter to only search for movies or series. 
  ///
  /// * [List<String>] catalogs:
  ///   A comma separated list of up to 32 catalogs to search in. See /countries endpoint to get the supported services in each country and their ids.  When multiple catalogs are passed as a comma separated list, any show that is in at least one of the catalogs will be included in the result.  If no catalogs are passed, the endpoint will search in all the available catalogs in the country.  Syntax of the catalogs supplied in the list can be as the followings:  - <sevice_id>: Searches in the entire catalog of that service, including (if applicable) rentable, buyable shows or shows available through addons e.g. netflix, prime, apple  - <sevice_id>.<streaming_option_type>: Only returns the shows that are available in that service with the given streaming option type. Valid streaming option types are subscription, free, rent, buy and addon e.g. peacock.free only returns the shows on Peacock that are free to watch, prime.subscription only returns the shows on Prime Video that are available to watch with a Prime subscription. hulu.addon only returns the shows on Hulu that are available via an addon, prime.rent only returns the shows on Prime Video that are rentable.  - <sevice_id>.addon.<addon_id>: Only returns the shows that are available in that service with the given addon. Check /countries endpoint to fetch the available addons for a service in each country. Some sample values are: hulu.addon.hbo, prime.addon.hbomaxus. 
  ///
  /// * [ShowType] showType:
  ///   Type of shows to search in. If not supplied, both movies and series will be included in the search results. 
  ///
  /// * [int] from:
  ///   [Unix Time Stamp](https://www.unixtimestamp.com/) to only query the changes happened/happening after this date (inclusive). For past changes such as new, removed or updated, the timestamp must be between today and 31 days ago. For future changes such as expiring or upcoming, the timestamp must be between today and 31 days from now in the future.  If not supplied, the default value for past changes is 31 days ago, and for future changes is today. 
  ///
  /// * [int] to:
  ///   [Unix Time Stamp](https://www.unixtimestamp.com/) to only query the changes happened/happening before this date (inclusive). For past changes such as new, removed or updated, the timestamp must be between today and 31 days ago. For future changes such as expiring or upcoming, the timestamp must be between today and 31 days from now in the future.  If not supplied, the default value for past changes is today, and for future changes is 31 days from now. 
  ///
  /// * [bool] includeUnknownDates:
  ///   Whether to include the changes with unknown dates. past changes such as new, removed or updated will always have a timestamp thus this parameter does not affect them. future changes such as expiring or upcoming may not have a timestamp if the exact date is not known (e.g. some services do not explicitly state the exact date of some of the upcoming/expiring shows). If set as true, the changes with unknown dates will be included in the response. If set as false, the changes with unknown dates will be excluded from the response.  When ordering, the changes with unknown dates will be treated as if their timestamp is 0. Thus, they will appear first in the ascending order and last in the descending order. 
  ///
  /// * [String] cursor:
  ///   Cursor is used for pagination. After each request, the response includes a hasMore boolean field to tell if there are more results that did not fit into the returned list. If it is set as true, to get the rest of the result set, send a new request (with the same parameters for other fields), and set the cursor parameter as the nextCursor value of the response of the previous request. Do not forget to escape the cursor value before putting it into a query as it might contain characters such as ?and &.  The first request naturally does not require a cursor parameter. 
  ///
  /// * [OrderDirection] orderDirection:
  ///   Determines whether to order the results in ascending or descending order. 
  ///
  /// * [String] outputLanguage:
  ///   [ISO 639-1 code](https://en.wikipedia.org/wiki/ISO_639-1) of the output language. Determines in which language the output  will be in. 
  Future<Response> getChangesWithHttpInfo(String country, ChangeType changeType, ItemType itemType, { List<String>? catalogs, ShowType? showType, int? from, int? to, bool? includeUnknownDates, String? cursor, OrderDirection? orderDirection, String? outputLanguage, }) async {
    // ignore: prefer_const_declarations
    final path = r'/changes';

    // ignore: prefer_final_locals
    Object? postBody;

    final queryParams = <QueryParam>[];
    final headerParams = <String, String>{};
    final formParams = <String, String>{};

      queryParams.addAll(_queryParams('', 'country', country));
    if (catalogs != null) {
      queryParams.addAll(_queryParams('csv', 'catalogs', catalogs));
    }
      queryParams.addAll(_queryParams('', 'change_type', changeType));
      queryParams.addAll(_queryParams('', 'item_type', itemType));
    if (showType != null) {
      queryParams.addAll(_queryParams('', 'show_type', showType));
    }
    if (from != null) {
      queryParams.addAll(_queryParams('', 'from', from));
    }
    if (to != null) {
      queryParams.addAll(_queryParams('', 'to', to));
    }
    if (includeUnknownDates != null) {
      queryParams.addAll(_queryParams('', 'include_unknown_dates', includeUnknownDates));
    }
    if (cursor != null) {
      queryParams.addAll(_queryParams('', 'cursor', cursor));
    }
    if (orderDirection != null) {
      queryParams.addAll(_queryParams('', 'order_direction', orderDirection));
    }
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

  /// Get Changes
  ///
  /// Query the new, removed, updated, expiring or upcoming movies/series/seasons/episodes in a given list of streaming services. Results are ordered by the date of the changes. Changes listed per page is 25.  Changes are listed under changes field, and shows affected by these changes are listed under shows field.  Note that upcoming changes are only supported for Apple TV, Disney+, Max, Netflix and Prime Video. For other services, upcoming changes will return an empty list. 
  ///
  /// Parameters:
  ///
  /// * [String] country (required):
  ///   [ISO 3166-1 alpha-2](https://en.wikipedia.org/wiki/ISO_3166-1_alpha-2) code of the target country. See /countries endpoint to get the list of supported countries. 
  ///
  /// * [ChangeType] changeType (required):
  ///   Type of changes to query.
  ///
  /// * [ItemType] itemType (required):
  ///   Type of items to search in. If item_type is show, you can use show_type parameter to only search for movies or series. 
  ///
  /// * [List<String>] catalogs:
  ///   A comma separated list of up to 32 catalogs to search in. See /countries endpoint to get the supported services in each country and their ids.  When multiple catalogs are passed as a comma separated list, any show that is in at least one of the catalogs will be included in the result.  If no catalogs are passed, the endpoint will search in all the available catalogs in the country.  Syntax of the catalogs supplied in the list can be as the followings:  - <sevice_id>: Searches in the entire catalog of that service, including (if applicable) rentable, buyable shows or shows available through addons e.g. netflix, prime, apple  - <sevice_id>.<streaming_option_type>: Only returns the shows that are available in that service with the given streaming option type. Valid streaming option types are subscription, free, rent, buy and addon e.g. peacock.free only returns the shows on Peacock that are free to watch, prime.subscription only returns the shows on Prime Video that are available to watch with a Prime subscription. hulu.addon only returns the shows on Hulu that are available via an addon, prime.rent only returns the shows on Prime Video that are rentable.  - <sevice_id>.addon.<addon_id>: Only returns the shows that are available in that service with the given addon. Check /countries endpoint to fetch the available addons for a service in each country. Some sample values are: hulu.addon.hbo, prime.addon.hbomaxus. 
  ///
  /// * [ShowType] showType:
  ///   Type of shows to search in. If not supplied, both movies and series will be included in the search results. 
  ///
  /// * [int] from:
  ///   [Unix Time Stamp](https://www.unixtimestamp.com/) to only query the changes happened/happening after this date (inclusive). For past changes such as new, removed or updated, the timestamp must be between today and 31 days ago. For future changes such as expiring or upcoming, the timestamp must be between today and 31 days from now in the future.  If not supplied, the default value for past changes is 31 days ago, and for future changes is today. 
  ///
  /// * [int] to:
  ///   [Unix Time Stamp](https://www.unixtimestamp.com/) to only query the changes happened/happening before this date (inclusive). For past changes such as new, removed or updated, the timestamp must be between today and 31 days ago. For future changes such as expiring or upcoming, the timestamp must be between today and 31 days from now in the future.  If not supplied, the default value for past changes is today, and for future changes is 31 days from now. 
  ///
  /// * [bool] includeUnknownDates:
  ///   Whether to include the changes with unknown dates. past changes such as new, removed or updated will always have a timestamp thus this parameter does not affect them. future changes such as expiring or upcoming may not have a timestamp if the exact date is not known (e.g. some services do not explicitly state the exact date of some of the upcoming/expiring shows). If set as true, the changes with unknown dates will be included in the response. If set as false, the changes with unknown dates will be excluded from the response.  When ordering, the changes with unknown dates will be treated as if their timestamp is 0. Thus, they will appear first in the ascending order and last in the descending order. 
  ///
  /// * [String] cursor:
  ///   Cursor is used for pagination. After each request, the response includes a hasMore boolean field to tell if there are more results that did not fit into the returned list. If it is set as true, to get the rest of the result set, send a new request (with the same parameters for other fields), and set the cursor parameter as the nextCursor value of the response of the previous request. Do not forget to escape the cursor value before putting it into a query as it might contain characters such as ?and &.  The first request naturally does not require a cursor parameter. 
  ///
  /// * [OrderDirection] orderDirection:
  ///   Determines whether to order the results in ascending or descending order. 
  ///
  /// * [String] outputLanguage:
  ///   [ISO 639-1 code](https://en.wikipedia.org/wiki/ISO_639-1) of the output language. Determines in which language the output  will be in. 
  Future<ChangesResult?> getChanges(String country, ChangeType changeType, ItemType itemType, { List<String>? catalogs, ShowType? showType, int? from, int? to, bool? includeUnknownDates, String? cursor, OrderDirection? orderDirection, String? outputLanguage, }) async {
    final response = await getChangesWithHttpInfo(country, changeType, itemType,  catalogs: catalogs, showType: showType, from: from, to: to, includeUnknownDates: includeUnknownDates, cursor: cursor, orderDirection: orderDirection, outputLanguage: outputLanguage, );
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
    // When a remote server returns no body with a status of 204, we shall not decode it.
    // At the time of writing this, `dart:convert` will throw an "Unexpected end of input"
    // FormatException when trying to decode an empty string.
    if (response.body.isNotEmpty && response.statusCode != HttpStatus.noContent) {
      return await apiClient.deserializeAsync(await _decodeBodyBytes(response), 'ChangesResult',) as ChangesResult;
    
    }
    return null;
  }
}
