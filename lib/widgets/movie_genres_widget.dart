import 'package:flutter/material.dart';

import '../config/app_styles.dart';

class MovieGenresWidget extends StatelessWidget {
  const MovieGenresWidget({super.key, required this.genres});

  final List<dynamic> genres;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Wrap(
        children: [
          for (String genre in genres)
            Container(
              margin: const EdgeInsets.only(right: 5.0, top: 5.0),
              padding: const EdgeInsets.all(5.0),
              decoration: BoxDecoration(
                  border: Border.all(color: Styles.textColor),
                  borderRadius: const BorderRadius.all(Radius.circular(12))),
              child: Text(genre,
                  style: TextStyle(color: Styles.textColor, fontSize: 12)),
            )
        ],
      ),
    );
  }
}
