import 'package:SC3040_App/viewModels/filters_viewmodel.dart';
import 'package:SC3040_App/views/searchresultspage.dart';
import 'package:flutter/material.dart';
import 'package:openapi/api.dart';
import 'package:provider/provider.dart';
import 'package:google_fonts/google_fonts.dart';

class FiltersCard extends StatelessWidget {
  FiltersCard({super.key});

  bool nextPage = false;

  void _resetFilters(BuildContext context, FiltersViewModel filtersViewModel) {
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
    bool searchSuccess = await filtersViewModel.performFilter();
    if (searchSuccess) {
      SearchResult result = filtersViewModel.result!;
      result.hasMore ? nextPage = true : nextPage = false;
      return result.shows;
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("${filtersViewModel.errorMessage}"),
        ),
      );
      return null;
    }
  }

  void _submitSearch(BuildContext context, FiltersViewModel filtersViewModel) {
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
    filtersViewModel.getGenres();
    return filtersViewModel.genres;
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => FiltersViewModel(),
      child: Consumer<FiltersViewModel>(
        builder: (context, filtersViewModel, child) {
          return Card(
            margin: const EdgeInsets.all(16.0),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Center(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        'Filters',
                        style: GoogleFonts.bebasNeue(fontSize: 30),
                      ),
                      const SizedBox(height: 8.0),
                      TextField(
                        controller: filtersViewModel.showNameController,
                        decoration: InputDecoration(
                          labelText: 'Show Name',
                          labelStyle: GoogleFonts.bebasNeue(fontSize: 20),
                          border: const OutlineInputBorder(),
                        ),
                      ),
                      const SizedBox(height: 8.0),
                      const Divider(color: Colors.black),
                      const SizedBox(height: 8.0),
                      Text(
                        'Catalogs',
                        style: GoogleFonts.bebasNeue(fontSize: 20),
                      ),
                      SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children: [
                            Wrap(
                              spacing: 8.0,
                              children: filtersViewModel.serviceTypes
                                  .map((catalog) => FilterChip(
                                        label: Text(
                                          catalog,
                                          style: GoogleFonts.bebasNeue(),
                                        ),
                                        selected: filtersViewModel
                                            .selectedCatalogs
                                            .contains(catalog),
                                        onSelected: (selected) {
                                          filtersViewModel.updateCatalogs(
                                              catalog, selected);
                                        },
                                      ))
                                  .toList(),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 15.0),
                      Text(
                        'Genres',
                        style: GoogleFonts.bebasNeue(fontSize: 20),
                      ),
                      Builder(
                        builder: (context) {
                          List<Genre>? genres =
                              getGenres(context, filtersViewModel);
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
                                            selected: filtersViewModel
                                                .selectedGenres
                                                .contains(genre.name),
                                            onSelected: (selected) {
                                              filtersViewModel.updateGenres(
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
                                  color:
                                      Theme.of(context).colorScheme.onSurface,
                                ),
                              ),
                            ),
                            onPressed: () {
                              _submitSearch(context, filtersViewModel);
                            },
                            child: Text(
                              'Submit',
                              style: GoogleFonts.bebasNeue(fontSize: 20),
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
                                  color:
                                      Theme.of(context).colorScheme.onSurface,
                                ),
                              ),
                            ),
                            onPressed: () {
                              _resetFilters(context, filtersViewModel);

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
                              style: GoogleFonts.bebasNeue(fontSize: 20),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 15.0),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
