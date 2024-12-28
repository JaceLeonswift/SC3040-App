import 'package:SC3040_App/views/mediapage.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:info_popup/info_popup.dart';
import 'package:openapi/api.dart';

class MediaView extends StatelessWidget {
  const MediaView(
      {super.key,
      required this.title,
      required this.posterImage,
      required this.mediaPage});

  final String title;
  final Image posterImage;

  final Widget mediaPage;

  final double mediaHeight = 300.0;
  final double mediaWidth = 166.67;

  void _accountClicked(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => mediaPage,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
        onTap: () {
          _accountClicked(context);
        },
        child: Container(
          height: 200,
          width: 133.33,
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            image: DecorationImage(
              image: posterImage.image,
              fit: BoxFit.fill,
            ),
            color: Theme.of(context).colorScheme.onSurface,
            borderRadius: const BorderRadius.all(Radius.circular(10.0)),
          ),
        ));
  }
}

class MediaPopUpView extends StatelessWidget {
  /// A widget

  const MediaPopUpView({
    super.key,
    required this.modelShow,
    required this.popUpWidth,
    required this.popUpImageHeight,
  });

  final ModelShow modelShow;

  final double popUpWidth;
  final double popUpImageHeight;

  @override
  Widget build(BuildContext context) {
    return InfoPopupWidget(
      customContent: () => Container(
        width: popUpWidth,
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.primaryContainer,
          borderRadius: BorderRadius.circular(10),
        ),
        padding: const EdgeInsets.all(10),
        child: Padding(
            padding: const EdgeInsets.all(3),
            child: Align(
              alignment: Alignment.center,
              child: Column(
                children: [
                  Text(
                    modelShow.title,
                    style: GoogleFonts.bebasNeue(fontSize: 18),
                    textAlign: TextAlign.left,
                  ),
                  const Padding(padding: EdgeInsets.all(3)),
                  Container(
                    height: popUpImageHeight,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage(modelShow.imageSet.horizontalPoster
                            .w1080), // TODO: handle OpenAPI showImageSet and use different landscape image
                        fit: BoxFit.fill,
                        opacity: 1.0,
                      ),
                      color: Theme.of(context).colorScheme.primaryContainer,
                      borderRadius:
                          const BorderRadius.all(Radius.circular(10.0)),
                      boxShadow: [
                        BoxShadow(
                          color: Theme.of(context)
                              .colorScheme
                              .shadow
                              .withOpacity(1),
                          spreadRadius: 2,
                          blurRadius: 15,
                          offset: const Offset(-4.0, -4.0),
                        ),
                        BoxShadow(
                          color: Colors.white.withOpacity(0.3),
                          spreadRadius: 1,
                          blurRadius: 15,
                          offset: const Offset(-4.0, -4.0),
                        ),
                      ],
                    ),
                  ),
                  const Padding(padding: EdgeInsets.all(3)),
                  Text(
                    modelShow.overview,
                    style: GoogleFonts.aBeeZee(fontSize: 10),
                    textAlign: TextAlign.left,
                  ),
                  const Padding(padding: EdgeInsets.all(3)),
                  Text(
                    "${modelShow.runtime} minutes \n${modelShow.genres.join(", ")}",
                    style: GoogleFonts.aBeeZee(fontSize: 9, color: Colors.red),
                    textAlign: TextAlign.left,
                  ),
                ],
              ),
            )),
      ),
      dismissTriggerBehavior: PopupDismissTriggerBehavior.onTapArea,
      indicatorOffset: Offset.zero,
      contentOffset: Offset.zero,
      child: MediaView(
        title: modelShow.title,
        posterImage: Image.network(modelShow.imageSet.verticalPoster.w720),
        mediaPage: MediaPage(
          show: modelShow,
        ),
      ),
    );
  }
}
