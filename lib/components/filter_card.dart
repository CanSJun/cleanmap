import 'dart:async';

import 'package:flutter/material.dart';
import 'package:pointer_interceptor/pointer_interceptor.dart';

class FilterCard extends StatefulWidget {
  const FilterCard({super.key, required this.controller});

  final StreamController<List<bool>> controller;

  @override
  State<StatefulWidget> createState() => FilterCardState();
}

class FilterCardState extends State<FilterCard> {
  final List<bool> selectedFilters = <bool>[true, false, false];

  @override
  void initState() {
    super.initState();

    widget.controller.add(selectedFilters);
  }

  @override
  Widget build(BuildContext context) {
    final List<Widget> filters = <Widget>[
      RichText(
        text: const TextSpan(
          children: [
            WidgetSpan(
              child: Icon(Icons.delete, size: 18),
            ),
            TextSpan(
              text: " 일반",
              style: TextStyle(
                fontSize: 16
              )
            )
          ]
        )
      ),
      RichText(
        text: const TextSpan(
          children: [
            WidgetSpan(
              child: Icon(Icons.compost, size: 18),
            ),
            TextSpan(
              text: " 음식물",
              style: TextStyle(
                  fontSize: 16
              )
            )
          ]
        )
      ),
      RichText(
        text: const TextSpan(
          children: [
            WidgetSpan(
              child: Icon(Icons.recycling, size: 18),
            ),
            TextSpan(
              text: " 재활용",
              style: TextStyle(
                  fontSize: 16
              )
            )
          ]
        )
      ),
    ];

    final BorderRadius borderRadius = BorderRadius.circular(32.0);

    return PointerInterceptor(
      // debug: true,
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: borderRadius
        ),
        child: ToggleButtons(
          isSelected: selectedFilters,
          onPressed: (int i) {
            // All buttons are selectable.
            setState(() {
              selectedFilters[i] = !selectedFilters[i];

              widget.controller.add(selectedFilters);
            });
          },
          constraints: BoxConstraints(
            minWidth: (MediaQuery.of(context).size.width - 18.0) / 3.0,
            minHeight: 36.0
          ),
          borderRadius: borderRadius,
          children: filters
        )
      )
    );
  }
}