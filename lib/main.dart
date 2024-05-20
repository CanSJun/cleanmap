import 'package:cleanmap/pages/intro_page.dart';
import 'package:cleanmap/pages/search_page.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(
    MaterialApp(
        routes: {
          '/': (BuildContext context) => const IntroPage(),
          '/search': (BuildContext context) => const SearchPage()
        },
        initialRoute: '/',
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
}