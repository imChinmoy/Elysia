import 'package:client/features/chat/data/models/call_model.dart';
import 'package:client/features/chat/presentation/state/video/provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_webrtc/flutter_webrtc.dart';
import '../widgets/local_video_view.dart';
import '../widgets/remote_video_view.dart';
import '../widgets/call_controls.dart';

class CallScreen extends ConsumerStatefulWidget {
  final String roomId;
  const CallScreen({super.key, required this.roomId});

  @override
  ConsumerState<CallScreen> createState() => _CallScreenState();
}

class _CallScreenState extends ConsumerState<CallScreen> {
  late RTCVideoRenderer localRenderer;
  late RTCVideoRenderer remoteRenderer;

  @override
  void initState() {
    super.initState();

    localRenderer = RTCVideoRenderer();
    remoteRenderer = RTCVideoRenderer();

    _initRenderers();

    Future.microtask(() {
      ref.read(callProvider.notifier).init(widget.roomId);
    });
  }

  Future<void> _initRenderers() async {
    await localRenderer.initialize();
    await remoteRenderer.initialize();

    final webrtc = ref.read(localDataSourceProvider);

    localRenderer.srcObject = webrtc.localStream;

    webrtc.peerConnection?.onTrack = (event) {
      remoteRenderer.srcObject = event.streams.first;
    };
  }

  @override
  void dispose() {
    localRenderer.dispose();
    remoteRenderer.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final callState = ref.watch(callProvider);

    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          RemoteVideoView(renderer: remoteRenderer),

          if (callState.status != CallStatus.idle)
            LocalVideoView(renderer: localRenderer),

          CallControls(
            onEnd: () {
              ref.read(callProvider.notifier).end(widget.roomId);
              Navigator.pop(context);
            },
          ),


          if (callState.hasError)
            Center(
              child: Text(
                callState.error!,
                style: const TextStyle(color: Colors.red),
              ),
            ),
        ],
      ),
      floatingActionButton: callState.isReady
          ? FloatingActionButton(
              child: const Icon(Icons.call),
              onPressed: () {
                ref.read(callProvider.notifier).start(widget.roomId);
              },
            )
          : null,
    );
  }
}
