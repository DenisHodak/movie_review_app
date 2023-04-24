import 'package:flutter/material.dart';

import '../config/app_styles.dart';
import '../widgets/image_with_error_handling_widget.dart';
import '../config/config.dart';

class MovieListTileWidget extends StatelessWidget {
  const MovieListTileWidget({super.key, this.onTap, required this.title, required this.releaseDate, required this.posterPath});

  final void Function()? onTap;
  final String title;
  final DateTime? releaseDate;
  final String posterPath;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: Color.fromARGB(73, 0, 0, 0),
            width: 1.5,
          ),
        ),
      ),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(vertical: 5, horizontal: 8.0),
        onTap: onTap,
        title: Text(
          title,
          style: TextStyle(color: Styles.textColor),
        ),
        trailing: releaseDate != null
            ? Text(
                releaseDate!.year.toString(),
                style: TextStyle(color: Styles.textColor),
              )
            : const Text(''),
        leading: Container(
          height: 100,
          width: 40,
          color: Styles.textColor,
          child: ImageWithErrorHandlingWidget(
            imageUrl: Config.imageUrl(posterPath),
            errorPlaceholder: const Icon(
              Icons.person,
              color: Colors.black45,
              size: 12,
            ),
          ),
        ),
      ),
    );
  }
}
