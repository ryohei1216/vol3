
import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/stop_alarm.dart';
import 'package:flutter_ringtone_player/flutter_ringtone_player.dart';
import 'package:http/http.dart' as http;
import 'alarm_list.dart';
import 'create_group.dart';
import 'package:intl/intl.dart';
import 'dart:async';

import 'package:web_socket_channel/web_socket_channel.dart';
import 'package:web_socket_channel/status.dart' as status;


class SelectPage extends StatefulWidget {
  final String user;
  const SelectPage({Key key, this.user}) : super(key: key);
  @override
  _CreateSelectPage createState() => _CreateSelectPage();
}



class _CreateSelectPage extends State<SelectPage> {
  String _time = '';
  String _setTime = '';

  @override
  // void initState() {
  //   Timer.periodic(
  //     Duration(seconds: 30),
  //     _onTimer,
  //   );
  //   super.initState();
  // }
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

  List<String> titleList = ["グループ作成","アラームのリスト","アラーム停止"];

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
                context, MaterialPageRoute(builder: (context) => CreateGroup(
              title: titleList[0],
              user: widget.user,
            ))
            ).then((setTime) => {
              _setTime = setTime,
              print(_setTime),
            }),
          ),
          Divider(thickness: 3,),


          ListTile(
            title: Text(titleList[1]),
            onTap: () => Navigator.push(
                context, MaterialPageRoute(builder: (context) => AlarmList(
              title: titleList[1],
              user: widget.user
            ))
            ).then((setTime) => {
              _setTime = setTime,
              print(_setTime)
            }),
          ),
          Divider(thickness: 3),



          ListTile(
            title: Text(titleList[2]),
            onTap: () => Navigator.push(
                context, MaterialPageRoute(builder: (context) => StopAlarm(
              title: titleList[2],
            ))
            )),
          Divider(thickness: 3),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          //ボタンが押されたときの処理
          FlutterRingtonePlayer.play(
            android: AndroidSounds.notification, // Android用のサウンド
            ios: const IosSound(1023), // iOS用のサウンド
            looping: true, // Androidのみ。ストップするまで繰り返す
            asAlarm: true, // Androidのみ。サイレントモードでも音を鳴らす
            volume: 1.0, // Androidのみ。0.0〜1.0
          );
          // FlutterRingtonePlayer.playAlarm();
          // FlutterRingtonePlayer.playRingtone();

        },
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ),
    );
  }
}

