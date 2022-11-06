import 'package:agora_rtc_engine/agora_rtc_engine.dart';
import 'package:flutter/material.dart';
import 'package:flutter_phosphor_icons/flutter_phosphor_icons.dart';
import 'package:get/get.dart';

import 'package:hi_doctor_v2/app/common/constants.dart';
import 'package:hi_doctor_v2/app/modules/meeting/controllers/meeting_controller.dart';
import 'package:hi_doctor_v2/app/modules/meeting/views/raw_button.dart';
import 'package:hi_doctor_v2/app/modules/widgets/my_appbar.dart';

class ChannelPage extends StatefulWidget {
  const ChannelPage({super.key});

  @override
  State<ChannelPage> createState() => _ChannelPageState();
}

class _ChannelPageState extends State<ChannelPage> {
  late String _channelName;
  late String _tempToken;
  late RtcEngine _engine;
  late MeetingController _cMeeting;
  late RxList<String> _infoStr;
  late RxBool _isLocalUserJoined;
  late RxnInt _remoteId;
  late RxBool _isMuted;
  late RxBool _isVideoDisabled;

  @override
  void initState() {
    super.initState();
    init();
    setupVideoSDKEngine();
  }

  @override
  void dispose() {
    _engine.release();
    super.dispose();
  }

  void init() {
    _cMeeting = Get.find<MeetingController>();

    final args = Get.arguments as Map<String, String>;
    _channelName = args['channelId']!;
    _tempToken = args['token']!;
    print('CHANNEL ID : $_channelName, token: $_tempToken');

    _infoStr = _cMeeting.infoStr;
    _isLocalUserJoined = _cMeeting.isLocalUserJoined;
    _remoteId = _cMeeting.remoteId;
    _isMuted = _cMeeting.isMuted;
    _isVideoDisabled = _cMeeting.isVideoDisabled;
  }

  void setupVideoSDKEngine() async {
    _engine = createAgoraRtcEngine();
    await _engine.initialize(const RtcEngineContext(appId: Constants.appId));

    _engine.registerEventHandler(
      RtcEngineEventHandler(
        onLocalVideoStateChanged: (source, state, error) {
          _infoStr.add('Local: ${error.toString()}, state: ${state.toString()}');
        },
        onRejoinChannelSuccess: (RtcConnection connection, int elapsed) {
          _isLocalUserJoined.value = true;
          _infoStr.add('Rejoin channel ${connection.channelId} success: uid: ${connection.localUid}');
        },
        onJoinChannelSuccess: (RtcConnection connection, int elapsed) {
          _isLocalUserJoined.value = true;
          _infoStr.add('Rejoin channel ${connection.channelId} success: uid: ${connection.localUid}');
        },
        onUserJoined: (RtcConnection connection, int remoteUid, int elapsed) {
          _infoStr.add('Remote user joined: $remoteUid');
          _remoteId.value = remoteUid;
        },
        onUserOffline: (RtcConnection connection, int remoteUid, UserOfflineReasonType reason) {
          _infoStr.add('Remote user offlined: $remoteUid');
          _remoteId.value = null;
        },
        onTokenPrivilegeWillExpire: (RtcConnection connection, String token) {
          _infoStr.add('Token will expire in 30 secs');
        },
        onError: (err, msg) {
          setState(() {
            final info = 'Error: type ${err.toString()} details $msg';
            _infoStr.add(info);
          });
        },
        onLeaveChannel: (connection, stats) {
          Get.back();
        },
      ),
    );
    await _engine.enableAudio();
    await _engine.enableVideo();
    await _engine.startPreview();

    await _engine.joinChannel(
      token: _tempToken,
      channelId: _channelName,
      uid: 0,
      options: const ChannelMediaOptions(
        clientRoleType: ClientRoleType.clientRoleBroadcaster,
        channelProfile: ChannelProfileType.channelProfileCommunication,
      ),
    );
  }

  void leave() {
    _isLocalUserJoined.value = false;
    _remoteId.value = null;
    _engine.leaveChannel();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: MyAppBar(
        title: 'Video call',
        actions: [
          RawMaterialButton(
            onPressed: () {
              _engine.switchCamera();
            },
            shape: const CircleBorder(),
            elevation: 2.0,
            padding: const EdgeInsets.all(12.0),
            child: const Icon(
              PhosphorIcons.camera_rotate_fill,
              color: Colors.white,
              size: 24,
            ),
          ),
        ],
      ),
      body: Stack(
        children: [
          Center(
            child: _remoteVideo(),
          ),
          Align(
            alignment: Alignment.topLeft,
            child: SizedBox(
              width: 100,
              height: 150,
              child: Center(
                child: ObxValue<RxBool>((data) {
                  if (data.value == true) {
                    return AgoraVideoView(
                      controller: VideoViewController(
                        rtcEngine: _engine,
                        canvas: const VideoCanvas(uid: 0),
                      ),
                    );
                  }
                  return const CircularProgressIndicator();
                }, _isLocalUserJoined),
              ),
            ),
          ),
          // _panel(),
          _toolbar(),
        ],
      ),
    );
  }

  Widget _remoteVideo() {
    return ObxValue<RxnInt>(
      (data) {
        if (data.value != null) {
          return AgoraVideoView(
            controller: VideoViewController.remote(
              rtcEngine: _engine,
              canvas: VideoCanvas(
                uid: data.value,
              ),
              connection: RtcConnection(channelId: _channelName),
            ),
          );
        }
        return const Text(
          'Please wait for remote user to join',
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Colors.white,
            fontSize: 22,
          ),
        );
      },
      _remoteId,
    );
  }

  Widget _toolbar() {
    return Container(
      alignment: Alignment.bottomCenter,
      padding: const EdgeInsets.symmetric(vertical: 48),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          StatusRawButton(
            onPressed: () {
              _isMuted.value = !_isMuted.value;
              _engine.muteLocalAudioStream(_isMuted.value);
            },
            rxBool: _isMuted,
            iconDataOn: PhosphorIcons.microphone_slash_bold,
            iconDataOff: PhosphorIcons.microphone_fill,
          ),
          RawMaterialButton(
            onPressed: leave,
            shape: const CircleBorder(),
            elevation: 2.0,
            fillColor: Colors.redAccent,
            padding: const EdgeInsets.all(15.0),
            child: const Icon(
              PhosphorIcons.phone_x_fill,
              color: Colors.white,
              size: 35.0,
            ),
          ),
          StatusRawButton(
            onPressed: () {
              _isVideoDisabled.value = !_isVideoDisabled.value;
              _engine.muteLocalVideoStream(_isVideoDisabled.value);
            },
            rxBool: _isVideoDisabled,
            iconDataOn: PhosphorIcons.video_camera_slash_fill,
            iconDataOff: PhosphorIcons.video_camera_fill,
          ),
        ],
      ),
    );
  }

  Widget _panel() {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 48),
      alignment: Alignment.bottomCenter,
      child: FractionallySizedBox(
        heightFactor: 0.5,
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 48),
          child: ListView.builder(
            reverse: true,
            itemCount: _infoStr.length,
            itemBuilder: (_, index) {
              if (_infoStr.isEmpty) {
                return const Text('null');
              }
              return Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: 3,
                  horizontal: 10,
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Flexible(
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          vertical: 2,
                          horizontal: 5,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(5),
                        ),
                        child: Text(
                          _infoStr[index],
                          style: const TextStyle(
                            color: Colors.blueGrey,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
