//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.18

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;


class ShowsApi {
  ShowsApi([ApiClient? apiClient]) : apiClient = apiClient ?? defaultApiClient;

  final ApiClient apiClient;

  /// Get a Show
  ///
  /// Get the details of a show via id, imdbId or tmdbId, including the global streaming availability info.
  ///
  /// Note: This method returns the HTTP [Response].
  ///
  /// Parameters:
  ///
  /// * [String] id (required):
  ///   id of the show. You can also pass an IMDb Id or a TMDB Id as an id. The endpoint will automatically detect the type of the id and fetch the show accordingly.  When passing an IMDb Id, it should be in the format of tt<numerical_id>. (e.g. tt0120338 for Titanic)  When passing a TMDB Id, it should be in the format of movie/<numerical_id> for movies and tv/<numerical_id> for series. (e.g. tv/1396 for Breaking Bad and movie/597 for Titanic) 
  ///
  /// * [String] country:
  ///   [ISO 3166-1 alpha-2](https://en.wikipedia.org/wiki/ISO_3166-1_alpha-2) code of the optional target country. If this parameter is not supplied, global streaming availability across all the countries will be returned. If it is supplied, only the streaming availability info from the given country will be returned. If you are only interested in the streaming availability in a single country, then it is recommended to use this parameter to reduce the size of the response and increase the performance of the endpoint. See /countries endpoint to get the list of supported countries. 
  ///
  /// * [String] seriesGranularity:
  ///   series_granularity determines the level of detail for series. It does not affect movies.  If series_granularity is show, then the output will not include season and episode info.  If series_granularity is season, then the output will include season info but not episode info.  If series_granularity is episode, then the output will include season and episode info.  If you do not need season and episode info, then it is recommended to set series_granularity as show to reduce the size of the response and increase the performance of the endpoint.  If you need deep links for individual seasons and episodes, then you should set series_granularity as episode. In this case response will include full streaming info for seasons and episodes, similar to the streaming info for movies and series; including deep links into seasons and episodes, individual subtitle/audio and video quality info etc. 
  ///
  /// * [String] outputLanguage:
  ///   [ISO 639-1 code](https://en.wikipedia.org/wiki/ISO_639-1) of the output language. Determines in which language the output  will be in. 
  Future<Response> getShowWithHttpInfo(String id, { String? country, String? seriesGranularity, String? outputLanguage, }) async {
    // ignore: prefer_const_declarations
    final path = r'/shows/{id}'
      .replaceAll('{id}', id);

    // ignore: prefer_final_locals
    Object? postBody;

    final queryParams = <QueryParam>[];
    final headerParams = <String, String>{};
    final formParams = <String, String>{};

    if (country != null) {
      queryParams.addAll(_queryParams('', 'country', country));
    }
    if (seriesGranularity != null) {
      queryParams.addAll(_queryParams('', 'series_granularity', seriesGranularity));
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

  /// Get a Show
  ///
  /// Get the details of a show via id, imdbId or tmdbId, including the global streaming availability info.
  ///
  /// Parameters:
  ///
  /// * [String] id (required):
  ///   id of the show. You can also pass an IMDb Id or a TMDB Id as an id. The endpoint will automatically detect the type of the id and fetch the show accordingly.  When passing an IMDb Id, it should be in the format of tt<numerical_id>. (e.g. tt0120338 for Titanic)  When passing a TMDB Id, it should be in the format of movie/<numerical_id> for movies and tv/<numerical_id> for series. (e.g. tv/1396 for Breaking Bad and movie/597 for Titanic) 
  ///
  /// * [String] country:
  ///   [ISO 3166-1 alpha-2](https://en.wikipedia.org/wiki/ISO_3166-1_alpha-2) code of the optional target country. If this parameter is not supplied, global streaming availability across all the countries will be returned. If it is supplied, only the streaming availability info from the given country will be returned. If you are only interested in the streaming availability in a single country, then it is recommended to use this parameter to reduce the size of the response and increase the performance of the endpoint. See /countries endpoint to get the list of supported countries. 
  ///
  /// * [String] seriesGranularity:
  ///   series_granularity determines the level of detail for series. It does not affect movies.  If series_granularity is show, then the output will not include season and episode info.  If series_granularity is season, then the output will include season info but not episode info.  If series_granularity is episode, then the output will include season and episode info.  If you do not need season and episode info, then it is recommended to set series_granularity as show to reduce the size of the response and increase the performance of the endpoint.  If you need deep links for individual seasons and episodes, then you should set series_granularity as episode. In this case response will include full streaming info for seasons and episodes, similar to the streaming info for movies and series; including deep links into seasons and episodes, individual subtitle/audio and video quality info etc. 
  ///
  /// * [String] outputLanguage:
  ///   [ISO 639-1 code](https://en.wikipedia.org/wiki/ISO_639-1) of the output language. Determines in which language the output  will be in. 
  Future<ModelShow?> getShow(String id, { String? country, String? seriesGranularity, String? outputLanguage, }) async {
    final response = await getShowWithHttpInfo(id,  country: country, seriesGranularity: seriesGranularity, outputLanguage: outputLanguage, );
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
    // When a remote server returns no body with a status of 204, we shall not decode it.
    // At the time of writing this, `dart:convert` will throw an "Unexpected end of input"
    // FormatException when trying to decode an empty string.
    if (response.body.isNotEmpty && response.statusCode != HttpStatus.noContent) {
      return await apiClient.deserializeAsync(await _decodeBodyBytes(response), 'ModelShow',) as ModelShow;
    
    }
    return null;
  }

  /// Get Top Shows
  ///
  /// Get the official top shows in a service. Top shows are determined by the streaming service itself.  Supported streaming services are: - Netflix: netflix - Amazon Prime Video: prime - Apple TV: apple - Max: hbo  For unsupported services, this endpoint will return an empty list.  Series granularity is always show for this endpoint, meaning that the output will not include season and episode info. 
  ///
  /// Note: This method returns the HTTP [Response].
  ///
  /// Parameters:
  ///
  /// * [String] country (required):
  ///   [ISO 3166-1 alpha-2](https://en.wikipedia.org/wiki/ISO_3166-1_alpha-2) code of the target country. See /countries endpoint to get the list of supported countries. 
  ///
  /// * [String] service (required):
  ///   Id of the target service. 
  ///
  /// * [String] outputLanguage:
  ///   [ISO 639-1 code](https://en.wikipedia.org/wiki/ISO_639-1) of the output language. Determines in which language the output  will be in. 
  ///
  /// * [ShowType] showType:
  ///   Type of shows to search in. If not supplied, both movies and series will be included in the search results. 
  Future<Response> getTopShowsWithHttpInfo(String country, String service, { String? outputLanguage, ShowType? showType, }) async {
    // ignore: prefer_const_declarations
    final path = r'/shows/top';

    // ignore: prefer_final_locals
    Object? postBody;

    final queryParams = <QueryParam>[];
    final headerParams = <String, String>{};
    final formParams = <String, String>{};

      queryParams.addAll(_queryParams('', 'country', country));
      queryParams.addAll(_queryParams('', 'service', service));
    if (outputLanguage != null) {
      queryParams.addAll(_queryParams('', 'output_language', outputLanguage));
    }
    if (showType != null) {
      queryParams.addAll(_queryParams('', 'show_type', showType));
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

  /// Get Top Shows
  ///
  /// Get the official top shows in a service. Top shows are determined by the streaming service itself.  Supported streaming services are: - Netflix: netflix - Amazon Prime Video: prime - Apple TV: apple - Max: hbo  For unsupported services, this endpoint will return an empty list.  Series granularity is always show for this endpoint, meaning that the output will not include season and episode info. 
  ///
  /// Parameters:
  ///
  /// * [String] country (required):
  ///   [ISO 3166-1 alpha-2](https://en.wikipedia.org/wiki/ISO_3166-1_alpha-2) code of the target country. See /countries endpoint to get the list of supported countries. 
  ///
  /// * [String] service (required):
  ///   Id of the target service. 
  ///
  /// * [String] outputLanguage:
  ///   [ISO 639-1 code](https://en.wikipedia.org/wiki/ISO_639-1) of the output language. Determines in which language the output  will be in. 
  ///
  /// * [ShowType] showType:
  ///   Type of shows to search in. If not supplied, both movies and series will be included in the search results. 
  Future<List<ModelShow>?> getTopShows(String country, String service, { String? outputLanguage, ShowType? showType, }) async {
    final response = await getTopShowsWithHttpInfo(country, service,  outputLanguage: outputLanguage, showType: showType, );
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
    // When a remote server returns no body with a status of 204, we shall not decode it.
    // At the time of writing this, `dart:convert` will throw an "Unexpected end of input"
    // FormatException when trying to decode an empty string.
    if (response.body.isNotEmpty && response.statusCode != HttpStatus.noContent) {
      final responseBody = await _decodeBodyBytes(response);
      return (await apiClient.deserializeAsync(responseBody, 'List<ModelShow>') as List)
        .cast<ModelShow>()
        .toList(growable: false);

    }
    return null;
  }

  /// Search Shows by filters
  ///
  /// Search through the catalog of the given streaming services in the given country. Provides filters such as show language, genres, keyword and release year. Output includes all the information about the shows, such as title, IMDb ID, TMDb ID, release year, deep links to streaming services, available subtitles, audios, available video quality and many more! Apart from the info about the given country-service combinations, output also includes information about streaming availability in the other services for the given country. Streaming availability info from the other countries are not included in the response.  When show_type is movie or series_granularity is show, items per page is 20. When show_type is series and series_granularity is episode items per page is 10. Otherwise, items per page is 15. 
  ///
  /// Note: This method returns the HTTP [Response].
  ///
  /// Parameters:
  ///
  /// * [String] country (required):
  ///   [ISO 3166-1 alpha-2](https://en.wikipedia.org/wiki/ISO_3166-1_alpha-2) code of the target country. See /countries endpoint to get the list of supported countries. 
  ///
  /// * [List<String>] catalogs:
  ///   A comma separated list of up to 32 catalogs to search in. See /countries endpoint to get the supported services in each country and their ids.  When multiple catalogs are passed as a comma separated list, any show that is in at least one of the catalogs will be included in the result.  If no catalogs are passed, the endpoint will search in all the available catalogs in the country.  Syntax of the catalogs supplied in the list can be as the followings:  - <sevice_id>: Searches in the entire catalog of that service, including (if applicable) rentable, buyable shows or shows available through addons e.g. netflix, prime, apple  - <sevice_id>.<streaming_option_type>: Only returns the shows that are available in that service with the given streaming option type. Valid streaming option types are subscription, free, rent, buy and addon e.g. peacock.free only returns the shows on Peacock that are free to watch, prime.subscription only returns the shows on Prime Video that are available to watch with a Prime subscription. hulu.addon only returns the shows on Hulu that are available via an addon, prime.rent only returns the shows on Prime Video that are rentable.  - <sevice_id>.addon.<addon_id>: Only returns the shows that are available in that service with the given addon. Check /countries endpoint to fetch the available addons for a service in each country. Some sample values are: hulu.addon.hbo, prime.addon.hbomaxus. 
  ///
  /// * [String] outputLanguage:
  ///   [ISO 639-1 code](https://en.wikipedia.org/wiki/ISO_639-1) of the output language. Determines in which language the output  will be in. 
  ///
  /// * [ShowType] showType:
  ///   Type of shows to search in. If not supplied, both movies and series will be included in the search results. 
  ///
  /// * [List<String>] genres:
  ///   A comma seperated list of genre ids to only search within the shows in those genre. See /genres endpoint to see the available genres and their ids. Use genres_relation parameter to specify between returning shows that have at least one of the given genres or returning shows that have all of the given genres. 
  ///
  /// * [String] genresRelation:
  ///   Only used when there are multiple genres supplied in genres parameter.  When or, the endpoint returns any show that has at least one of the given genres. When and, it only returns the shows that have all of the given genres. 
  ///
  /// * [String] showOriginalLanguage:
  ///   [ISO 639-1](https://en.wikipedia.org/wiki/ISO_639-1) language code to only search within the shows whose original language matches with the provided language. 
  ///
  /// * [int] yearMin:
  ///   Minimum release/air year of the shows.
  ///
  /// * [int] yearMax:
  ///   Maximum release/air year of the shows.
  ///
  /// * [int] ratingMin:
  ///   Minimum rating of the shows.
  ///
  /// * [int] ratingMax:
  ///   Maximum rating of the shows.
  ///
  /// * [String] keyword:
  ///   A keyword to only search within the shows have that keyword in their overview or title.
  ///
  /// * [String] seriesGranularity:
  ///   series_granularity determines the level of detail for series. It does not affect movies.  If series_granularity is show, then the output will not include season and episode info.  If series_granularity is season, then the output will include season info but not episode info.  If series_granularity is episode, then the output will include season and episode info.  If you do not need season and episode info, then it is recommended to set series_granularity as show to reduce the size of the response and increase the performance of the endpoint.  If you need deep links for individual seasons and episodes, then you should set series_granularity as episode. In this case response will include full streaming info for seasons and episodes, similar to the streaming info for movies and series; including deep links into seasons and episodes, individual subtitle/audio and video quality info etc. 
  ///
  /// * [String] orderBy:
  ///   Determines the ordering of the shows. Make sure to set descending_order parameter as true when ordering by popularity or rating so that shows with the highest popularity or rating will be returned first. 
  ///
  /// * [OrderDirection] orderDirection:
  ///   Determines whether to order the results in ascending or descending order.  Default value when ordering alphabetically or based on dates/times is asc.  Default value when ordering by rating or popularity is desc. 
  ///
  /// * [String] cursor:
  ///   Cursor is used for pagination. After each request, the response includes a hasMore boolean field to tell if there are more results that did not fit into the returned list. If it is set as true, to get the rest of the result set, send a new request (with the same parameters for other fields), and set the cursor parameter as the nextCursor value of the response of the previous request. Do not forget to escape the cursor value before putting it into a query as it might contain characters such as ?and &.  The first request naturally does not require a cursor parameter. 
  Future<Response> searchShowsByFiltersWithHttpInfo(String country, { List<String>? catalogs, String? outputLanguage, ShowType? showType, List<String>? genres, String? genresRelation, String? showOriginalLanguage, int? yearMin, int? yearMax, int? ratingMin, int? ratingMax, String? keyword, String? seriesGranularity, String? orderBy, OrderDirection? orderDirection, String? cursor, }) async {
    // ignore: prefer_const_declarations
    final path = r'/shows/search/filters';

    // ignore: prefer_final_locals
    Object? postBody;

    final queryParams = <QueryParam>[];
    final headerParams = <String, String>{};
    final formParams = <String, String>{};

      queryParams.addAll(_queryParams('', 'country', country));
    if (catalogs != null) {
      queryParams.addAll(_queryParams('csv', 'catalogs', catalogs));
    }
    if (outputLanguage != null) {
      queryParams.addAll(_queryParams('', 'output_language', outputLanguage));
    }
    if (showType != null) {
      queryParams.addAll(_queryParams('', 'show_type', showType));
    }
    if (genres != null) {
      queryParams.addAll(_queryParams('csv', 'genres', genres));
    }
    if (genresRelation != null) {
      queryParams.addAll(_queryParams('', 'genres_relation', genresRelation));
    }
    if (showOriginalLanguage != null) {
      queryParams.addAll(_queryParams('', 'show_original_language', showOriginalLanguage));
    }
    if (yearMin != null) {
      queryParams.addAll(_queryParams('', 'year_min', yearMin));
    }
    if (yearMax != null) {
      queryParams.addAll(_queryParams('', 'year_max', yearMax));
    }
    if (ratingMin != null) {
      queryParams.addAll(_queryParams('', 'rating_min', ratingMin));
    }
    if (ratingMax != null) {
      queryParams.addAll(_queryParams('', 'rating_max', ratingMax));
    }
    if (keyword != null) {
      queryParams.addAll(_queryParams('', 'keyword', keyword));
    }
    if (seriesGranularity != null) {
      queryParams.addAll(_queryParams('', 'series_granularity', seriesGranularity));
    }
    if (orderBy != null) {
      queryParams.addAll(_queryParams('', 'order_by', orderBy));
    }
    if (orderDirection != null) {
      queryParams.addAll(_queryParams('', 'order_direction', orderDirection));
    }
    if (cursor != null) {
      queryParams.addAll(_queryParams('', 'cursor', cursor));
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

  /// Search Shows by filters
  ///
  /// Search through the catalog of the given streaming services in the given country. Provides filters such as show language, genres, keyword and release year. Output includes all the information about the shows, such as title, IMDb ID, TMDb ID, release year, deep links to streaming services, available subtitles, audios, available video quality and many more! Apart from the info about the given country-service combinations, output also includes information about streaming availability in the other services for the given country. Streaming availability info from the other countries are not included in the response.  When show_type is movie or series_granularity is show, items per page is 20. When show_type is series and series_granularity is episode items per page is 10. Otherwise, items per page is 15. 
  ///
  /// Parameters:
  ///
  /// * [String] country (required):
  ///   [ISO 3166-1 alpha-2](https://en.wikipedia.org/wiki/ISO_3166-1_alpha-2) code of the target country. See /countries endpoint to get the list of supported countries. 
  ///
  /// * [List<String>] catalogs:
  ///   A comma separated list of up to 32 catalogs to search in. See /countries endpoint to get the supported services in each country and their ids.  When multiple catalogs are passed as a comma separated list, any show that is in at least one of the catalogs will be included in the result.  If no catalogs are passed, the endpoint will search in all the available catalogs in the country.  Syntax of the catalogs supplied in the list can be as the followings:  - <sevice_id>: Searches in the entire catalog of that service, including (if applicable) rentable, buyable shows or shows available through addons e.g. netflix, prime, apple  - <sevice_id>.<streaming_option_type>: Only returns the shows that are available in that service with the given streaming option type. Valid streaming option types are subscription, free, rent, buy and addon e.g. peacock.free only returns the shows on Peacock that are free to watch, prime.subscription only returns the shows on Prime Video that are available to watch with a Prime subscription. hulu.addon only returns the shows on Hulu that are available via an addon, prime.rent only returns the shows on Prime Video that are rentable.  - <sevice_id>.addon.<addon_id>: Only returns the shows that are available in that service with the given addon. Check /countries endpoint to fetch the available addons for a service in each country. Some sample values are: hulu.addon.hbo, prime.addon.hbomaxus. 
  ///
  /// * [String] outputLanguage:
  ///   [ISO 639-1 code](https://en.wikipedia.org/wiki/ISO_639-1) of the output language. Determines in which language the output  will be in. 
  ///
  /// * [ShowType] showType:
  ///   Type of shows to search in. If not supplied, both movies and series will be included in the search results. 
  ///
  /// * [List<String>] genres:
  ///   A comma seperated list of genre ids to only search within the shows in those genre. See /genres endpoint to see the available genres and their ids. Use genres_relation parameter to specify between returning shows that have at least one of the given genres or returning shows that have all of the given genres. 
  ///
  /// * [String] genresRelation:
  ///   Only used when there are multiple genres supplied in genres parameter.  When or, the endpoint returns any show that has at least one of the given genres. When and, it only returns the shows that have all of the given genres. 
  ///
  /// * [String] showOriginalLanguage:
  ///   [ISO 639-1](https://en.wikipedia.org/wiki/ISO_639-1) language code to only search within the shows whose original language matches with the provided language. 
  ///
  /// * [int] yearMin:
  ///   Minimum release/air year of the shows.
  ///
  /// * [int] yearMax:
  ///   Maximum release/air year of the shows.
  ///
  /// * [int] ratingMin:
  ///   Minimum rating of the shows.
  ///
  /// * [int] ratingMax:
  ///   Maximum rating of the shows.
  ///
  /// * [String] keyword:
  ///   A keyword to only search within the shows have that keyword in their overview or title.
  ///
  /// * [String] seriesGranularity:
  ///   series_granularity determines the level of detail for series. It does not affect movies.  If series_granularity is show, then the output will not include season and episode info.  If series_granularity is season, then the output will include season info but not episode info.  If series_granularity is episode, then the output will include season and episode info.  If you do not need season and episode info, then it is recommended to set series_granularity as show to reduce the size of the response and increase the performance of the endpoint.  If you need deep links for individual seasons and episodes, then you should set series_granularity as episode. In this case response will include full streaming info for seasons and episodes, similar to the streaming info for movies and series; including deep links into seasons and episodes, individual subtitle/audio and video quality info etc. 
  ///
  /// * [String] orderBy:
  ///   Determines the ordering of the shows. Make sure to set descending_order parameter as true when ordering by popularity or rating so that shows with the highest popularity or rating will be returned first. 
  ///
  /// * [OrderDirection] orderDirection:
  ///   Determines whether to order the results in ascending or descending order.  Default value when ordering alphabetically or based on dates/times is asc.  Default value when ordering by rating or popularity is desc. 
  ///
  /// * [String] cursor:
  ///   Cursor is used for pagination. After each request, the response includes a hasMore boolean field to tell if there are more results that did not fit into the returned list. If it is set as true, to get the rest of the result set, send a new request (with the same parameters for other fields), and set the cursor parameter as the nextCursor value of the response of the previous request. Do not forget to escape the cursor value before putting it into a query as it might contain characters such as ?and &.  The first request naturally does not require a cursor parameter. 
  Future<SearchResult?> searchShowsByFilters(String country, { List<String>? catalogs, String? outputLanguage, ShowType? showType, List<String>? genres, String? genresRelation, String? showOriginalLanguage, int? yearMin, int? yearMax, int? ratingMin, int? ratingMax, String? keyword, String? seriesGranularity, String? orderBy, OrderDirection? orderDirection, String? cursor, }) async {
    final response = await searchShowsByFiltersWithHttpInfo(country,  catalogs: catalogs, outputLanguage: outputLanguage, showType: showType, genres: genres, genresRelation: genresRelation, showOriginalLanguage: showOriginalLanguage, yearMin: yearMin, yearMax: yearMax, ratingMin: ratingMin, ratingMax: ratingMax, keyword: keyword, seriesGranularity: seriesGranularity, orderBy: orderBy, orderDirection: orderDirection, cursor: cursor, );
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
    // When a remote server returns no body with a status of 204, we shall not decode it.
    // At the time of writing this, `dart:convert` will throw an "Unexpected end of input"
    // FormatException when trying to decode an empty string.
    if (response.body.isNotEmpty && response.statusCode != HttpStatus.noContent) {
      return await apiClient.deserializeAsync(await _decodeBodyBytes(response), 'SearchResult',) as SearchResult;
    
    }
    return null;
  }

  /// Search Shows by title
  ///
  /// Search for movies and series by a title. Maximum amount of items returned are 20 unless there are more than 20 shows with the exact given title input. In that case all the items have 100% match with the title will be returned.  Streaming availability info for the target country is included in the response, but not for the other countries.  Results might include shows that are not streamable in the target country. Only criteria for the search are the title and the show type.  No pagination is supported. 
  ///
  /// Note: This method returns the HTTP [Response].
  ///
  /// Parameters:
  ///
  /// * [String] title (required):
  ///   Title phrase to search for.
  ///
  /// * [String] country (required):
  ///   [ISO 3166-1 alpha-2](https://en.wikipedia.org/wiki/ISO_3166-1_alpha-2) code of the target country. See /countries endpoint to get the list of supported countries. 
  ///
  /// * [ShowType] showType:
  ///   Type of shows to search in. If not supplied, both movies and series will be included in the search results. 
  ///
  /// * [String] seriesGranularity:
  ///   series_granularity determines the level of detail for series. It does not affect movies.  If series_granularity is show, then the output will not include season and episode info.  If series_granularity is season, then the output will include season info but not episode info.  If series_granularity is episode, then the output will include season and episode info.  If you do not need season and episode info, then it is recommended to set series_granularity as show to reduce the size of the response and increase the performance of the endpoint.  If you need deep links for individual seasons and episodes, then you should set series_granularity as episode. In this case response will include full streaming info for seasons and episodes, similar to the streaming info for movies and series; including deep links into seasons and episodes, individual subtitle/audio and video quality info etc. 
  ///
  /// * [String] outputLanguage:
  ///   [ISO 639-1 code](https://en.wikipedia.org/wiki/ISO_639-1) of the output language. Determines in which language the output  will be in. 
  Future<Response> searchShowsByTitleWithHttpInfo(String title, String country, { ShowType? showType, String? seriesGranularity, String? outputLanguage, }) async {
    // ignore: prefer_const_declarations
    final path = r'/shows/search/title';

    // ignore: prefer_final_locals
    Object? postBody;

    final queryParams = <QueryParam>[];
    final headerParams = <String, String>{};
    final formParams = <String, String>{};

      queryParams.addAll(_queryParams('', 'title', title));
    if (showType != null) {
      queryParams.addAll(_queryParams('', 'show_type', showType));
    }
      queryParams.addAll(_queryParams('', 'country', country));
    if (seriesGranularity != null) {
      queryParams.addAll(_queryParams('', 'series_granularity', seriesGranularity));
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

  /// Search Shows by title
  ///
  /// Search for movies and series by a title. Maximum amount of items returned are 20 unless there are more than 20 shows with the exact given title input. In that case all the items have 100% match with the title will be returned.  Streaming availability info for the target country is included in the response, but not for the other countries.  Results might include shows that are not streamable in the target country. Only criteria for the search are the title and the show type.  No pagination is supported. 
  ///
  /// Parameters:
  ///
  /// * [String] title (required):
  ///   Title phrase to search for.
  ///
  /// * [String] country (required):
  ///   [ISO 3166-1 alpha-2](https://en.wikipedia.org/wiki/ISO_3166-1_alpha-2) code of the target country. See /countries endpoint to get the list of supported countries. 
  ///
  /// * [ShowType] showType:
  ///   Type of shows to search in. If not supplied, both movies and series will be included in the search results. 
  ///
  /// * [String] seriesGranularity:
  ///   series_granularity determines the level of detail for series. It does not affect movies.  If series_granularity is show, then the output will not include season and episode info.  If series_granularity is season, then the output will include season info but not episode info.  If series_granularity is episode, then the output will include season and episode info.  If you do not need season and episode info, then it is recommended to set series_granularity as show to reduce the size of the response and increase the performance of the endpoint.  If you need deep links for individual seasons and episodes, then you should set series_granularity as episode. In this case response will include full streaming info for seasons and episodes, similar to the streaming info for movies and series; including deep links into seasons and episodes, individual subtitle/audio and video quality info etc. 
  ///
  /// * [String] outputLanguage:
  ///   [ISO 639-1 code](https://en.wikipedia.org/wiki/ISO_639-1) of the output language. Determines in which language the output  will be in. 
  Future<List<ModelShow>?> searchShowsByTitle(String title, String country, { ShowType? showType, String? seriesGranularity, String? outputLanguage, }) async {
    final response = await searchShowsByTitleWithHttpInfo(title, country,  showType: showType, seriesGranularity: seriesGranularity, outputLanguage: outputLanguage, );
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
    // When a remote server returns no body with a status of 204, we shall not decode it.
    // At the time of writing this, `dart:convert` will throw an "Unexpected end of input"
    // FormatException when trying to decode an empty string.
    if (response.body.isNotEmpty && response.statusCode != HttpStatus.noContent) {
      final responseBody = await _decodeBodyBytes(response);
      return (await apiClient.deserializeAsync(responseBody, 'List<ModelShow>') as List)
        .cast<ModelShow>()
        .toList(growable: false);

    }
    return null;
  }
}
