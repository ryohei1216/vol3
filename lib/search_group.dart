
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_ringtone_player/flutter_ringtone_player.dart';

class SearchGroup extends StatefulWidget {
  final String title;

  const SearchGroup({Key key, this.title}) : super(key: key);

  @override
  _SearchGroupState createState() => _SearchGroupState();
}

class _SearchGroupState extends State<SearchGroup> {
  @override

  String id;
  String pw;

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Container(
        child: RaisedButton(onPressed: () {
          FlutterRingtonePlayer.stop();
        }),
      ),
    );
  }
}
