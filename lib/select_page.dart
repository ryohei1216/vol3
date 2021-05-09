import 'package:flutter/material.dart';
import 'package:flutter_ringtone_player/flutter_ringtone_player.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:web_socket_channel/io.dart';

import 'alarm_list.dart';
import 'create_group.dart';

class SelectPage extends StatefulWidget {
  final String user;
  const SelectPage({Key key, this.user}) : super(key: key);
  @override
  _CreateSelectPage createState() => _CreateSelectPage();
}

class _CreateSelectPage extends State<SelectPage> {
  SharedPreferences _prefs;
  String _time = '';
  String _setTime = '';
  IOWebSocketChannel _channel;

  @override
  void initState() {
    super.initState();

    SharedPreferences.getInstance().then((prefs) => _prefs = prefs);

    // Timer.periodic(
    //   Duration(seconds: 30),
    //   _onTimer,
    // );
  }
  //
  // void _onTimer(Timer timer) {
  //   var now = DateTime.now();
  //   var formatter = DateFormat('HH:mm');
  //   var formattedTime = formatter.format(now);
  //   setState(() => _time = formattedTime);
  //   print(_time);
  //   print(_setTime);
  //   if(_setTime == _time){
  //     print('success');
  //     ///アラームが鳴りだす
  //     FlutterRingtonePlayer.play(
  //       android: AndroidSounds.notification, // Android用のサウンド
  //       looping: true, // Androidのみ。ストップするまで繰り返す
  //       asAlarm: true, // Androidのみ。サイレントモードでも音を鳴らす
  //       volume: 1.0, // Androidのみ。0.0〜1.0
  //     );
  //   }
  // }

  List<String> titleList = ["グループ作成", "アラームのリスト", "アラーム停止"];

  void ringAlarm() {
    FlutterRingtonePlayer.play(
      android: AndroidSounds.alarm, // Android用のサウンド
      ios: const IosSound(1023), // iOS用のサウンド
      looping: true, // Androidのみ。ストップするまで繰り返す
      asAlarm: true, // Androidのみ。サイレントモードでも音を鳴らす
      volume: 1.0, // Androidのみ。0.0〜1.0
    );
  }

  void _stopAlarm() {
    _channel = IOWebSocketChannel.connect(
      Uri.parse('ws://54.238.142.190:80/stop-alarm/'),
    );

    _channel.stream.listen((message) {
      debugPrint(message);
      if (message == "all awake") {
        debugPrint("Stop alarm");
        FlutterRingtonePlayer.stop();
        _channel.sink.close();
      }
    });

    final userId = _prefs.getString("userId");
    // FIXME: どこかに保存している、鳴っているアラームのグループのid入れる
    final groupId = "327f98dc-c24d-4181-a72d-c84e75a5c6c7";
    _channel.sink.add("$userId,$groupId");
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("選択画面"),
      ),
      body: ListView(
        children: [
          ListTile(
            title: Text(titleList[0]),
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => CreateGroup(
                  title: titleList[0],
                  user: widget.user,
                ),
              ),
            ).then(
              (setTime) => {
                _setTime = setTime,
                print(_setTime),
              },
            ),
          ),
          Divider(thickness: 3),
          ListTile(
            title: Text(titleList[1]),
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => AlarmList(
                  title: titleList[1],
                  user: widget.user,
                ),
              ),
            ).then((setTime) => {_setTime = setTime, print(_setTime)}),
          ),
          Divider(thickness: 3),
          TextButton(onPressed: ringAlarm, child: Text("Ring alarm (Debug)")),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _stopAlarm,
        tooltip: 'Stop alarm',
        child: Icon(Icons.alarm_off),
      ),
    );
  }
}
