import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/all.dart';
import 'package:noname/models/movie.dart';
import 'package:noname/widgets/widgets.dart';

import '../repositories/movie_service.dart';

final moviesFutureProvider =
    FutureProvider.autoDispose<List<Movie>>((ref) async {
  // keeps state even when not being used
  ref.maintainState = true;

  // use watch instead of read if you expect variable to change
  final movieService = ref.read(movieServiceProvider); // movie_service object
  final movies = await movieService.getMovies(); // movie list
  return movies;
});

class Home extends ConsumerWidget {
  @override
  Widget build(BuildContext context, ScopedReader watch) {
    final Size screenSize = MediaQuery.of(context).size;
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: PreferredSize(
        preferredSize: Size(screenSize.width, 80.0),
        child: CustomAppBar(),
      ),
      backgroundColor: Color(0xff151c26),
      body: watch(moviesFutureProvider).when(
        error: (e, s) {
          return Text("error");
        },
        loading: () => Center(child: CircularProgressIndicator()),
        data: (movies) {
          return RefreshIndicator(
            onRefresh: () {
              return context.refresh(moviesFutureProvider);
            },
            child: GridView.extent(
              maxCrossAxisExtent: 300,
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
              childAspectRatio: 0.67,
              children: movies.map((movie) => _MovieBox(movie : movie)).toList(),
            ),
          );
        },
      ),
    );
  }
}

class _MovieBox extends StatelessWidget {
  final Movie movie;

  const _MovieBox({Key key, this.movie}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Image.network(
          movie.fullImageUrl,
          fit: BoxFit.cover,
          width: double.infinity,
        ),
      ],
    );
  }
}
/*
class _FrontBanner extends StatelessWidget {
  const _FrontBanner({
    Key key,
    @required this.text,
  }) : super(key: key);

  final String text;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
        child: Container(
          color: Colors.grey.shade200.withOpacity(0.5),
          height: 60,
          child: Center(
            child: Text(
              text,
              style: Theme.of(context).textTheme.bodyText2,
              textAlign: TextAlign.center,
            ),
          ),
        ),
      ),
    );
  }
}
*/
