import 'package:socket_io_client/socket_io_client.dart';

class ApiSignalingDatasource {
  final Socket socket;
  ApiSignalingDatasource(this.socket);

  void connect() => socket.connect();

  void joinRoom(String roomID) {
    socket.emit('join-room', {'roomID': roomID});
  }

  // void leaveRoom(String roomID) {
  //   socket.emit('leave-room', {'roomID': roomID});
  // }

  void sendOffer(String roomID, Map<String, dynamic> offer) {
    socket.emit('offer', {'roomID': roomID, 'offer': offer});
  }

  void sendAnswer(String roomID, Map<String, dynamic> answer) {
    socket.emit('answer', {'roomID': roomID, 'answer': answer});
  }

  void sendICECandidate(String roomID, Map<String, dynamic> candidate) {
    socket.emit('candidate', {'roomID': roomID, 'candidate': candidate});
  }

  void onOffer(Function(Map<String, dynamic>) onOffer) {
    socket.on('offer', (data) => onOffer(data));
  }

  void onAnswer(Function(Map<String, dynamic>) onAnswer) {
    socket.on('answer', (data) => onAnswer(data));
  }

  void onCandidate(String roomID, Function(Map<String, dynamic>) onCandidate) {
    socket.on('candidate', (data) => onCandidate(data));
  }

  void disconnect() => socket.disconnect();
}
