import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_ringtone_player/flutter_ringtone_player.dart';

class StopAlarm extends StatefulWidget {
  final String title;

  const StopAlarm({Key key, this.title}) : super(key: key);

  @override
  _StopAlarmState createState() => _StopAlarmState();
}

class _StopAlarmState extends State<StopAlarm> {
  @override

  String id;
  String pw;

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: RaisedButton(
            child: Text("アラーム停止"),
            onPressed: () {
          FlutterRingtonePlayer.stop();

        }),
      ),
    );
  }
}
