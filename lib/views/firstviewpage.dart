import 'dart:async';

import 'package:SC3040_App/global.dart';
import 'package:SC3040_App/viewModels/auth_viewmodel.dart';
import 'package:SC3040_App/viewModels/filters_viewmodel.dart';
import 'package:SC3040_App/viewModels/recommendation_viewmodel.dart';
import 'package:SC3040_App/widgets/appbar.dart';
import 'package:SC3040_App/widgets/filterscard.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:SC3040_App/widgets/showlistview.dart';
import 'package:openapi/api.dart';
import 'package:provider/provider.dart';

class FirstViewPage extends StatelessWidget {
  const FirstViewPage({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (BuildContext context) => RecommendationViewmodel(),
        ),
        ChangeNotifierProvider(
          create: (BuildContext context) => FiltersViewModel(),
        ),
      ],
      child: FirstViewWidget(),
    );
  }
}

class FirstViewWidget extends StatelessWidget {
  FirstViewWidget({super.key});

  List<ModelShow>? _trendingShows;

  Future<List<ModelShow>?> getShows() async {
    (defaultApiClient.authentication as ApiKeyAuth).apiKey = apiKey;

    final apiInstance = ShowsApi();
    const country = 'sg';
    const outputLanguage = 'en';
    const service = 'netflix';
    List<ModelShow>? result;

    try {
      result = await apiInstance.getTopShows(
        country,
        service,
        outputLanguage: outputLanguage,
      );
    } catch (e) {
      print('Exception when calling ShowsApi->getTopShows: $e\n');
    }
    _trendingShows = result;
    return result;
  }

  Future<List<ModelShow>?> getRecommendedShows(
    BuildContext context,
    RecommendationViewmodel recommendationViewModel,
  ) async {
    bool success = await recommendationViewModel.getRecommendedShows(context);
    if (success) {
      return recommendationViewModel.recommendedShows;
    } else {
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    AuthViewModel authViewModel =
        Provider.of<AuthViewModel>(context, listen: false);
    FiltersViewModel filtersViewModel = Provider.of<FiltersViewModel>(context);
    RecommendationViewmodel recommendationViewModel =
        Provider.of<RecommendationViewmodel>(context, listen: false);

    getRecommendedShows(context, recommendationViewModel);
    return Scaffold(
      appBar: const CustomAppBar(),
      backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      body: Column(
        children: [
          Expanded(
            child: ListView(
              physics: const ScrollPhysics(),
              children: [
                Align(
                  alignment: Alignment.centerLeft,
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Text(
                      'Trending',
                      textAlign: TextAlign.left,
                      style: GoogleFonts.bebasNeue(fontSize: 30),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: FutureBuilder<List<ModelShow>?>(
                    future: _trendingShows == null
                        ? getShows()
                        : Future.value(
                            _trendingShows), // Only call getShows if _trendingShows is null
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Center(child: CircularProgressIndicator());
                      } else if (snapshot.hasError) {
                        return Center(child: Text('Error: ${snapshot.error}'));
                      } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                        return const Center(child: Text('No shows available'));
                      } else {
                        int showsPerRow = 10;
                        List<ModelShow> shows = snapshot.data!;
                        int rows = (shows.length / showsPerRow)
                            .ceil(); // Assuming 10 shows per row
                        return Column(
                          children: List.generate(rows, (index) {
                            int start = index * showsPerRow;
                            int end = start + showsPerRow;
                            List<ModelShow> rowShows = shows.sublist(
                              start,
                              end > shows.length ? shows.length : end,
                            );
                            return Padding(
                              padding: const EdgeInsets.only(bottom: 10.0),
                              child: ShowListView(shows: rowShows),
                            );
                          }),
                        );
                      }
                    },
                  ),
                ),
                FiltersCard(), //TODO: integrate filters
                Align(
                  alignment: Alignment.centerLeft,
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Text(
                      'Recommended Shows',
                      textAlign: TextAlign.left,
                      style: GoogleFonts.bebasNeue(fontSize: 30),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: authViewModel.user == null
                      ? const Center(
                          child: Text(
                            'Please log in to view recommendations',
                          ),
                        )
                      : Consumer<RecommendationViewmodel>(
                          builder: (context, recommendationViewModel, child) {
                            return FutureBuilder<List<ModelShow>?>(
                              future: getRecommendedShows(
                                  context, recommendationViewModel),
                              builder: (context, snapshot) {
                                if (snapshot.connectionState ==
                                    ConnectionState.waiting) {
                                  if (authViewModel
                                      .user!.recommended_shows.isNotEmpty) {
                                    int showsPerRow = 15;
                                    List<ModelShow> recommendedShows =
                                        authViewModel.user!.recommended_shows;
                                    int rows =
                                        (recommendedShows.length / showsPerRow)
                                            .ceil();
                                    return Column(
                                      children: List.generate(rows, (index) {
                                        int start = index * showsPerRow;
                                        int end = start + showsPerRow;
                                        List<ModelShow> rowShows =
                                            recommendedShows.sublist(
                                          start,
                                          end > recommendedShows.length
                                              ? recommendedShows.length
                                              : end,
                                        );
                                        return Padding(
                                          padding: const EdgeInsets.only(
                                              bottom: 10.0),
                                          child: ShowListView(
                                            shows: rowShows,
                                          ),
                                        );
                                      }),
                                    );
                                  } else {
                                    return const Center(
                                        child: CircularProgressIndicator());
                                  }
                                } else if (snapshot.hasError) {
                                  return Center(
                                      child: Text('Error: ${snapshot.error}'));
                                } else if (!snapshot.hasData ||
                                    snapshot.data!.isEmpty) {
                                  return const Center(
                                      child:
                                          Text('No recommendations available'));
                                } else {
                                  int showsPerRow = 15;
                                  List<ModelShow> recommendedShows =
                                      snapshot.data!;
                                  int rows =
                                      (recommendedShows.length / showsPerRow)
                                          .ceil();
                                  return Column(
                                    children: List.generate(rows, (index) {
                                      int start = index * showsPerRow;
                                      int end = start + showsPerRow;
                                      List<ModelShow> rowShows =
                                          recommendedShows.sublist(
                                        start,
                                        end > recommendedShows.length
                                            ? recommendedShows.length
                                            : end,
                                      );
                                      return Padding(
                                        padding:
                                            const EdgeInsets.only(bottom: 10.0),
                                        child: ShowListView(
                                          shows: rowShows,
                                        ),
                                      );
                                    }),
                                  );
                                }
                              },
                            );
                          },
                        ),
                ),
                // add space at the bottom
                const SizedBox(height: 100),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
