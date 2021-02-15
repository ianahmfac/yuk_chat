import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:yuk_chat/screens/wrapper.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus.unfocus(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Yuk Chat!',
        theme: ThemeData(
          textTheme: GoogleFonts.josefinSansTextTheme(),
          brightness: Brightness.light,
          primarySwatch: Colors.indigo,
          primaryColorBrightness: Brightness.dark,
          accentColor: Colors.amber,
          textButtonTheme: TextButtonThemeData(
              style: TextButton.styleFrom(
            primary: Colors.indigo,
          )),
        ),
        darkTheme: ThemeData(
          textTheme:
              GoogleFonts.josefinSansTextTheme().apply(bodyColor: Colors.white),
          brightness: Brightness.dark,
          primarySwatch: Colors.blue,
          primaryColorBrightness: Brightness.dark,
          accentColor: Colors.amber,
          textButtonTheme: TextButtonThemeData(
              style: TextButton.styleFrom(
            primary: Colors.white,
          )),
        ),
        themeMode: ThemeMode.system,
        home: Wrapper(),
      ),
    );
  }
}
