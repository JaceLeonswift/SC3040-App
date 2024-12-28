import 'package:SC3040_App/models/Show.dart';
import 'package:SC3040_App/views/mediapage.dart';
import 'package:SC3040_App/widgets/mediaview.dart';
import 'package:flutter/material.dart';
import 'package:openapi/api.dart';

class ShowListView extends StatelessWidget {
  const ShowListView({
    super.key,
    required this.shows,
    this.popupEnabled = false,
    this.onDelete,
    this.showDeleteIcon = false,
  });

  final List<ModelShow> shows;
  final bool popupEnabled;
  final void Function(String)? onDelete;
  final bool showDeleteIcon;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 200, // Set a fixed height for the ListView
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: shows
            .map((show) => Padding(
                  padding: const EdgeInsets.only(left: 5.0, right: 5.0),
                  child: Stack(
                    children: [
                      popupEnabled
                          ? MediaPopUpView(
                              modelShow: show,
                              popUpWidth: 300,
                              popUpImageHeight: 300,
                            )
                          : MediaView(
                              title: show.title,
                              posterImage: Image.network(
                                  show.imageSet.verticalPoster.w720),
                              mediaPage: MediaPage(
                                show: show,
                              ),
                            ),
                      if (showDeleteIcon)
                        Positioned(
                          top: 0,
                          right: 0,
                          child: Container(
                            decoration: BoxDecoration(
                              color: Theme.of(context)
                                  .colorScheme
                                  .onSurface, // Background color
                              shape: BoxShape.circle, // Circular shape
                              boxShadow: [
                                BoxShadow(
                                  color:
                                      Theme.of(context).colorScheme.onPrimary,
                                  blurRadius: 4,
                                  offset: const Offset(2, 2),
                                ),
                              ],
                            ),
                            child: IconButton(
                              icon: Icon(Icons.delete,
                                  color:
                                      Theme.of(context).colorScheme.onPrimary),
                              onPressed: () {
                                onDelete!(show.id);
                              },
                            ),
                          ),
                        ),
                    ],
                  ),
                ))
            .toList(),
      ),
    );
  }
}
