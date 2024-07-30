import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_webrtc/flutter_webrtc.dart';
import 'package:medislot/ui/components/components.dart';
import 'package:medislot/ui/pages/video_call/constants.dart';
import 'package:web_socket_channel/io.dart';

import '../../helpers/i18n/resources.dart';

class VideoCallPage extends StatefulWidget {
  final String appointmentId;
  const VideoCallPage({Key? key, required this.appointmentId})
      : super(key: key);

  @override
  State<VideoCallPage> createState() => _VideoCallPageState();
}

class _VideoCallPageState extends State<VideoCallPage> {
  String get _appointmentId => widget.appointmentId;

  MediaStream? _localStream;
  MediaStream? _remoteStream;

  late IOWebSocketChannel _channel;

  late RTCVideoRenderer? _localRenderer;
  late RTCVideoRenderer? _remoteRenderer;

  RTCPeerConnection? _peerConnection;

  bool _inCalling = false;
  bool _isMicEnabled = true;
  bool _isCamEnabled = true;

  void toggleMicrophone() {
    final audioStreamTrack = _localRenderer?.srcObject!
        .getTracks()
        .where((element) => element.kind == 'audio')
        .first;
    if (audioStreamTrack!.enabled) {
      audioStreamTrack.enabled = false;
      _isMicEnabled = false;
    } else {
      audioStreamTrack.enabled = true;
      _isMicEnabled = true;
    }
    setState(() {});
  }

  void toogleCam() {
    final camStreamTrack = _localRenderer!.srcObject!
        .getTracks()
        .where((element) => element.kind == 'video')
        .first;

    if (camStreamTrack.enabled) {
      camStreamTrack.enabled = false;
      _isCamEnabled = false;
    } else {
      camStreamTrack.enabled = true;
      _isCamEnabled = true;
    }
    setState(() {});
  }

  Future<void> initRenderers() async {
    await _localRenderer!.initialize();
    await _remoteRenderer!.initialize();
  }

  Future<void> getLocalUserMedia() async {
    MediaStream localStream =
        await navigator.mediaDevices.getUserMedia(mediaConstraints);
    _localRenderer!.srcObject = localStream;
    _localStream = localStream;
    _inCalling = true;
    setState(() {});
  }

  void connectWebSocket() {
    try {
      _channel.stream.listen((message) async {
        final _message = jsonDecode(message);
        debugPrint('message WSS:: ${_message['type']}');

        if (_message['type'] == 'start') {
          await _makeCall();
        }

        if (_message['type'] == 'offer') {
          await _setRemoteAndLocalDescription(_message);
        }

        if (_message['type'] == 'candidate') {
          await _addCandidate(_message);
        }

        if (_message['type'] == 'stop') {
          _showEndCallDialog();
        }
      });

      final intialMessage = {
        'type': 'connect',
        'appointment': _appointmentId,
        'role': 'patient',
      };

      _channel.sink.add(jsonEncode(intialMessage));
    } on Exception catch (_) {
      debugPrint('CATCH connectWebScoket');
    }
  }

  Future<void> _addCandidate(_message) async {
    try {
      final remoteDescription = await _peerConnection?.getRemoteDescription();
      if (remoteDescription != null) {
        await _peerConnection!.addCandidate(RTCIceCandidate(
          _message['candidate']['candidate'],
          _message['candidate']['sdpMid'],
          _message['candidate']['sdpMLineIndex'],
        ));
        debugPrint('peerConnection :: type candidate');
      }
    } on Exception catch (_) {
      debugPrint('CATCH _addCandidate');
    }
  }

  Future<void> _setRemoteAndLocalDescription(_message) async {
    try {
      final _type = _message['offer']['type'];
      final _sdp = _message['offer']['sdp'];
      await _peerConnection
          ?.setRemoteDescription(RTCSessionDescription(_sdp, _type))
          .then((value) async {
        final _answer = await _peerConnection!.createAnswer();

        await _peerConnection!.setLocalDescription(_answer);

        final _messageOffer = {
          "type": "answer",
          "appointment": _appointmentId,
          "role": 'patient',
          "answer": {
            "sdp": _answer.sdp,
            "type": _answer.type,
          },
        };

        _channel.sink.add(jsonEncode(_messageOffer));
      });

      debugPrint('peerConnection :: type offer');
    } on Exception catch (_) {
      debugPrint('CATCH _setRemoteAndLocalDescription');
      // showErrorDialog(context,
      //     error: 'Algum erro inexperado aconteceu. Por favor, tente novamente.',
      //     action: () async => Navigator.pop(context));
    }
  }

  Future<void> _makeCall() async {
    try {
      _peerConnection =
          await createPeerConnection(configuration, loopbackConstraints);

      _peerConnection!.onIceCandidate = (event) {
        if (event.candidate?.isNotEmpty == true) {
          final message = {
            "type": 'candidate',
            "appointment": _appointmentId,
            "role": 'patient',
            "candidate": {
              "candidate": event.candidate,
              "sdpMLineIndex": event.sdpMLineIndex,
              "sdpMid": event.sdpMid,
            }
          };
          _channel.sink.add(jsonEncode(message));
          debugPrint('peerConnection :: onIceCandidate $jsonEncode(message)');
        }
      };

      _peerConnection!.onTrack = (event) {
        if (event.track.kind == 'video') {
          _remoteRenderer!.srcObject = event.streams[0];
          _remoteStream = event.streams[0];
          setState(() {});

          debugPrint('peerConnection :: onTrack');
        }
      };

      _peerConnection!.onRemoveTrack = (stream, track) {
        if (track.kind == 'video') {
          _remoteRenderer!.srcObject = null;
        }
      };

      _localStream!.getTracks().forEach((track) {
        _peerConnection!.addTrack(track, _localStream!);
        debugPrint('peerConnection :: addTrack');
      });

      _peerConnection!.onSignalingState = (state) {
        if (state == RTCSignalingState.RTCSignalingStateHaveRemoteOffer) {
          debugPrint('message WSS:: _peerConnection State $state');
        }
      };
    } on Exception {
      debugPrint('CATCH makecall');
      // showErrorDialog(context,
      //     error: 'Algum erro inexperado aconteceu. Por favor, tente novamente.',
      //     action: () async => Navigator.pop(context));
    }
  }

  void _disposeRenderers() {
    if (_localRenderer != null) {
      _localRenderer!.srcObject = null;
      _localRenderer!.dispose();
      _localRenderer = null;
    }
    if (_remoteRenderer != null) {
      _remoteRenderer!.srcObject = null;
      _remoteRenderer!.dispose();
      _remoteRenderer = null;
    }

    _remoteStream?.dispose();
    _localStream?.dispose();
    _channel.sink.close();
  }

  void _showEndCallDialog() async {
    await showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(10.0))),
        content: SizedBox(
            width: 335,
            height: 150,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text('Video Chamada acabou!!'),
                ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context);
                      Navigator.pop(context);
                    },
                    child: const Text('Sair'))
              ],
            )),
      ),
    );
  }

  @override
  void initState() {
    _channel = IOWebSocketChannel.connect(
        Uri.parse('wss://booking.medislot.com:56112'));
    _localRenderer = RTCVideoRenderer();
    _remoteRenderer = RTCVideoRenderer();

    initRenderers();
    getLocalUserMedia();
    connectWebSocket();
    super.initState();
  }

  @override
  void deactivate() {
    super.deactivate();
    _disposeRenderers();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildDefaultAppBar(
        context,
        title: R.string.videoCall,
        actions: buildActionsAppbar(),
        onPressed: () {
          Navigator.pop(context);
        },
      ),
      body: _inCalling
          ? BodyVideoCallCalling(
              isCamEnabled: _isCamEnabled,
              localRenderer: _localRenderer!,
              remoteRenderer: _remoteRenderer!,
            )
          : const BodyVideoCallWaiting(),
    );
  }

  List<Widget> buildActionsAppbar() {
    final colorYellow = Theme.of(context).colorScheme.primary;
    return [
      IconButton(
        onPressed: toggleMicrophone,
        icon: !_isMicEnabled
            ? Icon(
                Icons.mic_off_outlined,
                color: colorYellow,
              )
            : Icon(
                Icons.mic_none_rounded,
                color: colorYellow,
              ),
      ),
      IconButton(
        onPressed: toogleCam,
        icon: !_isCamEnabled
            ? Icon(
                Icons.videocam_off,
                color: colorYellow,
              )
            : Icon(
                Icons.video_camera_back_rounded,
                color: colorYellow,
              ),
      ),
    ];
  }
}

class BodyVideoCallWaiting extends StatelessWidget {
  const BodyVideoCallWaiting({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Text('Aguardando conexão do médico...'),
          const SizedBox(
            height: 40,
          ),
          CircularProgressIndicator(
            color: Theme.of(context).colorScheme.primary,
          ),
        ],
      ),
    );
  }
}

class BodyVideoCallCalling extends StatefulWidget {
  const BodyVideoCallCalling({
    Key? key,
    required this.isCamEnabled,
    required this.localRenderer,
    required this.remoteRenderer,
  }) : super(key: key);

  final RTCVideoRenderer remoteRenderer;
  final RTCVideoRenderer localRenderer;
  final bool isCamEnabled;

  @override
  State<BodyVideoCallCalling> createState() => _BodyVideoCallCallingState();
}

class _BodyVideoCallCallingState extends State<BodyVideoCallCalling> {
  RTCVideoRenderer get _remoteRenderer => widget.remoteRenderer;
  RTCVideoRenderer get _localRenderer => widget.localRenderer;
  bool get _isCamEnabled => widget.isCamEnabled;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        SizedBox(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: Container(
              color: Colors.green,
              child: RTCVideoView(
                _remoteRenderer,
                objectFit: RTCVideoViewObjectFit.RTCVideoViewObjectFitCover,
              )),
        ),
        Positioned(
          bottom: 20,
          left: 200,
          right: 20,
          child: Container(
            height: MediaQuery.of(context).size.height / 3.5,
            width: MediaQuery.of(context).size.width / 2,
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.all(
                Radius.circular(10),
              ),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: _isCamEnabled
                  ? RTCVideoView(
                      _localRenderer,
                      objectFit:
                          RTCVideoViewObjectFit.RTCVideoViewObjectFitCover,
                    )
                  : Container(
                      decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                            color: Colors.white.withOpacity(0.6),
                            blurStyle: BlurStyle.solid,
                          ),
                        ],
                      ),
                      child: const Center(
                        child: Icon(Icons.videocam_off),
                      ),
                    ),
            ),
          ),
        ),
      ],
    );
  }
}
