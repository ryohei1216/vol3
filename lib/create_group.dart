import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'dart:async';
import 'package:flutter_ringtone_player/flutter_ringtone_player.dart';

////////////////////API POST処理///////////////////////

Future<Album> createAlbum(String name, setTime) async {
  final response = await http.post(
    Uri.https('54.238.142.190', '/groups'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(<String, String>{
      'name': name,
      'alarm' :setTime,
    }),
  );

  if (response.statusCode == 201) {
    return Album.fromJson(jsonDecode(response.body));
  } else {
    throw Exception('Failed to create album.');
  }
}

class Album {
  final String name;
  final String setTime;

  Album({this.name, this.setTime});

  factory Album.fromJson(Map<String, dynamic> json) {
    return Album(
      name: json['name'],
      setTime: json['alarm'],
    );
  }
}

////////////////////API POST処理///////////////////////



class CreateGroup extends StatefulWidget {
  final String title;
  final String user;

  const CreateGroup({Key key, this.title, this.user}) : super(key: key);

  @override
  _CreateGroupState createState() => _CreateGroupState();
}



class _CreateGroupState extends State<CreateGroup> {

  final TextEditingController _controller = TextEditingController();
  Future<Album> _futureAlbum;

  String id;
  String setTime;
  String _time='';

  @override


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("グループ作成"),
      ),
      body: Container(
        width: double.infinity,
        child: Column(
          children: [
            //ユーザー名出力
            Container(
              child: Text("ユーザー名 :" + (widget.user)),
            ),
            Container(
              child: (_futureAlbum == null)
              ? Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  TextField(
                    controller: _controller,
                    decoration: InputDecoration(
                        hintText: '設定時間を入力してください'
                    ),
                    onChanged: (text) {
                      setTime = text;
                      print("Time: $setTime");
                    },
                  ),
                  ElevatedButton(
                    child: Text('作成する'),
                    onPressed: () {
                      print(widget.user);
                      Navigator.pop(context, setTime);
                      setState(() {
                        _futureAlbum = createAlbum(widget.user, _controller.text);
                      });
                    },
                  ),
                ],
              )
                  : FutureBuilder<Album>(
                future: _futureAlbum,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    print(snapshot.data);
                    return Text('ユーザー名：' + snapshot.data.name + "    設定時間：" + snapshot.data.setTime);
                  } else if (snapshot.hasError) {
                    return Text("${snapshot.error}");
                  }

                  return CircularProgressIndicator();
                },
              ),
            ),

          ],
        ),
      ),

    );
  }

}
