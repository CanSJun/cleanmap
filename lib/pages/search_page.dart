import 'package:cleanmap/components/filter_card.dart';
import 'package:cleanmap/components/google_map.dart';
import 'package:cleanmap/components/search_bar.dart';
import 'package:flutter/material.dart';

class SearchPage extends StatelessWidget {
  const SearchPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Builder(
          builder: (BuildContext context) {
            return IconButton(
              icon: const Icon(Icons.arrow_back),
              onPressed: () => Navigator.pop(context),
            );
          }
        ),
        title: const Text("주소")
      ),
      body: const Stack(
        children: <Widget>[
          PlacesMap(),
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              PlacesSearchBar(),
              FilterCard()
            ]
          )
        ],
      )
    );
  }
}