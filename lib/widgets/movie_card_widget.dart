import 'package:amifactory_test_app/app_colors.dart';
import 'package:amifactory_test_app/domain/entity/movie.dart';
import 'package:amifactory_test_app/min_to_hours.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class MovieCard extends StatefulWidget {
  final Movie movie;

  const MovieCard({
    Key? key,
    required this.movie,
  }) : super(key: key);

  @override
  State<MovieCard> createState() => _MovieCardState();
}

class _MovieCardState extends State<MovieCard> {
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
              stops: [0, 0.2, 0.8, 1],
            ),
          ),
          child: Image.network(movie.bg_picture),
        ),
        Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              movie.title,
              style: TextStyle(color: Colors.white),
            ),
            Text(
              '${movie.release_year}',
              style: TextStyle(color: Colors.white),
            ),
            Text(
              movie.description,
              style: TextStyle(color: Colors.white),
            ),
          ],
        )
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

    const style = TextStyle(color: Colors.white);

    return Column(
      children: [
        Row(
          children: [
            if (genres.isNotEmpty) ...[
              Text(genres, style: style),
              const SizedBox(
                height: 10,
                child: VerticalDivider(
                  color: Colors.white,
                ),
              ),
            ],
            Text(
              movie.mpa_rating,
              style: style,
            ),
            const SizedBox(
              height: 10,
              child: VerticalDivider(
                color: Colors.white,
              ),
            ),
            Text(
              MinToHours.minToHours(movie.duration),
              style: style,
            )
          ],
        ),
        RichText(
          text: TextSpan(
            children: [
              const TextSpan(text: 'Director: ', style: style),
              TextSpan(text: directors, style: style),
            ],
          ),
        ),
        RichText(
          text: TextSpan(
            children: [
              const TextSpan(text: 'Writers: ', style: style),
              TextSpan(text: writers, style: style),
            ],
          ),
        ),
        RichText(
          text: TextSpan(
            children: [
              const TextSpan(text: 'Stars: ', style: style),
              TextSpan(text: stars, style: style),
            ],
          ),
        ),
        Row(
          children: [
            Column(
              children: [
                Text('iMDb ratting', style: style),
                Row(
                  children: [
                    Icon(Icons.star, color: Colors.orange),
                    Text('${movie.imdb_rating} / 10', style: style),
                  ],
                )
              ],
            ),
            ElevatedButton.icon(
                style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all<Color>(
                        AppColors.trailerButtonColor)),
                onPressed: () {},
                icon: Icon(Icons.play_arrow),
                label: Text('Watch trailer'))
          ],
        ),
      ],
    );
  }
}
