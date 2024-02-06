import 'package:black_coffer/VideoURL.dart';
import 'package:black_coffer/widgets/searchbar.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:video_player/video_player.dart';

class VideoPlayerScreen extends StatefulWidget {
  final String videoUrl, title, name;

  VideoPlayerScreen(
      {required this.videoUrl, required this.title, required this.name});

  @override
  _VideoPlayerScreenState createState() => _VideoPlayerScreenState();
}

class _VideoPlayerScreenState extends State<VideoPlayerScreen> {
  late VideoPlayerController _controller;

  String _videoDuration(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    final hours = twoDigits(duration.inHours);
    final minutes = twoDigits(duration.inMinutes.remainder(60));
    final seconds = twoDigits(duration.inSeconds.remainder(60));

    return [
      if (duration.inHours > 0) hours,
      minutes,
      seconds,
    ].join(":");
  }

  @override
  void initState() {
    super.initState();

    _controller = VideoPlayerController.network(widget.videoUrl)
      ..initialize().then((_) {
        // Ensure the first frame is shown and play the video
        setState(() {
          // Add the following line to play the video automatically when it's initialized
          _controller.play();
        });
      });

    // Add a listener to handle video completion
    _controller.addListener(() {
      if (_controller.value.position >= _controller.value.duration) {
        // Video has reached its end
        // You can choose to loop the video, pause it, or take any other action here
        _controller
            .seekTo(Duration(seconds: 0)); // Restart the video when it ends
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: _controller.value.isInitialized
            ? Column(
                children: [
                  searchbar(),
                  SizedBox(height: 20),
                  SizedBox(
                    height: 200,
                    child: VideoPlayer(_controller),
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      ValueListenableBuilder(
                          valueListenable: _controller,
                          builder: (context, VideoPlayerValue value, child) {
                            return Text(
                              _videoDuration(value.duration),
                              style:
                                  TextStyle(color: Colors.black, fontSize: 14),
                            );
                          }),
                      Expanded(
                          child: SizedBox(
                        height: 10,
                        child: VideoProgressIndicator(
                          _controller,
                          allowScrubbing: true,
                          padding: EdgeInsets.symmetric(horizontal: 12),
                        ),
                      )),
                      Text(
                        _videoDuration(_controller.value.duration),
                        style: TextStyle(color: Colors.black, fontSize: 14),
                      )
                    ],
                  ),
                  IconButton(
                      onPressed: () => _controller.value.isPlaying
                          ? _controller.pause()
                          : _controller.play(),
                      icon: Icon(_controller.value.isPlaying
                          ? Icons.pause
                          : Icons.play_arrow)),
                  SizedBox(
                    height: 20,
                  ),
                  Text(widget.title,
                      style: TextStyle(
                          fontFamily: GoogleFonts.rubik().fontFamily,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                          fontSize: 17)),
                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Icon(Icons.thumb_up_sharp),
                      Icon(Icons.thumb_down_sharp),
                      Icon(Icons.share)
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Text(
                        "Like",
                        style: TextStyle(fontSize: 10),
                      ),
                      Text("Dislike", style: TextStyle(fontSize: 10)),
                      Text("Share", style: TextStyle(fontSize: 10))
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("1M views",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontFamily: GoogleFonts.rubik().fontFamily,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                            fontSize: 11,
                          )),
                      SizedBox(
                        width: 10,
                      ),
                      Container(
                        height: 5,
                        width: 5,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: Colors.black),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Text("4 hours ago",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontFamily: GoogleFonts.rubik().fontFamily,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                            fontSize: 11,
                          )),
                    ],
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 20),
                    child: Container(
                      alignment: Alignment.topLeft,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Text(widget.name,
                              style: TextStyle(
                                fontFamily: GoogleFonts.rubik().fontFamily,
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                                fontSize: 14,
                              )),
                          Text("View all videos",
                              style: TextStyle(
                                fontFamily: GoogleFonts.rubik().fontFamily,
                                fontWeight: FontWeight.bold,
                                color: Colors.blue,
                                fontSize: 14,
                              )),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 20),
                    child: Container(
                      alignment: Alignment.topLeft,
                      child: Text("Comments",
                          style: TextStyle(
                            fontFamily: GoogleFonts.rubik().fontFamily,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                            fontSize: 14,
                          )),
                    ),
                  )
                ],
              )
            : CircularProgressIndicator(), // Show loading indicator until video is initialized
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }
}
