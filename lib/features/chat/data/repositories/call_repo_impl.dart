import 'dart:developer';

import 'package:client/features/chat/data/datasource/api_signaling_datasource.dart';
import 'package:client/features/chat/data/datasource/api_webrtc_datasource.dart';
import 'package:client/features/chat/domain/repositories/call_repo.dart';
import 'package:flutter_webrtc/flutter_webrtc.dart';

class CallRepositoryImpl implements CallRepository {
  final LocalDataSource webrtc;
  final ApiSignalingDatasource signaling;

  CallRepositoryImpl(this.webrtc, this.signaling);
  @override
  Future<void> initialize(String roomId) async {
    try {
      //Init
      await webrtc.init();
      //Connect
      signaling.connect();
      signaling.joinRoom(roomId);
      
      //Offer
      signaling.onOffer((offer) async {
        await webrtc.setRemoteDescription(
          RTCSessionDescription(offer['sdp'], offer['type']),
        );

        final answer = await webrtc.createAnswer();
        await webrtc.setLocalDescription(answer);

        signaling.sendAnswer(roomId, answer.toMap());
      });
      //Answer
      signaling.onAnswer((answer) async {
        await webrtc.setRemoteDescription(
          RTCSessionDescription(answer['sdp'], answer['type']),
        );
      });

      //RemoteIceCandidate
      signaling.onCandidate(roomId, (candidate) {
        webrtc.addICECandidate(
          RTCIceCandidate(
            candidate['candidate'],
            candidate['sdpMid'],
            candidate['sdpMLineIndex'],
          ),
        );
      });

      //LocalIceCandidate
      webrtc.peerConnection!.onIceCandidate = (candidate) {
        signaling.sendICECandidate(roomId, candidate!.toMap());
      };
    } catch (e) {
      log(e.toString());
    }
  }

  @override
  Future<void> startCall(String roomId) async {
    try {
      final offer = await webrtc.createOffer();
      await webrtc.setLocalDescription(offer);

      signaling.sendOffer(roomId, offer.toMap());
    } catch (e) {
      log(e.toString());
    }
  }

  @override
  Future<void> endCall(String roomId) async {
    signaling.disconnect();
    webrtc.dispose();
  }
}
