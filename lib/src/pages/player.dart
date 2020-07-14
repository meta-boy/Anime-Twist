// Flutter imports:

// Flutter imports:
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

// Package imports:
import 'package:relative_scale/relative_scale.dart';
import 'package:time/time.dart';
import 'package:video_player_header/video_player_header.dart';
import 'package:wakelock/wakelock.dart';

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

class _PlayerPageState extends State<PlayerPage> with RelativeScale {
  VideoPlayerController _controller;

  bool showUI = true;
  double sliderValue = 0;
  double endValue = 0;
  DateTime whenStarted;
  bool isBuffering = false;

  @override
  void didChangeDependencies() {
    initRelativeScaler(context);
    super.didChangeDependencies();
  }

  @override
  void initState() {
    var headers = {
      'Referer': 'https://twist.moe/a/${widget.slug}/${widget.ep}'
    };
    super.initState();
    _controller =
        VideoPlayerController.network(widget.videoUrl, headers: headers)
          ..initialize().then((_) {
            endValue = _controller.value.duration.inSeconds.toDouble();
            _controller.addListener(() {
              setState(() {
                sliderValue = _controller.value.position.inSeconds.toDouble();
                isBuffering = _controller.value.isBuffering;
              });
            });

            setState(() {
              whenStarted = DateTime.now();
            });
          });
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    Wakelock.disable();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: _controller.value.initialized
          ? Stack(
              children: [
                SafeArea(
                  child: OrientationBuilder(
                    builder: (context, orientation) {
                      bool isPortrait = orientation == Orientation.portrait;
                      SystemChrome.setEnabledSystemUIOverlays(
                          isPortrait ? SystemUiOverlay.values : []);
                      return Align(
                        alignment:
                            isPortrait ? Alignment.topCenter : Alignment.center,
                        child: Container(
                          height: isPortrait
                              ? screenWidth * 1 / _controller.value.aspectRatio
                              : screenHeight,
                          width: isPortrait
                              ? screenWidth
                              : screenHeight * _controller.value.aspectRatio,
                          child: Stack(
                            children: [
                              Positioned.fill(
                                child: GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      showUI = !showUI;
                                    });
                                  },
                                  child: AspectRatio(
                                    aspectRatio: _controller.value.aspectRatio,
                                    child: VideoPlayer(_controller),
                                  ),
                                ),
                              ),
                              isBuffering
                                  ? Positioned.fill(
                                      child: Container(
                                        color: Colors.black.withOpacity(0.5),
                                        child: Center(
                                          child: CircularProgressIndicator(),
                                        ),
                                      ),
                                    )
                                  : Container(),
                              showUI
                                  ? Positioned(
                                      bottom: -1,
                                      left: -1,
                                      right: -1,
                                      child: Container(
                                        color: Colors.black.withOpacity(0.7),
                                        width: screenWidth,
                                        child: Padding(
                                          padding: const EdgeInsets.only(
                                              left: 8.0, right: 8.0),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            children: [
                                              IconButton(
                                                icon: Icon(
                                                  _controller.value.isPlaying
                                                      ? Icons.pause
                                                      : Icons.play_arrow,
                                                  color: Colors.white,
                                                ),
                                                onPressed: () {
                                                  setState(
                                                    () {
                                                      if (_controller
                                                          .value.isPlaying) {
                                                        _controller.pause();
                                                        Wakelock.disable();
                                                      } else {
                                                        _controller.play();
                                                        Wakelock.enable();
                                                      }
                                                    },
                                                  );
                                                },
                                              ),
                                              Expanded(
                                                child: CupertinoSlider(
                                                  max: endValue,
                                                  min: 0,
                                                  value: sliderValue,
                                                  onChanged: (value) async {
                                                    await _controller
                                                        .seekTo(value.seconds);
                                                  },
                                                ),
                                              ),
                                              IconButton(
                                                icon: Icon(
                                                  Icons.screen_rotation,
                                                  color: Colors.white,
                                                ),
                                                onPressed: () {
                                                  setState(
                                                    () async {
                                                      isPortrait
                                                          ? await SystemChrome
                                                              .setPreferredOrientations(
                                                              [
                                                                DeviceOrientation
                                                                    .landscapeRight,
                                                                DeviceOrientation
                                                                    .landscapeLeft,
                                                              ],
                                                            )
                                                          : SystemChrome
                                                              .setPreferredOrientations(
                                                              [
                                                                DeviceOrientation
                                                                    .portraitUp
                                                              ],
                                                            );
                                                    },
                                                  );
                                                },
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    )
                                  : Container(),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
                showUI
                    ? Positioned(
                        top: -1,
                        left: -1,
                        right: -1,
                        child: SafeArea(
                          child: Container(
                            color: Colors.black.withOpacity(0.7),
                            child: Row(
                              children: [
                                IconButton(
                                    icon: Icon(
                                      Icons.arrow_back,
                                      color: Colors.white,
                                    ),
                                    onPressed: () {
                                      Navigator.pop(context);
                                    })
                              ],
                            ),
                          ),
                        ),
                      )
                    : Container(),
              ],
            )
          : Center(child: CircularProgressIndicator()),
    );
  }
}
