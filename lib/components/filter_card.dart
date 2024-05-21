import 'package:flutter/material.dart';
import 'package:pointer_interceptor/pointer_interceptor.dart';

class FilterCard extends StatefulWidget {
  const FilterCard({super.key});

  @override
  State<StatefulWidget> createState() => FilterCardState();
}

class FilterCardState extends State<FilterCard> {
  final List<Widget> filters = <Widget>[
    Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 24.0
      ),
      child: RichText(
        text: const TextSpan(
          children: [
            WidgetSpan(
              child: Icon(Icons.delete, size: 18),
            ),
            TextSpan(
              text: " 일반",
              style: TextStyle(
                color: Colors.white,
                fontSize: 16
              )
            )
          ]
        )
      ),
    ),
    Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 24.0
      ),
      child: RichText(
        text: const TextSpan(
          children: [
            WidgetSpan(
              child: Icon(Icons.compost, size: 18),
            ),
            TextSpan(
              text: " 음식물",
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 16
              )
            )
          ]
        )
      ),
    ),
    Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 24.0
      ),
      child: RichText(
        text: const TextSpan(
          children: [
            WidgetSpan(
              child: Icon(Icons.recycling, size: 18),
            ),
            TextSpan(
              text: " 재활용",
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 16
              )
            )
          ]
        )
      ),
    )
  ];

  final List<bool> _selectedFilters = <bool>[true, false, false];

  @override
  Widget build(BuildContext context) {
    return PointerInterceptor(
      child: Align(
        alignment: Alignment.bottomCenter,
        child: Container(
          padding: const EdgeInsets.all(4.0),
          child: Card(
            child: ToggleButtons(
              isSelected: _selectedFilters,
              children: filters,
              onPressed: (int i) {
                // All buttons are selectable.
                setState(() {
                  _selectedFilters[i] = !_selectedFilters[i];
                });
              },
            )
          )
        )
      )
    );
  }
}