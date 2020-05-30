import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sofkacovid/ui/pages/home_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Sofka Covid',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primaryColor: Colors.amber[900],
          fontFamily: 'Raleway',
          floatingActionButtonTheme: FloatingActionButtonThemeData(
            backgroundColor: Colors.amber[900],
          ),
        ),
        home: HomePage());
  }
}
