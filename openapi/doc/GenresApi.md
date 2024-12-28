# openapi.api.GenresApi

## Load the API package
```dart
import 'package:openapi/api.dart';
```

All URIs are relative to *https://streaming-availability.p.rapidapi.com*

Method | HTTP request | Description
------------- | ------------- | -------------
[**getGenres**](GenresApi.md#getgenres) | **GET** /genres | Get all Genres


# **getGenres**
> List<Genre> getGenres(outputLanguage)

Get all Genres

Get the list of supported genres.

### Example
```dart
import 'package:openapi/api.dart';
// TODO Configure API key authorization: X-Rapid-API-Key
//defaultApiClient.getAuthentication<ApiKeyAuth>('X-Rapid-API-Key').apiKey = 'YOUR_API_KEY';
// uncomment below to setup prefix (e.g. Bearer) for API key, if needed
//defaultApiClient.getAuthentication<ApiKeyAuth>('X-Rapid-API-Key').apiKeyPrefix = 'Bearer';

final api_instance = GenresApi();
final outputLanguage = outputLanguage_example; // String | [ISO 639-1 code](https://en.wikipedia.org/wiki/ISO_639-1) of the output language. Determines in which language the output  will be in. 

try {
    final result = api_instance.getGenres(outputLanguage);
    print(result);
} catch (e) {
    print('Exception when calling GenresApi->getGenres: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **outputLanguage** | **String**| [ISO 639-1 code](https://en.wikipedia.org/wiki/ISO_639-1) of the output language. Determines in which language the output  will be in.  | [optional] [default to 'en']

### Return type

[**List<Genre>**](Genre.md)

### Authorization

[X-Rapid-API-Key](../README.md#X-Rapid-API-Key)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

