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
      // When using `initialRoute`, don't define a `home` property.
      // initialRoute: '/',
      initialRoute: '/search',
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