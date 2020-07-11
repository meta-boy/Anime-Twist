// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:video_player_header/video_player_header.dart';

class PlayerPage extends StatefulWidget {
  final String videoUrl;
  final String slug;
  final int ep;

  const PlayerPage({
    Key key,
    @required this.videoUrl,
    @required this.slug,
    @required this.ep,
  }) : super(key: key);
  @override
  _PlayerPageState createState() => _PlayerPageState();
}

class _PlayerPageState extends State<PlayerPage> {
  VideoPlayerController _controller;
  @override
  void initState() {
    var headers = {
      'Referer': 'https://twist.moe/a/${widget.slug}/${widget.ep}'
    };
    print(headers);
    super.initState();
    _controller =
        VideoPlayerController.network(widget.videoUrl, headers: headers)
          ..initialize().then((_) {
            setState(() {});
          });
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    print(widget.videoUrl);
    return Scaffold(
      body: Center(
        child: _controller.value.initialized
            ? AspectRatio(
                aspectRatio: _controller.value.aspectRatio,
                child: VideoPlayer(_controller),
              )
            : Center(child: CircularProgressIndicator()),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() {
            _controller.value.isPlaying
                ? _controller.pause()
                : _controller.play();
          });
        },
        child: Icon(
          _controller.value.isPlaying ? Icons.pause : Icons.play_arrow,
        ),
      ),
    );
  }
}
