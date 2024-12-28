import 'package:SC3040_App/viewModels/review_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:openapi/api.dart';

class AddReviewPage extends StatelessWidget {
  final ModelShow show;
  final _formKey = GlobalKey<FormState>();
  final ReviewViewmodel reviewViewModel;
  final TextEditingController displayController = TextEditingController();

  AddReviewPage({super.key, required this.show, required this.reviewViewModel});

  @override
  Widget build(BuildContext context) {
    double starWidth = 40.0; // Assuming the star size is 40.0

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Form(
        key: _formKey,
        child: Column(
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(
                5,
                (index) {
                  return MouseRegion(
                    onEnter: (_) {
                      double rating = (index + 1).toDouble();
                      displayController.text = rating.toString();
                      (context as Element).markNeedsBuild();
                    },
                    onExit: (_) {
                      displayController.text =
                          reviewViewModel.ratingController.text;
                      (context as Element).markNeedsBuild();
                    },
                    onHover: (event) {
                      double dx = event.localPosition.dx;
                      double rating =
                          (index + (dx < starWidth / 2 ? 0.5 : 1)).toDouble();
                      displayController.text = rating.toString();
                      (context as Element).markNeedsBuild();
                    },
                    child: GestureDetector(
                      onTapDown: (details) {
                        double dx = details.localPosition.dx;
                        double rating =
                            (index + (dx < starWidth / 2 ? 0.5 : 1)).toDouble();
                        reviewViewModel.ratingController.text =
                            rating.toString();
                        (context as Element).markNeedsBuild();
                      },
                      child: AnimatedBuilder(
                        animation: reviewViewModel,
                        builder: (context, _) {
                          if (displayController.text.isEmpty) {
                            displayController.text =
                                reviewViewModel.ratingController.text;
                          }
                          double? rating =
                              double.tryParse(displayController.text);
                          rating ??= 0;
                          rating -= 1;
                          return Icon(
                            index <= rating
                                ? Icons.star
                                : (index - rating == 0.5
                                    ? Icons.star_half
                                    : Icons.star_border),
                            color: Colors.amber,
                            size: starWidth,
                          );
                        },
                      ),
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: 16.0),
            TextFormField(
              controller: reviewViewModel.commentController,
              decoration: const InputDecoration(labelText: 'Comment'),
              maxLines: 3,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter a comment';
                }
                return null;
              },
            ),
          ],

        ),
      ),
    );
  }
}
