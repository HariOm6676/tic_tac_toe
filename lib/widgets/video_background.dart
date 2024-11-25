import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class VideoBackground extends StatefulWidget {
  final String videoPath; // Path for mobile (asset-based)

  const VideoBackground({required this.videoPath, super.key});

  @override
  _VideoBackgroundState createState() => _VideoBackgroundState();
}

class _VideoBackgroundState extends State<VideoBackground> {
  late VideoPlayerController _controller;

  @override
  void initState() {
    super.initState();

    // Use different controllers for mobile and web
    if (kIsWeb) {
      // For web, load from a network-accessible path (ensure this path is correct for web)
      _controller = VideoPlayerController.networkUrl(
          Uri.parse('assets/video/background1.mp4')) // Network URL
        ..initialize().then((_) {
          _controller.setLooping(true);
          _controller.setVolume(0.0); // Mute the video
          _controller.play();
          setState(() {});
        });
    } else {
      // For mobile, load from assets
      _controller = VideoPlayerController.asset(widget.videoPath)
        ..initialize().then((_) {
          _controller.setLooping(true);
          _controller.setVolume(0.0); // Mute the video
          _controller.play();
          setState(() {});
        });
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox.expand(
      child: _controller.value.isInitialized
          ? FittedBox(
              fit: BoxFit.cover, // Ensure the video fills the screen
              child: SizedBox(
                width: _controller.value.size?.width ?? double.infinity,
                height: _controller.value.size?.height ?? double.infinity,
                child: VideoPlayer(_controller),
              ),
            )
          : const Center(child: CircularProgressIndicator()),
    );
  }
}
