import 'package:flutter_webrtc/flutter_webrtc.dart';

abstract class LocalDataSource {
  get peerConnection => null;

  Future<void> init();
  Future<RTCSessionDescription> createOffer();
  Future<RTCSessionDescription> createAnswer();
  Future<void> setLocalDescription(RTCSessionDescription desc);
  Future<void> setRemoteDescription(RTCSessionDescription desc);
  void addICECandidate(RTCIceCandidate candidate);
  void dispose();
}

class LocalDataSourceImpl implements LocalDataSource {
  MediaStream? _localStream;
  RTCPeerConnection? _peerConnection;

  MediaStream? get localStream => _localStream;
  RTCPeerConnection? get peerConnection => _peerConnection;

  @override
  Future<void> init() async {
    _localStream = await navigator.mediaDevices.getUserMedia({
      'audio': true,
      'video': true,
    });

    _peerConnection = await createPeerConnection({
      'iceServers': [
        {'urls': 'stun:stun.l.google.com:19302'},
      ],
    });

    for (var t in _localStream!.getTracks()) {
      _peerConnection!.addTrack(t, _localStream!);
    }
  }


  @override
  Future<RTCSessionDescription> createOffer() {
    return _peerConnection!.createOffer();
  }


  @override
  Future<RTCSessionDescription> createAnswer() async {
    return _peerConnection!.createAnswer();
  }


  @override
  Future<void> setLocalDescription(RTCSessionDescription desc) {
    return _peerConnection!.setLocalDescription(desc);
  }


  @override
  Future<void> setRemoteDescription(RTCSessionDescription desc) {
    return _peerConnection!.setRemoteDescription(desc);
  }


  @override
  void addICECandidate(RTCIceCandidate candidate) {
    _peerConnection!.addCandidate(candidate);
  }


  @override
  void dispose() {
    _localStream?.dispose();
    _peerConnection?.close();
  }
}
