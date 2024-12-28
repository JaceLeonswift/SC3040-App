import 'package:SC3040_App/models/Review.dart';
import 'package:SC3040_App/viewModels/review_viewmodel.dart';
import 'package:SC3040_App/views/mediapage.dart';
import 'package:SC3040_App/widgets/addreview.dart';
import 'package:SC3040_App/widgets/linktext.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:openapi/api.dart';

class ReviewCard extends StatelessWidget {
  final Review review;
  final bool displayShow;
  final ModelShow? show;

  const ReviewCard({
    super.key,
    required this.review,
    required this.displayShow,
    this.show,
  });

  String _getTimeAgo(DateTime date) {
    final Duration diff = DateTime.now().difference(date);
    if (diff.inDays > 365) {
      return '${(diff.inDays / 365).floor()} years ago';
    } else if (diff.inDays > 30) {
      return '${(diff.inDays / 30).floor()} months ago';
    } else if (diff.inDays > 0) {
      return '${diff.inDays} days ago';
    } else if (diff.inHours > 0) {
      return '${diff.inHours} hours ago';
    } else if (diff.inMinutes > 0) {
      return '${diff.inMinutes} minutes ago';
    } else {
      return 'Just now';
    }
  }

  @override
  Widget build(BuildContext context) {
    if (review.rating < 0 || review.rating > 5) {
      throw Exception('Rating must be between 0 and 5');
    }
    // get rating value that can be used to display stars
    double stars_rating = review.rating.floorToDouble();
    if (review.rating - stars_rating >= 0.5) {
      stars_rating += 0.5;
    }
    return SizedBox(
      width: 350.0, // Set the desired width
      height: 150.0, // Set the desired height
      child: Card(
        color: Theme.of(context).colorScheme.onSecondary.withOpacity(0.1),
        margin: const EdgeInsets.all(10.0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
          side: BorderSide(
            color: Theme.of(context).colorScheme.onSurface.withOpacity(0.1),
            width: 1.0,
          ),
        ),
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Align(
                  alignment: Alignment.bottomLeft,
                  child: displayShow && show != null
                      ? LinkText(
                          text: show!.title,
                          textStyle: GoogleFonts.bebasNeue(
                            fontSize: 25,
                          ),
                          page: MediaPage(show: show!),
                        )
                      : null,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: List.generate(
                        5,
                        (index) {
                          if (index < stars_rating.round()) {
                            return const Icon(
                              Icons.star,
                              color: Colors.amber,
                              size: 20.0,
                            );
                          } else if (index < stars_rating) {
                            return const Icon(
                              Icons.star_half,
                              color: Colors.amber,
                              size: 20.0,
                            );
                          } else {
                            return const Icon(
                              Icons.star_border,
                              color: Colors.amber,
                              size: 20.0,
                            );
                          }
                        },
                      ),
                    ),
                    SafeArea(
                      child: Text(
                        _getTimeAgo(review.timestamp),
                        style: const TextStyle(
                          fontSize: 12.0,
                          color: Colors.grey,
                          wordSpacing: 3.0,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 5.0),
                Text(
                  review.comment!,
                  style: const TextStyle(
                    fontSize: 14.0,
                  ),
                  softWrap: true,
                ),
                Align(
                  alignment: Alignment.bottomLeft,
                  child: displayShow && show != null
                      ? null
                      : Text(
                          '~ ${review.username}',
                          style: const TextStyle(
                            fontStyle: FontStyle.italic,
                            fontSize: 12,
                          ),
                        ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
