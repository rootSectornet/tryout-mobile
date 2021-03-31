import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class DetailVideoScreen extends StatefulWidget {
  final String urlVideo;

  const DetailVideoScreen({Key key, @required this.urlVideo}) : super(key: key);
  @override
  _DetailVideoScreenState createState() => _DetailVideoScreenState(urlVideo);
}

class _DetailVideoScreenState extends State<DetailVideoScreen> {
  final String urlVideo;
  VideoPlayerController _controller;
  Future<void> _initializeVideoPlayerFuture;

  _DetailVideoScreenState(this.urlVideo);

  @override
  void initState() {
    _controller = VideoPlayerController.network(this.urlVideo);
    _initializeVideoPlayerFuture = _controller.initialize();
    _controller.setLooping(true);
    _controller.setVolume(1.0);
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
      ),
      body: FutureBuilder(
          future: _initializeVideoPlayerFuture,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              return AspectRatio(
                aspectRatio: _controller.value.aspectRatio,
                child: VideoPlayer(_controller),
              );
            } else {
              return Center(
                child: CircularProgressIndicator(
                  backgroundColor: Colors.blue,
                ),
              );
            }
          }),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() {
            if (_controller.value.isPlaying) {
              _controller.pause();
            } else {
              _controller.play();
            }
          });
        },
        child: Icon(
          _controller.value.isPlaying ? Icons.pause : Icons.play_arrow,
        ),
      ),
    );
  }
}
