import 'package:amifactory_test_app/app_colors.dart';
import 'package:amifactory_test_app/api/movie_api.dart';
import 'package:amifactory_test_app/domain/entity/movie.dart';
import 'package:amifactory_test_app/widgets/movie_card_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';

class MovieListWidget extends StatefulWidget {
  const MovieListWidget({Key? key}) : super(key: key);

  @override
  State<MovieListWidget> createState() => _MovieListWidgetState();
}

class _MovieListWidgetState extends State<MovieListWidget> {
  List movies = [];

  @override
  void initState() {
    super.initState();
    init();
  }

  Future init() async {
    final movies = await MovieApi.getMovies();
    setState(() {
      this.movies = movies;
    });
  }

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
      ),
      child: Scaffold(
        backgroundColor: AppColors.bgColor,
        body: Padding(
          padding: const EdgeInsets.only(left: 25, right: 25, top: 60),
          child: _buildMovieListGridView(),
        ),
      ),
    );
  }

  Widget _buildMovieListGridView() {
    return GridView.builder(
      itemCount: movies.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 1 / 2,
        mainAxisSpacing: 35,
        crossAxisSpacing: 24,
      ),
      itemBuilder: (BuildContext context, int index) {
        final movie = movies.elementAt(index);
        return _buildMovieGridTile(movie);
      },
    );
  }

  Widget _buildMovieGridTile(Movie movie) {
    const imdbStyle = TextStyle(
        color: Colors.white, fontSize: 20, fontWeight: FontWeight.w500);
    const imdbDividerStyle = TextStyle(
        color: Color(0xFFE2E2E2), fontSize: 20, fontWeight: FontWeight.w400);
    const imdbTenStyle = TextStyle(
        color: Color(0xFFE2E2E2), fontSize: 17.5, fontWeight: FontWeight.w400);
    const titleStyle = TextStyle(
        color: Colors.white, fontSize: 22.5, fontWeight: FontWeight.w500);

    return GestureDetector(
      onTap: () => openCountryCard(movie),
      child: GridTile(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 215,
              width: double.infinity,
              child: Image.network(
                movie.poster,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(height: 14),
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(bottom: 2),
                  child: SvgPicture.asset(
                    'assets/icon_star.svg',
                  ),
                ),
                RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                          text: ' ${movie.imdb_rating} ', style: imdbStyle),
                      const TextSpan(text: '/', style: imdbDividerStyle),
                      const TextSpan(text: '10', style: imdbTenStyle),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Text(
              movie.title,
              style: titleStyle,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }

  void openCountryCard(Movie movie) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => MovieCard(movie: movie),
      ),
    );
  }
}
