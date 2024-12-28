import 'package:SC3040_App/viewModels/filters_viewmodel.dart';
import 'package:SC3040_App/views/searchresultspage.dart';
import 'package:SC3040_App/widgets/appbar.dart';
import 'package:flutter/material.dart';
import 'package:openapi/api.dart';
import 'package:provider/provider.dart';
import 'package:google_fonts/google_fonts.dart';

class FiltersPage extends StatelessWidget {
  FiltersPage({
    super.key,
  });

  final Map<String, String> frontendOrderByOptions = {
    'Rating': 'rating',
    'Original Title': 'original_title',
    'Release Date': 'release_date',
    'Popularity (All Time)': 'popularity_alltime',
    'Popularity (1 Year)': 'popularity_1year',
    'Popularity (1 Month)': 'popularity_1month',
    'Popularity (1 Week)': 'popularity_1week',
  };

  final Map<String, String> frontendOrderDirection = {
    'Ascending': 'asc',
    'Descending': 'desc',
  };

  bool nextPage = false;

  void _resetFilters(BuildContext context, FiltersViewModel filtersViewModel) {
    if (!context.mounted) return;
    filtersViewModel.clearFilter();
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text("Filters have been reset"),
      ),
    );
  }

  Future<List<ModelShow>?> _getSearchResult(
    BuildContext context,
    FiltersViewModel filtersViewModel,
  ) async {
    if (!context.mounted) return null;
    bool searchSuccess = await filtersViewModel.performFilter();
    if (searchSuccess) {
      SearchResult result = filtersViewModel.result!;
      result.hasMore ? nextPage = true : nextPage = false;
      return result.shows;
    } else {
      if (!context.mounted) return null;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("${filtersViewModel.errorMessage}"),
        ),
      );
      return null;
    }
  }

  void submitSearch(BuildContext context, FiltersViewModel filtersViewModel) {
    if (!context.mounted) return;
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => FutureBuilder(
          future: _getSearchResult(context, filtersViewModel),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            } else if (snapshot.hasData) {
              return SearchResultsPage(
                searchResults: snapshot.data as List<ModelShow>,
                hasMoreResults: nextPage,
                filtersViewModel: filtersViewModel,
              );
            } else {
              return const Center(child: Text('No results found'));
            }
          },
        ),
      ),
    );
  }

  List<Genre>? getGenres(
    BuildContext context,
    FiltersViewModel filtersViewModel,
  ) {
    if (!context.mounted) return null;
    filtersViewModel.getGenres();
    return filtersViewModel.genres;
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => FiltersViewModel(),
      child: Scaffold(
        appBar: const CustomAppBar(
          displaySearchIcon: false,
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: LayoutBuilder(
            builder: (context, constraints) {
              return SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Consumer<FiltersViewModel>(
                      builder: (context, model, child) {
                        return TextField(
                          controller: model.showNameController,
                          decoration: InputDecoration(
                            labelText: 'Show Name',
                            labelStyle: GoogleFonts.bebasNeue(),
                            border: const OutlineInputBorder(),
                          ),
                        );
                      },
                    ),
                    const SizedBox(height: 8.0),
                    const Divider(color: Colors.black),
                    const SizedBox(height: 8.0),
                    Text(
                      'Show Type',
                      style: GoogleFonts.bebasNeue(),
                    ),
                    Consumer<FiltersViewModel>(
                      builder: (context, model, child) {
                        return SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            children: [
                              Wrap(
                                spacing: 8.0,
                                children: ShowType.values
                                    .map((type) => FilterChip(
                                          label: Text(
                                            type.toString().split('.').last,
                                            style: GoogleFonts.bebasNeue(),
                                          ),
                                          selected: model.selectedShowTypes
                                              .contains(type),
                                          onSelected: (selected) {
                                            model.updateShowTypes(
                                                type, selected);
                                          },
                                        ))
                                    .toList(),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                    const SizedBox(height: 15.0),
                    Text(
                      'Catalogs',
                      style: GoogleFonts.bebasNeue(),
                    ),
                    Consumer<FiltersViewModel>(
                      builder: (context, model, child) {
                        return SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            children: [
                              Wrap(
                                spacing: 8.0,
                                children: model.serviceTypes
                                    .map((catalog) => FilterChip(
                                          label: Text(
                                            catalog,
                                            style: GoogleFonts.bebasNeue(),
                                          ),
                                          selected: model.selectedCatalogs
                                              .contains(catalog),
                                          onSelected: (selected) {
                                            model.updateCatalogs(
                                                catalog, selected);
                                          },
                                        ))
                                    .toList(),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                    const SizedBox(height: 15.0),
                    Text(
                      'Genres',
                      style: GoogleFonts.bebasNeue(),
                    ),
                    Consumer<FiltersViewModel>(
                      builder: (context, model, child) {
                        List<Genre>? genres = getGenres(context, model);
                        if (genres == null) {
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        }
                        return SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            children: [
                              Wrap(
                                spacing: 8.0,
                                children: genres
                                    .map((genre) => FilterChip(
                                          label: Text(
                                            genre.name,
                                            style: GoogleFonts.bebasNeue(),
                                          ),
                                          selected: model.selectedGenres
                                              .contains(genre.name),
                                          onSelected: (selected) {
                                            model.updateGenres(
                                                genre.name, selected);
                                          },
                                        ))
                                    .toList(),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                    const SizedBox(height: 15.0),
                    Text(
                      'Year Range',
                      style: GoogleFonts.bebasNeue(),
                    ),
                    Consumer<FiltersViewModel>(
                      builder: (context, model, child) {
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  model.yearRange.start.round().toString(),
                                  style: GoogleFonts.bebasNeue(),
                                ),
                                Text(
                                  model.yearRange.end.round().toString(),
                                  style: GoogleFonts.bebasNeue(),
                                ),
                              ],
                            ),
                            RangeSlider(
                              values: model.yearRange,
                              min: 1900,
                              max: 2023,
                              divisions: 123,
                              labels: RangeLabels(
                                model.yearRange.start.round().toString(),
                                model.yearRange.end.round().toString(),
                              ),
                              onChanged: (RangeValues values) {
                                model.updateYearRange(values);
                              },
                            ),
                          ],
                        );
                      },
                    ),
                    const SizedBox(height: 15.0),
                    Text(
                      'Rating Range',
                      style: GoogleFonts.bebasNeue(),
                    ),
                    Consumer<FiltersViewModel>(
                      builder: (context, model, child) {
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  model.ratingRange.start.round().toString(),
                                  style: GoogleFonts.bebasNeue(),
                                ),
                                Text(
                                  model.ratingRange.end.round().toString(),
                                  style: GoogleFonts.bebasNeue(),
                                ),
                              ],
                            ),
                            RangeSlider(
                              values: model.ratingRange,
                              min: 0,
                              max: 100,
                              divisions: 100,
                              labels: RangeLabels(
                                model.ratingRange.start.round().toString(),
                                model.ratingRange.end.round().toString(),
                              ),
                              onChanged: (RangeValues values) {
                                model.updateRatingRange(values);
                              },
                            ),
                          ],
                        );
                      },
                    ),
                    const SizedBox(height: 15.0),
                    Text(
                      'Sort Options',
                      style: GoogleFonts.bebasNeue(),
                    ),
                    const SizedBox(height: 20.0),
                    Consumer<FiltersViewModel>(
                      builder: (context, model, child) {
                        return DropdownButtonFormField<String>(
                          borderRadius: BorderRadius.circular(10.0),
                          dropdownColor: Theme.of(context).colorScheme.surface,
                          decoration: InputDecoration(
                            labelText: 'Order By',
                            labelStyle: GoogleFonts.bebasNeue(),
                            border: const OutlineInputBorder(),
                          ),
                          value: frontendOrderByOptions[model.orderBy],
                          items: frontendOrderByOptions.keys
                              .map((orderBy) => DropdownMenuItem(
                                    value: orderBy,
                                    child: Text(
                                      orderBy.toUpperCase(),
                                      style: GoogleFonts.bebasNeue(
                                        color: Theme.of(context)
                                            .colorScheme
                                            .onSurface,
                                      ),
                                    ),
                                  ))
                              .toList(),
                          onChanged: (value) {
                            if (value != null) {
                              model.updateOrderBy(
                                  frontendOrderByOptions[value]!);
                            }
                          },
                        );
                      },
                    ),
                    const SizedBox(height: 20.0),
                    Consumer<FiltersViewModel>(
                      builder: (context, model, child) {
                        return DropdownButtonFormField<String>(
                          decoration: InputDecoration(
                            labelText: 'Order Direction',
                            labelStyle: GoogleFonts.bebasNeue(),
                            filled: true,
                            fillColor: Theme.of(context).colorScheme.surface,
                            border: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color:
                                      Theme.of(context).colorScheme.onSurface),
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                          ),
                          value: frontendOrderDirection.entries
                              .firstWhere((entry) =>
                                  entry.value == model.orderDirection)
                              .key,
                          items: frontendOrderDirection.keys
                              .map((direction) => DropdownMenuItem(
                                    value: direction,
                                    child: Text(
                                      direction.toUpperCase(),
                                      style: GoogleFonts.bebasNeue(
                                        color: Theme.of(context)
                                            .colorScheme
                                            .onSurface,
                                      ),
                                    ),
                                  ))
                              .toList(),
                          onChanged: (value) {
                            if (value != null) {
                              model.updateOrderDirection(
                                  frontendOrderDirection[value]!);
                            }
                          },
                        );
                      },
                    ),
                    const SizedBox(height: 15.0),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            foregroundColor:
                                Theme.of(context).colorScheme.onSurface,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                              side: BorderSide(
                                color: Theme.of(context).colorScheme.onSurface,
                              ),
                            ),
                          ),
                          onPressed: () {
                            submitSearch(
                                context,
                                Provider.of<FiltersViewModel>(context,
                                    listen: false));
                          },
                          child: Text(
                            'Submit',
                            style: GoogleFonts.bebasNeue(),
                          ),
                        ),
                        const SizedBox(width: 16.0),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            foregroundColor:
                                Theme.of(context).colorScheme.onSurface,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                              side: BorderSide(
                                color: Theme.of(context).colorScheme.onSurface,
                              ),
                            ),
                          ),
                          onPressed: () {
                            _resetFilters(
                                context,
                                Provider.of<FiltersViewModel>(context,
                                    listen: false));

                            nextPage = false;
                            WidgetsBinding.instance.addPostFrameCallback(
                              (_) {
                                if (context.mounted) {
                                  (context as Element).markNeedsBuild();
                                }
                              },
                            );
                          },
                          child: Text(
                            'Reset Filters',
                            style: GoogleFonts.bebasNeue(),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 15.0),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
