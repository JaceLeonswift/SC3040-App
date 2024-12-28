import 'package:SC3040_App/viewModels/filters_viewmodel.dart';
import 'package:SC3040_App/views/mediapage.dart';
import 'package:SC3040_App/widgets/appbar.dart';
import 'package:SC3040_App/widgets/mediaview.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:openapi/api.dart';
import 'package:provider/provider.dart';

class SearchResultsPage extends StatefulWidget {
  final List<ModelShow> searchResults;
  final bool hasMoreResults;
  final FiltersViewModel filtersViewModel;

  const SearchResultsPage(
      {super.key,
      required this.searchResults,
      required this.hasMoreResults,
      required this.filtersViewModel});

  @override
  _SearchResultsPageState createState() => _SearchResultsPageState();
}

class _SearchResultsPageState extends State<SearchResultsPage> {
  late List<ModelShow> searchResults;
  late bool hasMoreResults;

  @override
  void initState() {
    super.initState();
    searchResults = widget.searchResults;
    hasMoreResults = widget.hasMoreResults;
  }

  Future<List<ModelShow>?> _loadAdditionalResults(
    BuildContext context,
    FiltersViewModel filtersViewModel,
  ) async {
    bool searchSuccess = await filtersViewModel.nextPage();
    if (searchSuccess) {
      SearchResult result = filtersViewModel.result!;
      setState(() {
        hasMoreResults = result.hasMore;
      });
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

  void updateResults(BuildContext context, FiltersViewModel filtersViewModel) {
    _loadAdditionalResults(context, filtersViewModel).then((value) {
      if (value != null) {
        setState(() {
          searchResults += value;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => FiltersViewModel(),
      child: Scaffold(
        appBar: const CustomAppBar(
          displaySearchIcon: false,
        ),
        body: searchResults.isEmpty
            ? const Center(child: Text('No results found'))
            : LayoutBuilder(
                builder: (context, constraints) {
                  const double itemWidth = 150.0;
                  const double itemHeight = 250.0;
                  const double padding = 30;

                  int crossAxisCount =
                      (constraints.maxWidth / (itemWidth + padding)).floor();

                  if (crossAxisCount < 1) {
                    crossAxisCount = 1;
                  }

                  return GridView.builder(
                    padding: const EdgeInsets.all(padding),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: crossAxisCount,
                      childAspectRatio: itemWidth / itemHeight,
                      crossAxisSpacing: padding,
                      mainAxisSpacing: padding,
                    ),
                    itemCount: searchResults.length,
                    itemBuilder: (context, index) {
                      return GridTile(
                        child: MediaView(
                          title: searchResults[index].title,
                          posterImage: Image.network(searchResults[index]
                              .imageSet
                              .verticalPoster
                              .w720),
                          mediaPage: MediaPage(show: searchResults[index]),
                        ),
                      );
                    },
                  );
                },
              ),
        floatingActionButton: hasMoreResults
            ? Consumer<FiltersViewModel>(
                builder: (context, model, child) {
                  return FloatingActionButton(
                    onPressed: () {
                      updateResults(context, widget.filtersViewModel);
                    },
                    tooltip: 'Load more results',
                    child: const Icon(Icons.add),
                  );
                },
              )
            : null,
      ),
    );
  }
}
