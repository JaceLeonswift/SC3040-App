import 'package:SC3040_App/viewModels/collection_viewmodel.dart';
import 'package:SC3040_App/viewModels/review_viewmodel.dart';
import 'package:SC3040_App/widgets/addreview.dart';
import 'package:SC3040_App/widgets/appbar.dart';
import 'package:SC3040_App/widgets/reviewcard.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:openapi/api.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

class MediaPage extends StatelessWidget {
  const MediaPage({
    super.key,
    required this.show,
  });

  final ModelShow show;

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<CollectionsViewmodel>(
          create: (BuildContext context) => CollectionsViewmodel(),
        ),
        ChangeNotifierProvider<ReviewViewmodel>(
          create: (context) => ReviewViewmodel(),
        ),
      ],
      child: Scaffold(
        body: MediaPageChild(show: show),
      ),
    );
  }
}

class MediaPageChild extends StatelessWidget {
  final ModelShow show;

  const MediaPageChild({super.key, required this.show});

  void addToCollection(
    BuildContext context,
    CollectionsViewmodel collectionsViewmodel,
    int collectionIndex,
  ) {
    collectionsViewmodel.addShowToCollection(context, show, collectionIndex);
  }

  Future<int?> _getCollectionIndex(
      BuildContext context, CollectionsViewmodel collectionsViewmodel) {
    return showDialog<int?>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Which Collection?'),
          content: DropdownButton<int>(
            hint: const Text('Select'),
            items: collectionsViewmodel.user?.shows_collections_list
                .asMap()
                .entries
                .map<DropdownMenuItem<int>>((entry) {
              return DropdownMenuItem<int>(
                value: entry.key,
                child: Text(entry.value.name),
              );
            }).toList(),
            onChanged: (int? newValue) {
              if (newValue != null) {
                Navigator.pop(context, newValue);
              }
            },
          ),
        );
      },
    );
  }

  Future<void> _createReview(
    BuildContext context,
    ReviewViewmodel reviewViewModel,
  ) async {
    bool? create = await showDialog<bool>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Add a new review'),
          content: AddReviewPage(
            show: show,
            reviewViewModel: reviewViewModel,
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Cancel'),
              onPressed: () {
                Navigator.pop(context, false);
              },
            ),
            StatefulBuilder(
              builder: (context, setState) {
                bool isButtonDisabled = false;

                return TextButton(
                  child: const Text('Submit Review'),
                  onPressed: isButtonDisabled
                      ? null
                      : () async {
                          setState(() {
                            isButtonDisabled = true;
                          });

                          bool success =
                              await reviewViewModel.createReview(context, show);

                          Navigator.pop(context, success);
                        },
                );
              },
            ),
          ],
        );
      },
    );

    if (create == true) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Review added successfully'),
        ),
      );
    } else if (create == false) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content:
              Text('Failed to add review: ${reviewViewModel.errorMessage}'),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final collectionsViewmodel = Provider.of<CollectionsViewmodel>(context);
    collectionsViewmodel.getUser(context);

    return Scaffold(
      appBar: const CustomAppBar(),
      body: Container(
        constraints: const BoxConstraints.expand(),
        child: Stack(
          children: [
            // Background image
            Positioned.fill(
              child: Image.network(
                show.imageSet.horizontalBackdrop?.w1440 ??
                    show.imageSet.horizontalBackdrop?.w1080 ??
                    show.imageSet.horizontalPoster.w1440,
                fit: BoxFit.cover,
              ),
            ),
            // Dark overlay
            Positioned.fill(
              child: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Theme.of(context).colorScheme.onPrimary.withOpacity(0.7),
                      Theme.of(context).colorScheme.onPrimary.withOpacity(0.7),
                    ],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                  ),
                ),
              ),
            ),
            // Movie details
            SafeArea(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Padding(padding: EdgeInsets.only(top: 400)),
                            Text(
                              show.title,
                              style: GoogleFonts.bebasNeue(
                                fontSize: 60,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 10),
                            Text(
                              [
                                if (show.releaseYear != null)
                                  '${show.releaseYear}',
                                if (show.showType == ShowType.movie &&
                                    show.runtime != null)
                                  '${show.runtime} min',
                                if (show.showType != ShowType.movie &&
                                    show.seasonCount != 0)
                                  '${show.seasonCount} Seasons',
                                'HD'
                              ].join('   '),
                              style: GoogleFonts.bebasNeue(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 5),
                            Container(
                              decoration: BoxDecoration(
                                color: Theme.of(context).colorScheme.onSurface,
                                borderRadius: BorderRadius.circular(4),
                              ),
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 6, vertical: 4),
                              child: Text(
                                show.rating.toString(),
                                style: TextStyle(
                                  color:
                                      Theme.of(context).colorScheme.onPrimary,
                                  fontSize: 16,
                                ),
                              ),
                            ),
                            const SizedBox(height: 20),
                            Text(
                              show.overview,
                              style: const TextStyle(
                                fontSize: 16,
                              ),
                              maxLines: 5,
                              overflow: TextOverflow.ellipsis,
                            ),
                            const SizedBox(height: 30),
                            if (collectionsViewmodel.user != null)
                              Row(
                                children: [
                                  ElevatedButton.icon(
                                    onPressed: () {
                                      _getCollectionIndex(
                                              context, collectionsViewmodel)
                                          .then((idx) {
                                        if (idx != null) {
                                          if (!collectionsViewmodel.isLoading) {
                                            addToCollection(context,
                                                collectionsViewmodel, idx);
                                          }
                                        }
                                      });
                                    },
                                    icon: const Icon(
                                      Icons.add,
                                    ),
                                    label:
                                        collectionsViewmodel.isLoading == true
                                            ? CircularProgressIndicator(
                                                color: Theme.of(context)
                                                    .colorScheme
                                                    .onPrimary,
                                              )
                                            : Text(
                                                'Add Show to Collection',
                                                style: GoogleFonts.bebasNeue(
                                                  fontSize: 20,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                    style: ElevatedButton.styleFrom(
                                      foregroundColor: Theme.of(context)
                                          .colorScheme
                                          .onPrimary,
                                      backgroundColor: Theme.of(context)
                                          .colorScheme
                                          .onSurface,
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 20, vertical: 10),
                                      side: BorderSide(
                                        color: Theme.of(context)
                                            .colorScheme
                                            .onPrimary,
                                        width: 2,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            const SizedBox(height: 20),
                            Row(
                              children: [
                                Align(
                                  alignment: Alignment.topLeft,
                                  child: Text(
                                    'Cast:',
                                    style: GoogleFonts.bebasNeue(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                    width: 5), // Add spacing to align text
                                Expanded(
                                  child: Text(
                                    show.cast.join(', '),
                                    style: const TextStyle(
                                      fontSize: 14,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 5),
                            Row(
                              children: [
                                Text(
                                  'Genres: ',
                                  style: GoogleFonts.bebasNeue(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Text(
                                  show.genres
                                      .map((genre) => genre.name)
                                      .join(', '),
                                  style: const TextStyle(
                                    fontSize: 14,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 5),
                            Row(
                              children: [
                                Text(
                                  'Streaming Platforms: ',
                                  style: GoogleFonts.bebasNeue(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Expanded(
                                  child: Wrap(
                                    spacing: 8.0,
                                    children: show.streamingOptions["sg"]
                                            ?.map<Widget>((option) {
                                          return ElevatedButton(
                                            onPressed: () {
                                              launchUrl(Uri.parse(option.link));
                                            },
                                            style: ElevatedButton.styleFrom(
                                              foregroundColor: Theme.of(context)
                                                  .colorScheme
                                                  .onPrimary,
                                              backgroundColor: Theme.of(context)
                                                  .colorScheme
                                                  .onSurface,
                                              side: BorderSide(
                                                color: Color(int.parse(option
                                                    .service.themeColorCode
                                                    .replaceFirst(
                                                        '#', '0xff'))),
                                                width: 2,
                                              ),
                                            ),
                                            child: Image.network(
                                              option.service.imageSet
                                                  .lightThemeImage,
                                              height: 24,
                                            ),
                                          );
                                        }).toList() ??
                                        [],
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 20),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'User Reviews',
                                  style: GoogleFonts.bebasNeue(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                if (collectionsViewmodel.user != null)
                                  ElevatedButton.icon(
                                    onPressed: () async {
                                      await _createReview(
                                        context,
                                        Provider.of<ReviewViewmodel>(context,
                                            listen: false),
                                      );
                                    },
                                    icon: const Icon(
                                      Icons.add,
                                    ),
                                    label: Text(
                                      'Add Review',
                                      style: GoogleFonts.bebasNeue(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    style: ElevatedButton.styleFrom(
                                      foregroundColor: Theme.of(context)
                                          .colorScheme
                                          .onPrimary,
                                      backgroundColor: Theme.of(context)
                                          .colorScheme
                                          .onSurface,
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 20, vertical: 10),
                                      side: BorderSide(
                                        color: Theme.of(context)
                                            .colorScheme
                                            .onPrimary,
                                        width: 2,
                                      ),
                                    ),
                                  ),
                              ],
                            ),
                            const SizedBox(height: 10),
                            Consumer<ReviewViewmodel>(
                              builder: (context, reviewViewModel, child) {
                                if (reviewViewModel.showReviews == null) {
                                  return FutureBuilder<bool>(
                                    future: reviewViewModel
                                        .showReviewsList(show.id.toString()),
                                    builder: (context, snapshot) {
                                      if (snapshot.connectionState ==
                                          ConnectionState.waiting) {
                                        return const Center(
                                          child: CircularProgressIndicator(),
                                        );
                                      } else if (snapshot.hasError) {
                                        return Center(
                                          child:
                                              Text('Error: ${snapshot.error}'),
                                        );
                                      } else if (reviewViewModel
                                          .showReviews!.isEmpty) {
                                        return const Center(
                                          child: Text('No reviews found'),
                                        );
                                      } else {
                                        return SingleChildScrollView(
                                          scrollDirection: Axis.horizontal,
                                          child: Row(
                                            children: reviewViewModel
                                                    .showReviews
                                                    ?.map((review) {
                                                  return ReviewCard(
                                                    review: review,
                                                    displayShow: false,
                                                  );
                                                }).toList() ??
                                                [],
                                          ),
                                        );
                                      }
                                    },
                                  );
                                } else {
                                  return SingleChildScrollView(
                                    scrollDirection: Axis.horizontal,
                                    child: Row(
                                      children: reviewViewModel.showReviews
                                              ?.map((review) {
                                            return ReviewCard(
                                              review: review,
                                              displayShow: false,
                                            );
                                          }).toList() ??
                                          [],
                                    ),
                                  );
                                }
                              },
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
