# openapi.model.Change

## Load the model package
```dart
import 'package:openapi/api.dart';
```

## Properties
Name | Type | Description | Notes
------------ | ------------- | ------------- | -------------
**changeType** | [**ChangeType**](ChangeType.md) | Type of the change. | 
**itemType** | [**ItemType**](ItemType.md) | Type of the item affected from the change. | 
**showId** | **String** | Id of the show affected from the change. | 
**showType** | [**ShowType**](ShowType.md) | Type of the show affected from the change. | 
**season** | **int** | Number of the season affected from the change. Omitted if item_type is not seasonor episode. | [optional] 
**episode** | **int** | Number of the episode affected from the change. Omitted if item_type is not episode. | [optional] 
**service** | [**ServiceInfo**](ServiceInfo.md) | Service affected from the change. | 
**streamingOptionType** | [**StreamingOptionType**](StreamingOptionType.md) |  | 
**addon** | [**Addon**](Addon.md) | Addon info, if the streamingOptionType is addon. Otherwise omitted. | [optional] 
**timestamp** | **int** | [Unix Time Stamp](https://www.unixtimestamp.com/) of the change. Past changes (new, updated, removed) will always have a timestamp. Future changes (expiring, upcoming) will have a timestamp if the exact date is known. If not, timestamp will be omitted, e.g. a show is known to be expiring soon, but the exact date is not known.  | [optional] 
**link** | **String** | Deep link to the affected streaming option's page in the web app of the streaming service. This field is guaranteed to be populated when changeType is new, updated, expiring or removed. When changeType is upcoming, this field might be populated or null depending on if the link of the future streaming option is known.  | [optional] 

[[Back to Model list]](../README.md#documentation-for-models) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to README]](../README.md)


