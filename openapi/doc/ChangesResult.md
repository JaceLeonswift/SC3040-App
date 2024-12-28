# openapi.model.ChangesResult

## Load the model package
```dart
import 'package:openapi/api.dart';
```

## Properties
Name | Type | Description | Notes
------------ | ------------- | ------------- | -------------
**changes** | [**List<Change>**](Change.md) | Array of the changes. | [default to const []]
**shows** | [**Map<String, ModelShow>**](ModelShow.md) | Map of the shows by their ids. | [default to const {}]
**hasMore** | **bool** | Whether there are more changes available. | 
**nextCursor** | **String** | Cursor value to pass to get the next set of changes. | [optional] 

[[Back to Model list]](../README.md#documentation-for-models) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to README]](../README.md)


