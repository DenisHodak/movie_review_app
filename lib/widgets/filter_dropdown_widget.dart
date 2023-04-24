import 'package:flutter/material.dart';

import '../config/app_styles.dart';

class FilterDropdownWidget extends StatelessWidget {
  const FilterDropdownWidget({super.key, this.value, required this.title, required this.onChanged, required this.items});

  final int? value;
  final void Function(int?)? onChanged;
  final List<DropdownMenuItem<int>>? items;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40,
      padding: const EdgeInsets.all(4.0),
      decoration: BoxDecoration(
          border: Border.all(color: Styles.bordersColor, width: 1),
          borderRadius: BorderRadius.circular(RadiusValue.inputFieldRadius)),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<int>(
          value: value,
          menuMaxHeight: 250,
          dropdownColor: Color.fromARGB(200, 0, 0, 0),
          hint: Text(
            title,
            style: TextStyle(color: Styles.bordersColor),
          ),
          items: items,
          onChanged: onChanged,
        ),
      ),
    );
  }
}
