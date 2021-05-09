import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class NextPage extends StatefulWidget {
  final String title;

  const NextPage({Key key, this.title}) : super(key: key);
  // NextPage(this.title);


  @override
  _NextPageState createState() => _NextPageState();
}

class _NextPageState extends State<NextPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Padding(
        padding: const EdgeInsets.all(30.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                    width: 50,
                    child: Text('ID')
                ),
                Container(
                    width: 20,
                    child: Text(':')
                ),
                Text('毎回同じIDを表示'),
              ],
            ),
            //余白
            Padding(padding: EdgeInsets.all(20)),
            Row(
              children: [
                Container(
                  width: 50,
                    child: Text('PW')
                ),
                Container(
                    width: 20,
                    child: Text(':')
                ),
                Text('毎回同じPWを表示'),
              ],
            ),
          ],
        ),
      ),

    );

  }
}
