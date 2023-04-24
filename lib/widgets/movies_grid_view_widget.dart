import 'package:flutter/material.dart';

class MoviesGridViewWidget extends StatelessWidget {
  const MoviesGridViewWidget({super.key, required this.itemCount, this.scrollController, required this.itemBuilder});

  final ScrollController? scrollController;
  final int itemCount;
  final Widget? Function(BuildContext, int) itemBuilder;

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisSpacing: 10,
        crossAxisCount: 3,
        childAspectRatio: 0.5,
        mainAxisSpacing: 20,
      ),
      controller: scrollController,
      itemCount: itemCount,
      itemBuilder: itemBuilder
    );
    ;
  }
}
