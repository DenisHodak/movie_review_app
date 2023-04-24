import 'package:flutter/material.dart';

import '../config/app_styles.dart';
import '../config/config.dart';
import '../constants/constants.dart';

import '../widgets/image_with_error_handling_widget.dart';

class MovieTileWidget extends StatelessWidget {
  final int id;
  final String posterPath;
  final String title;
  final DateTime? releaseDate;

  const MovieTileWidget({
    super.key,
    required this.id,
    required this.posterPath,
    required this.title,
    this.releaseDate,
  });

  void _openDetailsScreen(context) {
    Navigator.of(context).pushNamed(Navigation.movieDetailsPage, arguments: id);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: GestureDetector(
        onTap: () {
          _openDetailsScreen(context);
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  color: Styles.bordersColor,
                  borderRadius: BorderRadius.circular(10.0),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.blueAccent.withOpacity(0.2),
                      spreadRadius: 1,
                      blurRadius: 5,
                      offset: const Offset(0, 3),
                    ),
                  ],
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10.0),
                  child: ImageWithErrorHandlingWidget(
                    imageUrl: Config.imageUrl(posterPath),
                    errorPlaceholder: const Center(
                      child: Icon(
                        Icons.image_not_supported_sharp,
                        size: 50,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 8.0, bottom: 4.0),
              child: Text(
                title,
                style: TextStyle(
                  color: Styles.textColor,
                  fontSize: 15.0,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            Text(
              releaseDate?.year != null
                  ? "(${releaseDate!.year.toString()})"
                  : "",
              style: const TextStyle(
                fontSize: 12.0,
                color: Colors.grey,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
