# openapi.model.StreamingOption

## Load the model package
```dart
import 'package:openapi/api.dart';
```

## Properties
Name | Type | Description | Notes
------------ | ------------- | ------------- | -------------
**service** | [**ServiceInfo**](ServiceInfo.md) |  | 
**type** | [**StreamingOptionType**](StreamingOptionType.md) |  | 
**addon** | [**Addon**](Addon.md) | Addon that the streaming option is available through. Omitted if the streaming option is not available through an addon.  | [optional] 
**link** | **String** | Deep link to the streaming option's page in the web app of the streaming service. Unlike videoLink, this field is guaranteed to be populated.  | 
**videoLink** | **String** | Deep link to the video associated with the streaming option. Omitted if there's no direct link to the video. Might have the same value as link.  | [optional] 
**quality** | **String** | Maximum supported video quality of the streaming option. | [optional] 
**audios** | [**List<Locale>**](Locale.md) | Array of the available audios. | [default to const []]
**subtitles** | [**List<Subtitle>**](Subtitle.md) | Array of the available subtitles. | [default to const []]
**price** | [**Price**](Price.md) |  | [optional] 
**expiresSoon** | **bool** | Whether the streaming option expires within a month. | 
**expiresOn** | **int** | [Unix Time Stamp](https://www.unixtimestamp.com/) of the date that the streaming option is expiring. In other words, last day to watch.  | [optional] 
**availableSince** | **int** | [Unix Time Stamp](https://www.unixtimestamp.com/) of the date that this streaming option was detected.  | 

[[Back to Model list]](../README.md#documentation-for-models) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to README]](../README.md)


