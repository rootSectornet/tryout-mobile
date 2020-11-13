import 'package:flutter/material.dart';
import 'package:skripsi/parent/provider.dart';
import 'package:skripsi/routes/routes.dart';

void main() {
  runApp(MyApp());
}

// ignore: must_be_immutable
class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  var appState = new AppState(0);

  @override
  Widget build(BuildContext context) {
    return Provider(
          data: appState,
          child: MaterialApp(
            title: 'Skripsi',
            debugShowCheckedModeBanner: false,
            theme: ThemeData(
              fontFamily: 'SFProDisplay',
              primarySwatch: Colors.blue,
              visualDensity: VisualDensity.adaptivePlatformDensity,
            ),
            routes: routes,
          ),
    );
  }
}
class AppState extends ValueNotifier {
  AppState(value) : super(value);
}