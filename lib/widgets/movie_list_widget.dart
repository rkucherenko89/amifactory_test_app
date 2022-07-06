import 'package:amifactory_test_app/app_colors.dart';
import 'package:amifactory_test_app/api/movie_api.dart';
import 'package:amifactory_test_app/check_resource_availability.dart';
import 'package:amifactory_test_app/domain/entity/movie.dart';
import 'package:amifactory_test_app/widgets/movie_card_widget.dart';
import 'package:amifactory_test_app/widgets/ooops_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';

class MovieListWidget extends StatefulWidget {
  const MovieListWidget({Key? key}) : super(key: key);

  @override
  State<MovieListWidget> createState() => _MovieListWidgetState();
}

class _MovieListWidgetState extends State<MovieListWidget> {
  final controller = ScrollController();
  int page = 1;
  bool hasMore = true;
  List movies = [];
  bool isOnline = true;

  @override
  void initState() {
    checkInternet();
    if (isOnline) {
      controller.addListener(() {
        if (controller.offset > controller.position.maxScrollExtent * 0.8) {
          if (hasMore) {
            fetch();
          }
        }
      });
      init();
    }
    super.initState();
  }

  Future fetch() async {
    final newMovies = await MovieApi.getMovies(page);
    setState(() {
      if (hasMore) {
        page++;
        movies.addAll(newMovies);
      }
      if (newMovies.length < movies.length) {
        hasMore = false;
      }
    });
  }

  Future checkInternet() async {
    final isOnline = await CheckResourceAvailability.hasNetwork();
    setState(() {
      this.isOnline = isOnline;
    });
  }

  Future init() async {
    final movies = await MovieApi.getMovies();
    setState(() {
      this.movies.addAll(movies);
    });
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  void openMovieCard(Movie movie) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => MovieCardWidget(movie: movie),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
      ),
      child: !isOnline
          ? OoopsWidget()
          : Scaffold(
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
      controller: controller,
      itemCount: movies.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 1 / 2,
        mainAxisSpacing: 35,
        crossAxisSpacing: 24,
      ),
      padding: const EdgeInsets.only(),
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
      onTap: () => openMovieCard(movie),
      child: GridTile(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 215,
              width: double.infinity,
              child: FadeInImage(
                  image: NetworkImage(
                    movie.poster,
                  ),
                  placeholder: AssetImage('assets/download.png')),
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
}
