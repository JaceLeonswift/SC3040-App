# openapi.api.CountriesApi

## Load the API package
```dart
import 'package:openapi/api.dart';
```

All URIs are relative to *https://streaming-availability.p.rapidapi.com*

Method | HTTP request | Description
------------- | ------------- | -------------
[**getCountries**](CountriesApi.md#getcountries) | **GET** /countries | Get all Countries
[**getCountry**](CountriesApi.md#getcountry) | **GET** /countries/{country-code} | Get a Country


# **getCountries**
> Map<String, Country> getCountries(outputLanguage)

Get all Countries

Get all the supported countries and the list of the supported services and their details for each country.  Details of services include names, logos, supported streaming types (subscription, rent, buy, free etc.) and list of available addons/channels. 

### Example
```dart
import 'package:openapi/api.dart';
// TODO Configure API key authorization: X-Rapid-API-Key
//defaultApiClient.getAuthentication<ApiKeyAuth>('X-Rapid-API-Key').apiKey = 'YOUR_API_KEY';
// uncomment below to setup prefix (e.g. Bearer) for API key, if needed
//defaultApiClient.getAuthentication<ApiKeyAuth>('X-Rapid-API-Key').apiKeyPrefix = 'Bearer';

final api_instance = CountriesApi();
final outputLanguage = outputLanguage_example; // String | [ISO 639-1 code](https://en.wikipedia.org/wiki/ISO_639-1) of the output language. Determines in which language the output  will be in. 

try {
    final result = api_instance.getCountries(outputLanguage);
    print(result);
} catch (e) {
    print('Exception when calling CountriesApi->getCountries: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **outputLanguage** | **String**| [ISO 639-1 code](https://en.wikipedia.org/wiki/ISO_639-1) of the output language. Determines in which language the output  will be in.  | [optional] [default to 'en']

### Return type

[**Map<String, Country>**](Country.md)

### Authorization

[X-Rapid-API-Key](../README.md#X-Rapid-API-Key)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **getCountry**
> Country getCountry(countryCode, outputLanguage)

Get a Country

Get a country and the list of the supported services and their details.  Details of services include names, logos, supported streaming types (subscription, rent, buy, free etc.) and list of available addons/channels. 

### Example
```dart
import 'package:openapi/api.dart';
// TODO Configure API key authorization: X-Rapid-API-Key
//defaultApiClient.getAuthentication<ApiKeyAuth>('X-Rapid-API-Key').apiKey = 'YOUR_API_KEY';
// uncomment below to setup prefix (e.g. Bearer) for API key, if needed
//defaultApiClient.getAuthentication<ApiKeyAuth>('X-Rapid-API-Key').apiKeyPrefix = 'Bearer';

final api_instance = CountriesApi();
final countryCode = us; // String | [ISO 3166-1 alpha-2 code](https://en.wikipedia.org/wiki/ISO_3166-1_alpha-2) of the country. 
final outputLanguage = outputLanguage_example; // String | [ISO 639-1 code](https://en.wikipedia.org/wiki/ISO_639-1) of the output language. Determines in which language the output  will be in. 

try {
    final result = api_instance.getCountry(countryCode, outputLanguage);
    print(result);
} catch (e) {
    print('Exception when calling CountriesApi->getCountry: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **countryCode** | **String**| [ISO 3166-1 alpha-2 code](https://en.wikipedia.org/wiki/ISO_3166-1_alpha-2) of the country.  | 
 **outputLanguage** | **String**| [ISO 639-1 code](https://en.wikipedia.org/wiki/ISO_639-1) of the output language. Determines in which language the output  will be in.  | [optional] [default to 'en']

### Return type

[**Country**](Country.md)

### Authorization

[X-Rapid-API-Key](../README.md#X-Rapid-API-Key)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

