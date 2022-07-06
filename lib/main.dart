import 'package:amifactory_test_app/widgets/movie_list_widget.dart';
import 'package:amifactory_test_app/widgets/ooops_widget.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'amifactory_test_app',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(fontFamily: 'Rubik'),
      home: const MovieListWidget(),
      routes: {
        '/error':(context) => OoopsWidget(),
      },
    );
  }
}
