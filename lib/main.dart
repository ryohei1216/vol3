import 'package:flutter/material.dart';
import 'package:flutter_app/select_page.dart';
import 'package:flutter_ringtone_player/flutter_ringtone_player.dart';


void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}


class _MyHomePageState extends State<MyHomePage> {
  List<String> titleList = ["アラーム設定","アラームのリスト","グループ検索"];

  //アプリのUI部分
  @override
  Widget build(BuildContext context) {

    var user = "Guest";

    return Scaffold(
      appBar: AppBar(

        title: Text("ログインページ"),
      ),
      body: Container(
        child: Column(
          children: [
            TextField(
              decoration: InputDecoration(
                  hintText: "ユーザー名を入力してください"
              ),
              onChanged: (text) {
                print("User : $text");
                user = text;
              },
            ),
            RaisedButton(
              child: Text("ログインする"),
                onPressed: () {
                Navigator.push(
                    context, MaterialPageRoute(builder: (context) => SelectPage(
                  user: user,
                )));
            })
          ],
        ),


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
