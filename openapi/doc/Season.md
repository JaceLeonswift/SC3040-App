# openapi.model.Season

## Load the model package
```dart
import 'package:openapi/api.dart';
```

## Properties
Name | Type | Description | Notes
------------ | ------------- | ------------- | -------------
**itemType** | **String** | Type of the item. Always season. | 
**title** | **String** | Title of the season. | 
**firstAirYear** | **int** | The first year that the season aired. | 
**lastAirYear** | **int** | The last year that the season aired. | 
**streamingOptions** | [**Map<String, List<StreamingOption>>**](List.md) | Map of the streaming options by the country code. | [default to const {}]
**episodes** | [**List<Episode>**](Episode.md) | Array of the episodes belong to the season. | [optional] [default to const []]

[[Back to Model list]](../README.md#documentation-for-models) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to README]](../README.md)


