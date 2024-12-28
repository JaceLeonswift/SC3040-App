import 'package:openapi/api.dart';

class ShowSearchParams 
{
  final Set<String>? topGenres; // Extracted top 5 most common genre IDs
  final ShowType? mostCommonShowType;
  final int? minYear;
  final int? minRating;

  ShowSearchParams
  ({
    this.topGenres,
    this.mostCommonShowType,
    this.minYear,
    this.minRating,
  });

  static ShowSearchParams fromFavouriteShows(List<ModelShow> favouriteShows) 
  {
    if (favouriteShows.isEmpty) 
    {
      return ShowSearchParams(); // Return with all attributes as null
    }

    // Extract and count genres
    final Map<String, int> genreCount = {};
    for (var show in favouriteShows) 
    {
      for (var genre in show.genres) 
      {
        genreCount[genre.id] = (genreCount[genre.id] ?? 0) + 1;
      }
    }
    final sortedGenres = genreCount.entries.toList();
    sortedGenres.sort((a, b) => b.value.compareTo(a.value));
    final topGenres = sortedGenres.take(5).map((entry) => entry.key).toSet();

    // Determine most common showType
    final showTypeCount = <ShowType, int>{};
    for (var show in favouriteShows) 
    {
      showTypeCount[show.showType] = (showTypeCount[show.showType] ?? 0) + 1;
    }
    final mostCommonShowType = showTypeCount.entries.reduce((a, b) => a.value > b.value ? a : b).key;

    // Calculate minYear and minRating
    final minYear = favouriteShows.map((show) => show.releaseYear).where((year) => year != null).reduce((a, b) => a! < b! ? a : b);
    final minRating = favouriteShows.map((show) => show.rating).reduce((a, b) => a < b ? a : b);

    return ShowSearchParams
    (
      topGenres: topGenres.isNotEmpty ? topGenres : null,
      mostCommonShowType: mostCommonShowType,
      minYear: minYear,
      minRating: minRating,
    );
  }

  @override
  String toString() 
  {
    return 'ShowSearchParams[topGenres=$topGenres, '
          'mostCommonShowType=$mostCommonShowType, '
          'minYear=$minYear, '
          'minRating=$minRating]';
  }
}
