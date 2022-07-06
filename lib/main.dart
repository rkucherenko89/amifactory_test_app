import 'package:amifactory_test_app/widgets/movie_card_widget.dart';
import 'package:amifactory_test_app/widgets/movie_list_widget.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(fontFamily: 'Rubik'),
      home: const MovieListWidget(),
      initialRoute: '/movie_list_screen',
      routes: {
        '/movie_list_screen': (context) => const MovieListWidget(),
        // '/movie_list_screen/movie_details': (context) {
        //   final movie = ModalRoute.of(context)?.settings.arguments;
        //   return MovieCardWidget(movie: movie);
        // }
      },
    );
  }
}
