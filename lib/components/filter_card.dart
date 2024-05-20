import 'package:flutter/material.dart';
import 'package:pointer_interceptor/pointer_interceptor.dart';

class FilterCard extends StatefulWidget {
  const FilterCard({super.key});

  @override
  State<StatefulWidget> createState() => FilterCardState();
}

class FilterCardState extends State<FilterCard> {
  final List<Widget> filters = <Widget>[
    const Text("일반"),
    const Text("재활용"),
    const Text("음식물")
  ];

  final List<bool> _selectedFilters = <bool>[
    true, false, false
  ];

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