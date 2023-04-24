import 'package:flutter/material.dart';

import '../config/app_styles.dart';
import '../constants/constants.dart';

class LoadingScreenFailedWidget extends StatelessWidget {
  const LoadingScreenFailedWidget({super.key, required this.loadingDataFailed, required this.onPressed});
  final bool loadingDataFailed; 
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            loadingDataFailed
                ? Content.checkInternetConnection
                : Content.unknownError,
            style: TextStyle(
                color: Styles.errorColor,
                fontWeight: FontWeight.w500,
                fontSize: 16),
          ),
          TextButton.icon(
            onPressed:
                onPressed,
            // Ued icon in label and text in icon to change order. They both require any widget.
            label: Icon(
              Icons.replay,
              color: Styles.errorColor,
            ),
            icon: Text(
              Content.reload,
              style: TextStyle(color: Styles.errorColor, fontSize: 15),
            ),
          )
        ],
      ),
    );
  }
}