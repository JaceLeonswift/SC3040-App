//TESTING

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

import 'package:openapi/api.dart';

/// tests for ShowsApi
void main() async {
  (defaultApiClient.authentication as ApiKeyAuth).apiKey = 'YOUR_API_KEY';

  final api_instance = ShowsApi();
  final id =
      'tt0120338'; // String | id of the show. You can also pass an IMDb Id or a TMDB Id as an id. The endpoint will automatically detect the type of the id and fetch the show accordingly.  When passing an IMDb Id, it should be in the format of tt<numerical_id>. (e.g. tt0120338 for Titanic)  When passing a TMDB Id, it should be in the format of movie/<numerical_id> for movies and tv/<numerical_id> for series. (e.g. tv/1396 for Breaking Bad and movie/597 for Titanic)
  final country =
      'sg'; // String | [ISO 3166-1 alpha-2](https://en.wikipedia.org/wiki/ISO_3166-1_alpha-2) code of the optional target country. If this parameter is not supplied, global streaming availability across all the countries will be returned. If it is supplied, only the streaming availability info from the given country will be returned. If you are only interested in the streaming availability in a single country, then it is recommended to use this parameter to reduce the size of the response and increase the performance of the endpoint. See /countries endpoint to get the list of supported countries.
  final title = 'Bleach'; // String | Title phrase to search for.
  final seriesGranularity =
      'show'; // String | series_granularity determines the level of detail for series. It does not affect movies.  If series_granularity is show, then the output will not include season and episode info.  If series_granularity is season, then the output will include season info but not episode info.  If series_granularity is episode, then the output will include season and episode info.  If you do not need season and episode info, then it is recommended to set series_granularity as show to reduce the size of the response and increase the performance of the endpoint.  If you need deep links for individual seasons and episodes, then you should set series_granularity as episode. In this case response will include full streaming info for seasons and episodes, similar to the streaming info for movies and series; including deep links into seasons and episodes, individual subtitle/audio and video quality info etc.
  final outputLanguage =
      'en'; // String | [ISO 639-1 code](https://en.wikipedia.org/wiki/ISO_639-1) of the output language. Determines in which language the output  will be in.
  final service = 'netflix'; // String | Id of the target service.
  final showType = ShowType
      .movie; // ShowType | Type of shows to search in. If not supplied, both movies and series will be included in the search results.
  final catalogs = [
    'netflix',
    'hulu.addon.hbo',
    'prime.subscription'
  ]; // List<String> | A comma separated list of up to 32 catalogs to search in. See /countries endpoint to get the supported services in each country and their ids.  When multiple catalogs are passed as a comma separated list, any show that is in at least one of the catalogs will be included in the result.  If no catalogs are passed, the endpoint will search in all the available catalogs in the country.  Syntax of the catalogs supplied in the list can be as the followings:  - <sevice_id>: Searches in the entire catalog of that service, including (if applicable) rentable, buyable shows or shows available through addons e.g. netflix, prime, apple  - <sevice_id>.<streaming_option_type>: Only returns the shows that are available in that service with the given streaming option type. Valid streaming option types are subscription, free, rent, buy and addon e.g. peacock.free only returns the shows on Peacock that are free to watch, prime.subscription only returns the shows on Prime Video that are available to watch with a Prime subscription. hulu.addon only returns the shows on Hulu that are available via an addon, prime.rent only returns the shows on Prime Video that are rentable.  - <sevice_id>.addon.<addon_id>: Only returns the shows that are available in that service with the given addon. Check /countries endpoint to fetch the available addons for a service in each country. Some sample values are: hulu.addon.hbo, prime.addon.hbomaxus.
  final genres = [
    'action',
    'fantasy',
    'romance',
    'adventure'
  ]; // List<String> | A comma seperated list of genre ids to only search within the shows in those genre. See /genres endpoint to see the available genres and their ids. Use genres_relation parameter to specify between returning shows that have at least one of the given genres or returning shows that have all of the given genres.
  final genresRelation =
      'or'; // String | Only used when there are multiple genres supplied in genres parameter.  When or, the endpoint returns any show that has at least one of the given genres. When and, it only returns the shows that have all of the given genres.
  final showOriginalLanguage =
      'ja'; // String | [ISO 639-1](https://en.wikipedia.org/wiki/ISO_639-1) language code to only search within the shows whose original language matches with the provided language.
  final yearMin = 2000; // int | Minimum release/air year of the shows.
  final yearMax = 2023; // int | Maximum release/air year of the shows.
  final ratingMin = 60; // int | Minimum rating of the shows.
  final ratingMax = 90; // int | Maximum rating of the shows.
  final keyword =
      'bleach'; // String | A keyword to only search within the shows have that keyword in their overview or title.
  final orderBy =
      'rating'; // String | Determines the ordering of the shows. Make sure to set descending_order parameter as true when ordering by popularity or rating so that shows with the highest popularity or rating will be returned first.
  final orderDirection = OrderDirection
      .desc; // OrderDirection | Determines whether to order the results in ascending or descending order.  Default value when ordering alphabetically or based on dates/times is asc.  Default value when ordering by rating or popularity is desc.
  final cursor =
      null; // String | Cursor is used for pagination. After each request, the response includes a hasMore boolean field to tell if there are more results that did not fit into the returned list. If it is set as true, to get the rest of the result set, send a new request (with the same parameters for other fields), and set the cursor parameter as the nextCursor value of the response of the previous request. Do not forget to escape the cursor value before putting it into a query as it might contain characters such as ?and &.  The first request naturally does not require a cursor parameter.

  var result = null;
  try {
    result = await api_instance.getShow(id,
        country: country,
        seriesGranularity: seriesGranularity,
        outputLanguage: outputLanguage);
    print(result);
    print('\n');
  } catch (e) {
    print('Exception when calling ShowsApi->getShow: $e\n');
  }
  try {
    result = await api_instance.getTopShows(country, service,
        outputLanguage: outputLanguage, showType: showType);
    print(result);
    print('\n');
  } catch (e) {
    print('Exception when calling ShowsApi->getTopShows: $e\n');
  }
  try {
    result = await api_instance.searchShowsByTitle(title, country,
        showType: showType,
        seriesGranularity: seriesGranularity,
        outputLanguage: outputLanguage);
    print(result);
    print('\n');
  } catch (e) {
    print('Exception when calling ShowsApi->searchShowsByTitle: $e\n');
  }
  try {
    result = await api_instance.searchShowsByFilters(country,
        catalogs: catalogs,
        outputLanguage: outputLanguage,
        showType: showType,
        genres: genres,
        genresRelation: genresRelation,
        showOriginalLanguage: showOriginalLanguage,
        yearMin: yearMin,
        yearMax: yearMax,
        ratingMin: ratingMin,
        ratingMax: ratingMax,
        keyword: keyword,
        seriesGranularity: seriesGranularity,
        orderBy: orderBy,
        orderDirection: orderDirection,
        cursor: cursor);
    print(result);
    print('\n');
  } catch (e) {
    print('Exception when calling ShowsApi->searchShowsByFilters: $e\n');
  }
}
