# openapi.model.ModelShow

## Load the model package
```dart
import 'package:openapi/api.dart';
```

## Properties
Name | Type | Description | Notes
------------ | ------------- | ------------- | -------------
**itemType** | **String** | Type of the item. Always show. | 
**showType** | [**ShowType**](ShowType.md) | Type of the show. Based on the type, some properties might be omitted. | 
**id** | **String** | Id of the show. | 
**imdbId** | **String** | [IMDb](https://www.imdb.com/) id of the show. | 
**tmdbId** | **String** | [TMDB](https://www.themoviedb.org/) id of the show. | 
**title** | **String** | Title of the show. | 
**overview** | **String** | A brief overview of the overall plot of the show. | 
**releaseYear** | **int** | The year that the movie was released. | [optional] 
**firstAirYear** | **int** | The first year that the series aired. | [optional] 
**lastAirYear** | **int** | The last year that the series aired. | [optional] 
**originalTitle** | **String** | Original title of the show. | 
**genres** | [**List<Genre>**](Genre.md) | Array of the genres of the show. | [default to const []]
**directors** | **List<String>** | Array of the directors of the movie. | [optional] [default to const []]
**creators** | **List<String>** | Array of the creators of the series. | [optional] [default to const []]
**cast** | **List<String>** | Array of the cast of the show. | [default to const []]
**rating** | **int** | Rating of the show. This is calculated by taking the average of ratings found online from multiple sources. | 
**seasonCount** | **int** | Number of seasons that are either aired or announced for a series. | [optional] 
**episodeCount** | **int** | Number of episodes that are either aired or announced for a series. | [optional] 
**runtime** | **int** | Runtime of the movie in minutes. | [optional] 
**imageSet** | [**ShowImageSet**](ShowImageSet.md) | Image set of the show. | 
**streamingOptions** | [**Map<String, List<StreamingOption>>**](List.md) | Map of the streaming options by the country code. | [default to const {}]
**seasons** | [**List<Season>**](Season.md) | Array of the seasons belong to the series. | [optional] [default to const []]

[[Back to Model list]](../README.md#documentation-for-models) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to README]](../README.md)


