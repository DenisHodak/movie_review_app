import 'package:flutter/material.dart';

import '../config/app_styles.dart';

class CustomAppBarWidget extends StatelessWidget with PreferredSizeWidget {
  final String appBarTitle;
  final List<Widget>? actions;
  CustomAppBarWidget({Key? key, required this.appBarTitle, this.actions})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      flexibleSpace: Container(
        decoration: Decorations.appBarDecoration,
      ),
      title: Text(
        appBarTitle,
        style: TextStyle(color: Styles.textColor),
      ),
      actions: actions,
      centerTitle: true,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}












/*
import 'package:flutter/material.dart';
import '../config/app_styles.dart';

class CustomAppBarWidget extends StatelessWidget {
  const CustomAppBarWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(
        'Popular movies',
        style: TextStyle(color: Styles.textColor),
      ),
      centerTitle: true,
      backgroundColor: Colors.black,
      actions: [
        IconButton(
          onPressed: null,
          icon: Icon(
            Icons.search,
            color: Styles.textColor,
          ),
        )
      ],
    );
  }
}

*/