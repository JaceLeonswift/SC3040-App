# openapi.api.ShowsApi

## Load the API package
```dart
import 'package:openapi/api.dart';
```

All URIs are relative to *https://streaming-availability.p.rapidapi.com*

Method | HTTP request | Description
------------- | ------------- | -------------
[**getShow**](ShowsApi.md#getshow) | **GET** /shows/{id} | Get a Show
[**getTopShows**](ShowsApi.md#gettopshows) | **GET** /shows/top | Get Top Shows
[**searchShowsByFilters**](ShowsApi.md#searchshowsbyfilters) | **GET** /shows/search/filters | Search Shows by filters
[**searchShowsByTitle**](ShowsApi.md#searchshowsbytitle) | **GET** /shows/search/title | Search Shows by title


# **getShow**
> ModelShow getShow(id, country, seriesGranularity, outputLanguage)

Get a Show

Get the details of a show via id, imdbId or tmdbId, including the global streaming availability info.

### Example
```dart
import 'package:openapi/api.dart';
// TODO Configure API key authorization: X-Rapid-API-Key
//defaultApiClient.getAuthentication<ApiKeyAuth>('X-Rapid-API-Key').apiKey = 'YOUR_API_KEY';
// uncomment below to setup prefix (e.g. Bearer) for API key, if needed
//defaultApiClient.getAuthentication<ApiKeyAuth>('X-Rapid-API-Key').apiKeyPrefix = 'Bearer';

final api_instance = ShowsApi();
final id = tt0120338; // String | id of the show. You can also pass an IMDb Id or a TMDB Id as an id. The endpoint will automatically detect the type of the id and fetch the show accordingly.  When passing an IMDb Id, it should be in the format of tt<numerical_id>. (e.g. tt0120338 for Titanic)  When passing a TMDB Id, it should be in the format of movie/<numerical_id> for movies and tv/<numerical_id> for series. (e.g. tv/1396 for Breaking Bad and movie/597 for Titanic) 
final country = ca; // String | [ISO 3166-1 alpha-2](https://en.wikipedia.org/wiki/ISO_3166-1_alpha-2) code of the optional target country. If this parameter is not supplied, global streaming availability across all the countries will be returned. If it is supplied, only the streaming availability info from the given country will be returned. If you are only interested in the streaming availability in a single country, then it is recommended to use this parameter to reduce the size of the response and increase the performance of the endpoint. See /countries endpoint to get the list of supported countries. 
final seriesGranularity = seriesGranularity_example; // String | series_granularity determines the level of detail for series. It does not affect movies.  If series_granularity is show, then the output will not include season and episode info.  If series_granularity is season, then the output will include season info but not episode info.  If series_granularity is episode, then the output will include season and episode info.  If you do not need season and episode info, then it is recommended to set series_granularity as show to reduce the size of the response and increase the performance of the endpoint.  If you need deep links for individual seasons and episodes, then you should set series_granularity as episode. In this case response will include full streaming info for seasons and episodes, similar to the streaming info for movies and series; including deep links into seasons and episodes, individual subtitle/audio and video quality info etc. 
final outputLanguage = outputLanguage_example; // String | [ISO 639-1 code](https://en.wikipedia.org/wiki/ISO_639-1) of the output language. Determines in which language the output  will be in. 

try {
    final result = api_instance.getShow(id, country, seriesGranularity, outputLanguage);
    print(result);
} catch (e) {
    print('Exception when calling ShowsApi->getShow: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **id** | **String**| id of the show. You can also pass an IMDb Id or a TMDB Id as an id. The endpoint will automatically detect the type of the id and fetch the show accordingly.  When passing an IMDb Id, it should be in the format of tt<numerical_id>. (e.g. tt0120338 for Titanic)  When passing a TMDB Id, it should be in the format of movie/<numerical_id> for movies and tv/<numerical_id> for series. (e.g. tv/1396 for Breaking Bad and movie/597 for Titanic)  | 
 **country** | **String**| [ISO 3166-1 alpha-2](https://en.wikipedia.org/wiki/ISO_3166-1_alpha-2) code of the optional target country. If this parameter is not supplied, global streaming availability across all the countries will be returned. If it is supplied, only the streaming availability info from the given country will be returned. If you are only interested in the streaming availability in a single country, then it is recommended to use this parameter to reduce the size of the response and increase the performance of the endpoint. See /countries endpoint to get the list of supported countries.  | [optional] 
 **seriesGranularity** | **String**| series_granularity determines the level of detail for series. It does not affect movies.  If series_granularity is show, then the output will not include season and episode info.  If series_granularity is season, then the output will include season info but not episode info.  If series_granularity is episode, then the output will include season and episode info.  If you do not need season and episode info, then it is recommended to set series_granularity as show to reduce the size of the response and increase the performance of the endpoint.  If you need deep links for individual seasons and episodes, then you should set series_granularity as episode. In this case response will include full streaming info for seasons and episodes, similar to the streaming info for movies and series; including deep links into seasons and episodes, individual subtitle/audio and video quality info etc.  | [optional] [default to 'episode']
 **outputLanguage** | **String**| [ISO 639-1 code](https://en.wikipedia.org/wiki/ISO_639-1) of the output language. Determines in which language the output  will be in.  | [optional] [default to 'en']

### Return type

[**ModelShow**](ModelShow.md)

### Authorization

[X-Rapid-API-Key](../README.md#X-Rapid-API-Key)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **getTopShows**
> List<ModelShow> getTopShows(country, service, outputLanguage, showType)

Get Top Shows

Get the official top shows in a service. Top shows are determined by the streaming service itself.  Supported streaming services are: - Netflix: netflix - Amazon Prime Video: prime - Apple TV: apple - Max: hbo  For unsupported services, this endpoint will return an empty list.  Series granularity is always show for this endpoint, meaning that the output will not include season and episode info. 

### Example
```dart
import 'package:openapi/api.dart';
// TODO Configure API key authorization: X-Rapid-API-Key
//defaultApiClient.getAuthentication<ApiKeyAuth>('X-Rapid-API-Key').apiKey = 'YOUR_API_KEY';
// uncomment below to setup prefix (e.g. Bearer) for API key, if needed
//defaultApiClient.getAuthentication<ApiKeyAuth>('X-Rapid-API-Key').apiKeyPrefix = 'Bearer';

final api_instance = ShowsApi();
final country = ca; // String | [ISO 3166-1 alpha-2](https://en.wikipedia.org/wiki/ISO_3166-1_alpha-2) code of the target country. See /countries endpoint to get the list of supported countries. 
final service = netflix; // String | Id of the target service. 
final outputLanguage = outputLanguage_example; // String | [ISO 639-1 code](https://en.wikipedia.org/wiki/ISO_639-1) of the output language. Determines in which language the output  will be in. 
final showType = ; // ShowType | Type of shows to search in. If not supplied, both movies and series will be included in the search results. 

try {
    final result = api_instance.getTopShows(country, service, outputLanguage, showType);
    print(result);
} catch (e) {
    print('Exception when calling ShowsApi->getTopShows: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **country** | **String**| [ISO 3166-1 alpha-2](https://en.wikipedia.org/wiki/ISO_3166-1_alpha-2) code of the target country. See /countries endpoint to get the list of supported countries.  | 
 **service** | **String**| Id of the target service.  | 
 **outputLanguage** | **String**| [ISO 639-1 code](https://en.wikipedia.org/wiki/ISO_639-1) of the output language. Determines in which language the output  will be in.  | [optional] [default to 'en']
 **showType** | [**ShowType**](.md)| Type of shows to search in. If not supplied, both movies and series will be included in the search results.  | [optional] 

### Return type

[**List<ModelShow>**](ModelShow.md)

### Authorization

[X-Rapid-API-Key](../README.md#X-Rapid-API-Key)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **searchShowsByFilters**
> SearchResult searchShowsByFilters(country, catalogs, outputLanguage, showType, genres, genresRelation, showOriginalLanguage, yearMin, yearMax, ratingMin, ratingMax, keyword, seriesGranularity, orderBy, orderDirection, cursor)

Search Shows by filters

Search through the catalog of the given streaming services in the given country. Provides filters such as show language, genres, keyword and release year. Output includes all the information about the shows, such as title, IMDb ID, TMDb ID, release year, deep links to streaming services, available subtitles, audios, available video quality and many more! Apart from the info about the given country-service combinations, output also includes information about streaming availability in the other services for the given country. Streaming availability info from the other countries are not included in the response.  When show_type is movie or series_granularity is show, items per page is 20. When show_type is series and series_granularity is episode items per page is 10. Otherwise, items per page is 15. 

### Example
```dart
import 'package:openapi/api.dart';
// TODO Configure API key authorization: X-Rapid-API-Key
//defaultApiClient.getAuthentication<ApiKeyAuth>('X-Rapid-API-Key').apiKey = 'YOUR_API_KEY';
// uncomment below to setup prefix (e.g. Bearer) for API key, if needed
//defaultApiClient.getAuthentication<ApiKeyAuth>('X-Rapid-API-Key').apiKeyPrefix = 'Bearer';

final api_instance = ShowsApi();
final country = ca; // String | [ISO 3166-1 alpha-2](https://en.wikipedia.org/wiki/ISO_3166-1_alpha-2) code of the target country. See /countries endpoint to get the list of supported countries. 
final catalogs = [netflix]; // List<String> | A comma separated list of up to 32 catalogs to search in. See /countries endpoint to get the supported services in each country and their ids.  When multiple catalogs are passed as a comma separated list, any show that is in at least one of the catalogs will be included in the result.  If no catalogs are passed, the endpoint will search in all the available catalogs in the country.  Syntax of the catalogs supplied in the list can be as the followings:  - <sevice_id>: Searches in the entire catalog of that service, including (if applicable) rentable, buyable shows or shows available through addons e.g. netflix, prime, apple  - <sevice_id>.<streaming_option_type>: Only returns the shows that are available in that service with the given streaming option type. Valid streaming option types are subscription, free, rent, buy and addon e.g. peacock.free only returns the shows on Peacock that are free to watch, prime.subscription only returns the shows on Prime Video that are available to watch with a Prime subscription. hulu.addon only returns the shows on Hulu that are available via an addon, prime.rent only returns the shows on Prime Video that are rentable.  - <sevice_id>.addon.<addon_id>: Only returns the shows that are available in that service with the given addon. Check /countries endpoint to fetch the available addons for a service in each country. Some sample values are: hulu.addon.hbo, prime.addon.hbomaxus. 
final outputLanguage = outputLanguage_example; // String | [ISO 639-1 code](https://en.wikipedia.org/wiki/ISO_639-1) of the output language. Determines in which language the output  will be in. 
final showType = ; // ShowType | Type of shows to search in. If not supplied, both movies and series will be included in the search results. 
final genres = [action]; // List<String> | A comma seperated list of genre ids to only search within the shows in those genre. See /genres endpoint to see the available genres and their ids. Use genres_relation parameter to specify between returning shows that have at least one of the given genres or returning shows that have all of the given genres. 
final genresRelation = genresRelation_example; // String | Only used when there are multiple genres supplied in genres parameter.  When or, the endpoint returns any show that has at least one of the given genres. When and, it only returns the shows that have all of the given genres. 
final showOriginalLanguage = en; // String | [ISO 639-1](https://en.wikipedia.org/wiki/ISO_639-1) language code to only search within the shows whose original language matches with the provided language. 
final yearMin = 1980.0; // int | Minimum release/air year of the shows.
final yearMax = 1980.0; // int | Maximum release/air year of the shows.
final ratingMin = 75.0; // int | Minimum rating of the shows.
final ratingMax = 80.0; // int | Maximum rating of the shows.
final keyword = zombie; // String | A keyword to only search within the shows have that keyword in their overview or title.
final seriesGranularity = seriesGranularity_example; // String | series_granularity determines the level of detail for series. It does not affect movies.  If series_granularity is show, then the output will not include season and episode info.  If series_granularity is season, then the output will include season info but not episode info.  If series_granularity is episode, then the output will include season and episode info.  If you do not need season and episode info, then it is recommended to set series_granularity as show to reduce the size of the response and increase the performance of the endpoint.  If you need deep links for individual seasons and episodes, then you should set series_granularity as episode. In this case response will include full streaming info for seasons and episodes, similar to the streaming info for movies and series; including deep links into seasons and episodes, individual subtitle/audio and video quality info etc. 
final orderBy = orderBy_example; // String | Determines the ordering of the shows. Make sure to set descending_order parameter as true when ordering by popularity or rating so that shows with the highest popularity or rating will be returned first. 
final orderDirection = ; // OrderDirection | Determines whether to order the results in ascending or descending order.  Default value when ordering alphabetically or based on dates/times is asc.  Default value when ordering by rating or popularity is desc. 
final cursor = cursor_example; // String | Cursor is used for pagination. After each request, the response includes a hasMore boolean field to tell if there are more results that did not fit into the returned list. If it is set as true, to get the rest of the result set, send a new request (with the same parameters for other fields), and set the cursor parameter as the nextCursor value of the response of the previous request. Do not forget to escape the cursor value before putting it into a query as it might contain characters such as ?and &.  The first request naturally does not require a cursor parameter. 

try {
    final result = api_instance.searchShowsByFilters(country, catalogs, outputLanguage, showType, genres, genresRelation, showOriginalLanguage, yearMin, yearMax, ratingMin, ratingMax, keyword, seriesGranularity, orderBy, orderDirection, cursor);
    print(result);
} catch (e) {
    print('Exception when calling ShowsApi->searchShowsByFilters: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **country** | **String**| [ISO 3166-1 alpha-2](https://en.wikipedia.org/wiki/ISO_3166-1_alpha-2) code of the target country. See /countries endpoint to get the list of supported countries.  | 
 **catalogs** | [**List<String>**](String.md)| A comma separated list of up to 32 catalogs to search in. See /countries endpoint to get the supported services in each country and their ids.  When multiple catalogs are passed as a comma separated list, any show that is in at least one of the catalogs will be included in the result.  If no catalogs are passed, the endpoint will search in all the available catalogs in the country.  Syntax of the catalogs supplied in the list can be as the followings:  - <sevice_id>: Searches in the entire catalog of that service, including (if applicable) rentable, buyable shows or shows available through addons e.g. netflix, prime, apple  - <sevice_id>.<streaming_option_type>: Only returns the shows that are available in that service with the given streaming option type. Valid streaming option types are subscription, free, rent, buy and addon e.g. peacock.free only returns the shows on Peacock that are free to watch, prime.subscription only returns the shows on Prime Video that are available to watch with a Prime subscription. hulu.addon only returns the shows on Hulu that are available via an addon, prime.rent only returns the shows on Prime Video that are rentable.  - <sevice_id>.addon.<addon_id>: Only returns the shows that are available in that service with the given addon. Check /countries endpoint to fetch the available addons for a service in each country. Some sample values are: hulu.addon.hbo, prime.addon.hbomaxus.  | [optional] [default to const []]
 **outputLanguage** | **String**| [ISO 639-1 code](https://en.wikipedia.org/wiki/ISO_639-1) of the output language. Determines in which language the output  will be in.  | [optional] [default to 'en']
 **showType** | [**ShowType**](.md)| Type of shows to search in. If not supplied, both movies and series will be included in the search results.  | [optional] 
 **genres** | [**List<String>**](String.md)| A comma seperated list of genre ids to only search within the shows in those genre. See /genres endpoint to see the available genres and their ids. Use genres_relation parameter to specify between returning shows that have at least one of the given genres or returning shows that have all of the given genres.  | [optional] [default to const []]
 **genresRelation** | **String**| Only used when there are multiple genres supplied in genres parameter.  When or, the endpoint returns any show that has at least one of the given genres. When and, it only returns the shows that have all of the given genres.  | [optional] [default to 'and']
 **showOriginalLanguage** | **String**| [ISO 639-1](https://en.wikipedia.org/wiki/ISO_639-1) language code to only search within the shows whose original language matches with the provided language.  | [optional] 
 **yearMin** | **int**| Minimum release/air year of the shows. | [optional] 
 **yearMax** | **int**| Maximum release/air year of the shows. | [optional] 
 **ratingMin** | **int**| Minimum rating of the shows. | [optional] 
 **ratingMax** | **int**| Maximum rating of the shows. | [optional] 
 **keyword** | **String**| A keyword to only search within the shows have that keyword in their overview or title. | [optional] 
 **seriesGranularity** | **String**| series_granularity determines the level of detail for series. It does not affect movies.  If series_granularity is show, then the output will not include season and episode info.  If series_granularity is season, then the output will include season info but not episode info.  If series_granularity is episode, then the output will include season and episode info.  If you do not need season and episode info, then it is recommended to set series_granularity as show to reduce the size of the response and increase the performance of the endpoint.  If you need deep links for individual seasons and episodes, then you should set series_granularity as episode. In this case response will include full streaming info for seasons and episodes, similar to the streaming info for movies and series; including deep links into seasons and episodes, individual subtitle/audio and video quality info etc.  | [optional] [default to 'show']
 **orderBy** | **String**| Determines the ordering of the shows. Make sure to set descending_order parameter as true when ordering by popularity or rating so that shows with the highest popularity or rating will be returned first.  | [optional] [default to 'original_title']
 **orderDirection** | [**OrderDirection**](.md)| Determines whether to order the results in ascending or descending order.  Default value when ordering alphabetically or based on dates/times is asc.  Default value when ordering by rating or popularity is desc.  | [optional] 
 **cursor** | **String**| Cursor is used for pagination. After each request, the response includes a hasMore boolean field to tell if there are more results that did not fit into the returned list. If it is set as true, to get the rest of the result set, send a new request (with the same parameters for other fields), and set the cursor parameter as the nextCursor value of the response of the previous request. Do not forget to escape the cursor value before putting it into a query as it might contain characters such as ?and &.  The first request naturally does not require a cursor parameter.  | [optional] 

### Return type

[**SearchResult**](SearchResult.md)

### Authorization

[X-Rapid-API-Key](../README.md#X-Rapid-API-Key)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **searchShowsByTitle**
> List<ModelShow> searchShowsByTitle(title, country, showType, seriesGranularity, outputLanguage)

Search Shows by title

Search for movies and series by a title. Maximum amount of items returned are 20 unless there are more than 20 shows with the exact given title input. In that case all the items have 100% match with the title will be returned.  Streaming availability info for the target country is included in the response, but not for the other countries.  Results might include shows that are not streamable in the target country. Only criteria for the search are the title and the show type.  No pagination is supported. 

### Example
```dart
import 'package:openapi/api.dart';
// TODO Configure API key authorization: X-Rapid-API-Key
//defaultApiClient.getAuthentication<ApiKeyAuth>('X-Rapid-API-Key').apiKey = 'YOUR_API_KEY';
// uncomment below to setup prefix (e.g. Bearer) for API key, if needed
//defaultApiClient.getAuthentication<ApiKeyAuth>('X-Rapid-API-Key').apiKeyPrefix = 'Bearer';

final api_instance = ShowsApi();
final title = Batman; // String | Title phrase to search for.
final country = ca; // String | [ISO 3166-1 alpha-2](https://en.wikipedia.org/wiki/ISO_3166-1_alpha-2) code of the target country. See /countries endpoint to get the list of supported countries. 
final showType = ; // ShowType | Type of shows to search in. If not supplied, both movies and series will be included in the search results. 
final seriesGranularity = seriesGranularity_example; // String | series_granularity determines the level of detail for series. It does not affect movies.  If series_granularity is show, then the output will not include season and episode info.  If series_granularity is season, then the output will include season info but not episode info.  If series_granularity is episode, then the output will include season and episode info.  If you do not need season and episode info, then it is recommended to set series_granularity as show to reduce the size of the response and increase the performance of the endpoint.  If you need deep links for individual seasons and episodes, then you should set series_granularity as episode. In this case response will include full streaming info for seasons and episodes, similar to the streaming info for movies and series; including deep links into seasons and episodes, individual subtitle/audio and video quality info etc. 
final outputLanguage = outputLanguage_example; // String | [ISO 639-1 code](https://en.wikipedia.org/wiki/ISO_639-1) of the output language. Determines in which language the output  will be in. 

try {
    final result = api_instance.searchShowsByTitle(title, country, showType, seriesGranularity, outputLanguage);
    print(result);
} catch (e) {
    print('Exception when calling ShowsApi->searchShowsByTitle: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **title** | **String**| Title phrase to search for. | 
 **country** | **String**| [ISO 3166-1 alpha-2](https://en.wikipedia.org/wiki/ISO_3166-1_alpha-2) code of the target country. See /countries endpoint to get the list of supported countries.  | 
 **showType** | [**ShowType**](.md)| Type of shows to search in. If not supplied, both movies and series will be included in the search results.  | [optional] 
 **seriesGranularity** | **String**| series_granularity determines the level of detail for series. It does not affect movies.  If series_granularity is show, then the output will not include season and episode info.  If series_granularity is season, then the output will include season info but not episode info.  If series_granularity is episode, then the output will include season and episode info.  If you do not need season and episode info, then it is recommended to set series_granularity as show to reduce the size of the response and increase the performance of the endpoint.  If you need deep links for individual seasons and episodes, then you should set series_granularity as episode. In this case response will include full streaming info for seasons and episodes, similar to the streaming info for movies and series; including deep links into seasons and episodes, individual subtitle/audio and video quality info etc.  | [optional] [default to 'show']
 **outputLanguage** | **String**| [ISO 639-1 code](https://en.wikipedia.org/wiki/ISO_639-1) of the output language. Determines in which language the output  will be in.  | [optional] [default to 'en']

### Return type

[**List<ModelShow>**](ModelShow.md)

### Authorization

[X-Rapid-API-Key](../README.md#X-Rapid-API-Key)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

