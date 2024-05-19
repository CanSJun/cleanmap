import 'package:flutter/material.dart';

import 'package:cleanmap/pages/search_page.dart';

void main() => runApp(
  MaterialApp(
    home: const SearchPage(),
    theme: ThemeData(
      appBarTheme: const AppBarTheme(
        elevation: 1.0
      ),
      colorScheme: ColorScheme.fromSeed(
        brightness: Brightness.dark,
        seedColor: Colors.white
      ),
    )
  )
);