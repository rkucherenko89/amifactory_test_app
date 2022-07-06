import 'package:amifactory_test_app/app_colors.dart';
import 'package:amifactory_test_app/domain/entity/movie.dart';
import 'package:amifactory_test_app/min_to_hours.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';

class MovieCardWidget extends StatefulWidget {
  final Movie movie;

  const MovieCardWidget({
    Key? key,
    required this.movie,
  }) : super(key: key);

  @override
  State<MovieCardWidget> createState() => _MovieCardWidgetState();
}

class _MovieCardWidgetState extends State<MovieCardWidget> {
  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
        value: const SystemUiOverlayStyle(
          statusBarColor: Colors.transparent,
        ),
        child: Scaffold(
          backgroundColor: AppColors.bgColor,
          body: Column(
            children: [
              _buildTopPart(),
              _buildBottomPart(),
            ],
          ),
        ));
  }

  Widget _buildTopPart() {
    const titleStyle = TextStyle(
      color: Colors.white,
      fontFamily: 'KronaOne',
      fontWeight: FontWeight.w400,
      fontSize: 35,
    );

    const yearStyle = TextStyle(
      color: Colors.white,
      fontFamily: 'KronaOne',
      fontWeight: FontWeight.w700,
      fontSize: 22.5,
    );

    final Movie movie = widget.movie;
    return Stack(
      alignment: AlignmentDirectional.bottomStart,
      children: [
        Container(
          foregroundDecoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Colors.black.withOpacity(0.5),
                Colors.transparent,
                Colors.transparent,
                AppColors.bgColor,
              ],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              stops: [0, 0.2, 0.6, 1],
            ),
          ),
          child: FadeInImage(
              image: NetworkImage(
                movie.bg_picture,
              ),
              placeholder: AssetImage('assets/download_horizontal.png')),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                movie.title,
                style: titleStyle,
              ),
              const SizedBox(
                height: 4,
              ),
              Text(
                '(${movie.release_year})',
                style: yearStyle,
              ),
              const SizedBox(
                height: 10,
              ),
            ],
          ),
        ),
        Positioned(
          top: 27,
          left: 18,
          child: IconButton(
            onPressed: () => Navigator.of(context).pop(),
            padding: EdgeInsets.all(0),
            icon: Icon(
              Icons.arrow_back,
              color: Colors.white,
              size: 35,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildBottomPart() {
    final Movie movie = widget.movie;

    final String genres =
        movie.genres.map((e) => e['title']).toList().join(', ');

    final String directors = movie.directors
        .map((director) => '${director['first_name']} ${director['last_name']}')
        .toList()
        .join(', ');

    final String writers = movie.writers
        .map((writer) => '${writer['first_name']} ${writer['last_name']}')
        .toList()
        .join(', ');

    final String stars = movie.stars
        .map((star) => '${star['first_name']} ${star['last_name']}')
        .toList()
        .join(', ');

    const descriptionStyle = TextStyle(
      color: Colors.white,
      fontWeight: FontWeight.w400,
      fontSize: 20,
    );

    const genresStyle = TextStyle(
      color: Colors.white,
      fontWeight: FontWeight.w500,
      fontSize: 20,
    );

    const professionStyle = TextStyle(
      color: Color(0xFFE2E2E2),
      fontWeight: FontWeight.w400,
      fontSize: 20,
    );

    const namesStyle = TextStyle(
      color: Colors.white,
      fontWeight: FontWeight.w500,
      fontSize: 20,
    );

    const imdbRatingStyle = TextStyle(
      color: Color(0xFFE2E2E2),
      fontWeight: FontWeight.w500,
      fontSize: 20,
    );

    const imdbStyle = TextStyle(
      color: Colors.white,
      fontWeight: FontWeight.w500,
      fontSize: 35,
    );

    const imdbDividerStyle = TextStyle(
      color: Color(0xFFE2E2E2),
      fontSize: 22.5,
      fontWeight: FontWeight.w400,
    );

    const imdbTenStyle = TextStyle(
      color: Color(0xFFE2E2E2),
      fontSize: 20,
      fontWeight: FontWeight.w400,
    );

    const buttonStyle = TextStyle(
      color: Colors.white,
      fontSize: 17.5,
      fontWeight: FontWeight.w700,
    );

    return Expanded(
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              movie.description,
              style: descriptionStyle,
            ),
            const SizedBox(height: 24),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  if (genres.isNotEmpty) ...[
                    Text(genres, style: genresStyle),
                    const SizedBox(
                      height: 10,
                      child: VerticalDivider(
                        color: Colors.white,
                      ),
                    ),
                  ],
                  Text(
                    movie.mpa_rating,
                    style: genresStyle,
                  ),
                  const SizedBox(
                    height: 10,
                    child: VerticalDivider(
                      color: Colors.white,
                    ),
                  ),
                  Text(
                    MinToHours.minToHours(movie.duration),
                    style: genresStyle,
                  )
                ],
              ),
            ),
            const SizedBox(height: 24),
            RichText(
              text: TextSpan(
                children: [
                  const TextSpan(text: 'Director: ', style: professionStyle),
                  TextSpan(text: directors, style: namesStyle),
                ],
              ),
            ),
            RichText(
              text: TextSpan(
                children: [
                  const TextSpan(text: 'Writers: ', style: professionStyle),
                  TextSpan(text: writers, style: namesStyle),
                ],
              ),
            ),
            RichText(
              text: TextSpan(
                children: [
                  const TextSpan(text: 'Stars: ', style: professionStyle),
                  TextSpan(text: stars, style: namesStyle),
                ],
              ),
            ),
            const SizedBox(height: 40),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  children: [
                    const Text('iMDb ratting', style: imdbRatingStyle),
                    Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(bottom: 2),
                          child: SvgPicture.asset(
                            'assets/icon_star.svg',
                            height: 20,
                          ),
                        ),
                        RichText(
                          text: TextSpan(
                            children: [
                              TextSpan(
                                  text: ' ${movie.imdb_rating}',
                                  style: imdbStyle),
                              const TextSpan(
                                  text: ' /', style: imdbDividerStyle),
                              const TextSpan(text: '10', style: imdbTenStyle),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                ElevatedButton.icon(
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all<Color>(
                        AppColors.trailerButtonColor),
                    fixedSize:
                        MaterialStateProperty.all<Size>(const Size(180, 48)),
                  ),
                  onPressed: () {},
                  icon: const Icon(Icons.play_arrow),
                  label: const Text('Watch trailer', style: buttonStyle),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
