import 'package:flutter/material.dart';

import '../config/app_styles.dart';

class LoadingIndicatorWidget extends StatelessWidget {
  const LoadingIndicatorWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: CircularProgressIndicator(
        color: Styles.loadingColor,
      ),
    );
    ;
  }
}
