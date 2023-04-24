import 'package:flutter/material.dart';

import '../models/cast.dart';
import '../widgets/image_with_error_handling_widget.dart';
import '../config/app_styles.dart';
import '../config/config.dart';

class CastWidget extends StatelessWidget {
  const CastWidget({super.key, required this.cast});

  final Cast cast;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          Container(
            color: Styles.textColor,
            width: 100,
            height: 150,
            child: ImageWithErrorHandlingWidget(
              imageUrl: Config.imageUrl(cast.profilePath),
              errorPlaceholder: const Icon(
                Icons.person,
                color: Colors.black45,
                size: 100,
              ),
            ),
          ),
          SizedBox(
            height: 50,
            width: 100,
            child: Padding(
                padding: const EdgeInsets.only(top: 5.0),
                child: Text(
                  cast.name,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 3,
                  style: TextStyle(color: Styles.textColor),
                )),
          )
        ],
      ),
    );
  }
}
