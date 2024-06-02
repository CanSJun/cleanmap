import 'dart:async';

import 'package:cleanmap/components/filter_card.dart';
import 'package:cleanmap/components/google_map.dart';
import 'package:cleanmap/components/search_bar.dart';
import 'package:flutter/material.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<StatefulWidget> createState() => SearchPageState();
}

class SearchPageState extends State<SearchPage> {
  StreamController<List<bool>> controller = StreamController<List<bool>>();

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
      body: Stack(
        children: <Widget>[
          PlacesMap(stream: controller.stream),
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const PlacesSearchBar(),
              FilterCard(controller: controller)
            ]
          )
        ],
      )
    );
  }
}