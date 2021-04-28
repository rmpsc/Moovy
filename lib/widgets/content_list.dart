import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:noname/models/models.dart';
import 'package:noname/screens/movie_info_screen.dart';
import 'package:noname/theme.dart';
import 'package:route_transitions/route_transitions.dart';
import 'package:video_player/video_player.dart';
import 'package:noname/services/movie_service.dart';
import 'package:flutter/rendering.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';
import 'package:flutter/services.dart';

class MyHomePage extends StatefulWidget {
  final String movieKey;
  final String title;
  final String desc;
  MyHomePage({Key key, this.movieKey, this.title,this.desc}) : super(key: key);
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  YoutubePlayerController _controller;
  TextEditingController _idController;
  TextEditingController _seekToController;
  String title, desc;
  PlayerState _playerState;
  YoutubeMetaData _videoMetaData;
  double _volume = 100;
  bool _muted = false;
  bool _isPlayerReady = false;

  @override
  void initState() {
    title = widget.title;
    desc = widget.desc;
    super.initState();
    _controller = YoutubePlayerController(
      initialVideoId: widget.movieKey,
      flags: const YoutubePlayerFlags(
        mute: false,
        autoPlay: true,
        disableDragSeek: false,
        loop: false,
        isLive: false,
        forceHD: false,
        enableCaption: true,
      ),
    )..addListener(listener);
    _idController = TextEditingController();
    _seekToController = TextEditingController();
    _videoMetaData = const YoutubeMetaData();
    _playerState = PlayerState.unknown;
    _controller.setVolume(_volume.round());
  }

  void listener() {
    if (_isPlayerReady && mounted && !_controller.value.isFullScreen) {
      setState(() {
        _playerState = _controller.value.playerState;
        _videoMetaData = _controller.metadata;
      });
    }
  }

  @override
  void deactivate() {
    // Pauses video while navigating to next page.
    _controller.pause();
    super.deactivate();
  }

  @override
  void dispose() {
    _controller.dispose();
    _idController.dispose();
    _seekToController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: primaryColor,
        appBar: AppBar(
          title: Text(
            title,
            style: TextStyle(fontSize: 32, color: secondaryColor),),
          backgroundColor: primaryColor,
          elevation: 1,
          leading: IconButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            icon: Icon(
              Icons.arrow_back,
              color: secondaryColor,
            ),
          ),
        ),
    body: Container(
      color: primaryColor,
        child: YoutubePlayerBuilder(
            onExitFullScreen: () {
              // The player forces portraitUp after exiting fullscreen. This overrides the behaviour.
              SystemChrome.setPreferredOrientations(DeviceOrientation.values);
            },
            player: YoutubePlayer(
              controller: _controller,
              showVideoProgressIndicator: true,
              progressIndicatorColor: Colors.blueAccent,
              topActions: <Widget>[
                const SizedBox(width: 8.0),
                Expanded(
                  child: Text(
                    _controller.metadata.title,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 18.0,
                    ),
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                  ),
                ),
                IconButton(
                  icon: const Icon(
                    Icons.settings,
                    color: Colors.white,
                    size: 25.0,
                  ),
                ),
              ],
              onReady: () {
                _isPlayerReady = true;
              },
            ),
            builder: (context, player) => Scaffold(
              backgroundColor: primaryColor,
              body:
                  ListView(
                    children: [
                      player,
                      Text(
                        desc,
                        style: TextStyle(fontSize: 16, color: secondaryColor),
                      )
                    ]
                  )
            )
        )));
  }
}
/*class VideoPlayerScreen extends StatefulWidget {
  final String movieKey;
  VideoPlayerScreen({Key key, this.movieKey}) : super(key: key);

  @override
  _VideoPlayerScreenState createState() => _VideoPlayerScreenState();
}

class _VideoPlayerScreenState extends State<VideoPlayerScreen> {
  VideoPlayerController _controller;
  Future<void> _initializeVideoPlayerFuture;
  @override
  void initState() {
    // Create and store the VideoPlayerController. The VideoPlayerController
    // offers several different constructors to play videos from assets, files,
    // or the internet.
    _controller = VideoPlayerController.network(
      "youtube.com/watch?v=ciNWLWTC0aY",
    );

    // Initialize the controller and store the Future for later use.
    _initializeVideoPlayerFuture = _controller.initialize();

    // Use the controller to loop the video.
    _controller.setLooping(true);

    super.initState();
  }

  @override
  void dispose() {
    // Ensure disposing of the VideoPlayerController to free up resources.
    _controller.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 300,
      // Use a FutureBuilder to display a loading spinner while waiting for the
      // VideoPlayerController to finish initializing.
      child: FutureBuilder(

        future: _initializeVideoPlayerFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            WidgetsBinding.instance.addPostFrameCallback((_) {
              _controller.play();
            });
            // If the VideoPlayerController has finished initialization, use
            // the data it provides to limit the aspect ratio of the video.
            return AspectRatio(
              aspectRatio: _controller.value.aspectRatio,
              // Use the VideoPlayer widget to display the video.
              child: VideoPlayer(_controller),
            );
          } else {
            // If the VideoPlayerController is still initializing, show a
            // loading spinner.
            return Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}*/

class ContentList extends StatelessWidget {
  final String title;
  final List<Movie> contentList;
  final bool isTopRated;

  const ContentList({
    Key key,
    @required this.title,
    @required this.contentList,
    this.isTopRated = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //VideoPlayerScreen videoPlayer = new VideoPlayerScreen();
    MyHomePage m = new MyHomePage();
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: PrimaryText(
              text: title,
            ),
          ),
          Container(
            height: isTopRated ? 320.0 : 220.0,
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(
                vertical: 12.0,
                horizontal: 16.0,
              ),
              scrollDirection: Axis.horizontal,
              itemCount: contentList.length,
              itemBuilder: (BuildContext context, int index) {
                final Movie content = contentList[index];
                return GestureDetector(
                  onLongPress: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context)=>MyHomePage(movieKey: 'odM92ap8_c0',
                      title: contentList[index].title, desc: contentList[index].overview,)));
                    /*showDialog(context: context,
                        builder: (BuildContext context)
                        {
                          return new AlertDialog(
                            title: Text(contentList[index].title,
                                style: TextStyle(color: Colors.white)),
                            content: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(contentList[index].overview,
                                    style: TextStyle(color: Colors.white)),
                                SingleChildScrollView(child: ConstrainedBox(
                                  constraints: BoxConstraints(),
                                  child: m,
                                ),),
                              ],
                            ),
                            actions: [
                              FlatButton(
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                  child: Text("Close")),
                            ],
                            backgroundColor: primaryColor,
                          );
                        });*/
                  },
                  onTap: () {
                    Navigator.push(
                      context,
                      PageRouteTransition(
                        animationType: AnimationType.fade,
                        builder: (context) =>
                            MovieInfoScreen(movie: contentList[index]),
                      ),
                    );
                  },
                  child: Stack(children: [
                  // Hero widget for movie img animation
                   Hero(
                    tag: 'movie-img-${content.fullImageUrl}',
                    child: Container(
                      height: isTopRated ? 400.0 : 200.0,
                      width: isTopRated ? 200.0 : 130.0,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: NetworkImage(content.fullImageUrl),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                    Positioned(top:0,child:(MaterialButton(  
                        minWidth: 2.0,
                        height: 5.0,
                        onPressed: null,
                        disabledColor: Color(0xffF8A99F),
                        disabledTextColor: Colors.black,
                        child: Text(content.voteAverage.toString()),
                        padding: EdgeInsets.all(10),
                        shape: CircleBorder(),
                      )))                      ,
                  ],)
                  
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
