import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class AlarmList extends StatefulWidget {
  final String title;
  final String user;

  const AlarmList({Key key, this.title, this.user}) : super(key: key);

  @override
  _AlarmListState createState() => _AlarmListState();
}



////////////////////////////////////API GET処理//////////////////////////
//network request
Future<Album> fetchAlbum() async {
  final response =
  await http.get(Uri.http('54.238.142.190', '/groups'));
  print(response);

  if (response.statusCode == 200) {
    // If the server did return a 200 OK response,
    // then parse the JSON.
    print(jsonDecode(response.body));
    return Album.fromJson(jsonDecode(response.body));
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Failed to load album');
  }
}

//Albumクラス
class Album {
  final List groups;

  Album({@required this.groups,});

  factory Album.fromJson(Map<String, dynamic> json) {
    return Album(
      groups: json['groups']
    );
  }
}
/////////////////////////////////////API GET処理////////////////////////


/////////////////////////////////////API POST処理////////////////////////

Future<Album2> createAlbum2(String name) async {
  final response = await http.post(
    Uri.https('54.238.142.190', '/users'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(<String, String>{
      'name': name
    }),
  );

  if (response.statusCode == 201) {
    return Album2.fromJson(jsonDecode(response.body));
  } else {
    throw Exception('Failed to create album.');
  }
}

class Album2 {
  final String name;

  Album2({this.name});

  factory Album2.fromJson(Map<String, dynamic> json) {
    return Album2(
      name: json['name']
    );
  }
}

/////////////////////////////////////API POST処理////////////////////////


enum Groups { A, B, C }
var groupId ;

class _AlarmListState extends State<AlarmList> {
  // final TextEditingController _controller = TextEditingController();
  Future<Album> futureAlbum;
  Future<Album2> _futureAlbum2;
  @override

  void initState() {
    super.initState();
    futureAlbum = fetchAlbum();
  }
  // var _radVal = Groups.A;
  // void _onChanged(Groups value) {
  //   setState(() {
  //     _radVal = value;
  //   });
  // }

  String groupId;
  String setTime;

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Container(
        child: FutureBuilder<Album>(
            future: futureAlbum,
            builder: (context, snapshot) {
              if(snapshot.hasData){
                print("取得完了");
                // print(snapshot.data.groups[0]['alarm']);
                List groups = snapshot.data.groups;
                print(groups);
                return ListView.builder(
                  itemCount: groups.length,
                    itemBuilder: (BuildContext context, int index){
                      return Column(
                        children: [
                          ListTile(
                            title: Text(groups[index]['alarm']),
                            // onTap: () {
                            //   groupId = groups[index]['groupId'];
                            //   setTime = groups[index]['alarm'];
                            //   print(groupId);
                            //   print(widget.user);
                            //   print(setTime);
                            // },
                          ),
                          Divider(thickness: 3,),
                          Container(
                            child: (_futureAlbum2 == null)
                                ? Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                ElevatedButton(
                                  child: Text("参加する"),
                                  onPressed: () {
                                    groupId = groups[index]['groupId'];
                                    setTime = groups[index]['alarm'];
                                    print(groupId);
                                    print(widget.user);
                                    print(setTime);
                                    setState(() {
                                      _futureAlbum2 = createAlbum2(widget.user);
                                    });
                                    Navigator.pop(context, setTime);
                                    },)
                              ],
                            )
                                : FutureBuilder<Album2>(
                              future: _futureAlbum2,
                              builder: (context, snapshot) {
                                if (snapshot.hasData) {
                                  return Text(snapshot.data.name);
                                } else if (snapshot.hasError) {
                                  return Text("${snapshot.error}");
                                }
                                return CircularProgressIndicator();
                                },
                            ),
                          )
                        ],
                      );
                  });


              } else if (snapshot.hasError) {
                print("取得失敗");
                return Text("リストを取得できませんでした");
              }
              return ListTile(
                title: Text("表示できるリストはありません"),
              );
            }),

      ),

      // ListView(
      //   children: [
      //     RadioListTile(
      //       title: Text("グループA"),
      //       value: Groups.A,
      //       groupValue: _radVal,
      //       onChanged: _onChanged
      //     ),
      //     Divider(thickness: 3,),
      //     RadioListTile(
      //       title: Text("グループB"),
      //         value: Groups.B,
      //         groupValue: _radVal,
      //         onChanged: _onChanged
      //     ),
      //     Divider(thickness: 3,),
      //     RadioListTile(
      //         title: Text("グループC"),
      //         value: Groups.C,
      //         groupValue: _radVal,
      //         onChanged: _onChanged
      //     ),
      //     Divider(thickness: 3,),
      //     Center(
      //       child: FutureBuilder<Album>(
      //           future: futureAlbum,
      //           builder: (context, snapshot) {
      //             if(snapshot.hasData){
      //               print("取得完了");
      //               print(snapshot.data.groups[0]['alarm']);
      //               List groups = snapshot.data.groups;
      //               return ListView(
      //                 children: [
      //                   ListTile(
      //                     title: Text(groups[0]['alarm']),
      //                   ),
      //                 ],
      //               );
      //
      //             } else if (snapshot.hasError) {
      //               print("取得失敗");
      //               return Text("リストを取得できませんでした");
      //             }
      //             return ListTile(
      //               title: Text("表示できるリストはありません"),
      //             );
      //           }),
          // ),
    //       Container(
    //         child: (_futureAlbum2 == null)
    //             ? Column(
    //           mainAxisAlignment: MainAxisAlignment.center,
    //           children: <Widget>[
    //             TextField(
    //               controller: _controller,
    //               decoration: InputDecoration(hintText: 'Enter Title'),
    //             ),
    //             ElevatedButton(
    //               child: Text("参加する"),
    //               onPressed: () {
    //                 //グループの固有IDとuserをサーバーに送る
    //                 setState(() {
    //                   _futureAlbum2 = createAlbum2(_controller.text, widget.user);
    //                 });
    //                 Navigator.pop(context, "12:00");
    //
    //             },)
    //           ],
    //         )
    //             : FutureBuilder<Album2>(
    //           future: _futureAlbum2,
    //           builder: (context, snapshot) {
    //             if (snapshot.hasData) {
    //               return Text(snapshot.data.title + snapshot.data.user);
    //             } else if (snapshot.hasError) {
    //               return Text("${snapshot.error}");
    //             }
    //
    //             return CircularProgressIndicator();
    //             },
    //         ),
    //
    //       ),
    //     ],
    //   ),
    );
  }
}
