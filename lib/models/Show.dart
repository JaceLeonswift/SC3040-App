// tempory class for testing model show
import 'package:flutter/material.dart';

class Show {
  final String title;
  final String description;
  final int runtime;
  final List<AssetImage> showImageSet;
  final List<String> genres;

  const Show(
      {required this.title,
      required this.description,
      required this.runtime,
      required this.showImageSet,
      required this.genres});
}
