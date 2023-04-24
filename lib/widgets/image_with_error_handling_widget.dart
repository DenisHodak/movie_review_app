import 'package:flutter/material.dart';

import '../config/app_styles.dart';

class ImageWithErrorHandlingWidget extends StatelessWidget {
  const ImageWithErrorHandlingWidget({super.key, required this.imageUrl, required this.errorPlaceholder});

  final String imageUrl;
  final Widget errorPlaceholder;

  @override
  Widget build(BuildContext context) {
    return Image.network(
      imageUrl,
      fit: BoxFit.fill,
      loadingBuilder: (context, child, loadingProgress) {
        if (loadingProgress == null) return child;
        return Center(
          child: CircularProgressIndicator(
            color: Styles.loadingColor,
            value: loadingProgress.expectedTotalBytes != null
                ? loadingProgress.cumulativeBytesLoaded /
                    loadingProgress.expectedTotalBytes!
                : null,
          ),
        );
      },
      errorBuilder: (_, __, ___) {
        return errorPlaceholder;
      },
    );
  }
}
