import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_riverpod/all.dart';
import 'package:noname/models/movie.dart';
import 'package:noname/widgets/widgets.dart';
import '../services/movie_service.dart';

final moviesFutureProvider =
    FutureProvider.autoDispose<Map<String, List>>((ref) async {
  // keeps state even when not being used
  ref.maintainState = true;

  // use watch instead of read if you expect variable to change
  final movieService = ref.read(movieServiceProvider); // popular_service object
  final popular =
      await movieService.getPopularMovies(); // popular movie list
  final nowPlaying = await movieService.getNowPlayingMovies();
  final upcoming = await movieService.getUpcomingMovies();
  final topRated = await movieService.getTopRatedMovies();

  Map movieMap = new Map<String, List>();
  movieMap['popular'] = popular;
  movieMap['nowPlaying'] = nowPlaying;
  movieMap['upcoming'] = upcoming;
  movieMap['topRated'] = topRated;

  return movieMap;
});

class Home extends ConsumerWidget {
  @override
  Widget build(BuildContext context, ScopedReader watch) {
    final Size screenSize = MediaQuery.of(context).size;
    return Scaffold(
      extendBodyBehindAppBar: false,
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
          return CustomScrollView(
            slivers: [
              SliverToBoxAdapter(
                child: ContentList(
                  title: 'Popular',
                  contentList: movies['popular'],
                ),
              ),
              SliverToBoxAdapter(
                child: ContentList(
                  title: 'Top Rated',
                  contentList: movies['topRated'],
                  isTopRated: true,
                ),
              ),
              SliverToBoxAdapter(
                child: ContentList(
                  title: 'Now Playing',
                  contentList: movies['nowPlaying'],
                ),
              ),
              SliverToBoxAdapter(
                child: ContentList(
                  title: 'Upcoming',
                  contentList: movies['upcoming'],
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
