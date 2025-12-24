import 'package:flutter/material.dart';
import 'package:flutter_webrtc/flutter_webrtc.dart';

class LocalVideoView extends StatelessWidget {
  final RTCVideoRenderer renderer;

  const LocalVideoView({super.key, required this.renderer});

  @override
  Widget build(BuildContext context) {
    return Positioned(
      right: 16,
      top: 40,
      width: 120,
      height: 160,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(12),
        child: RTCVideoView(
          renderer,
          mirror: true,
          objectFit: RTCVideoViewObjectFit.RTCVideoViewObjectFitCover,
        ),
      ),
    );
  }
}
