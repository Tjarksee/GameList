import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class game_page extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('gamepage'),
        ), //AppBar
        body: Container(
            width: double.infinity,
            child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.max,
                children: <Widget>[
                  ElevatedButton(
                    child: Text(
                      "call gamelist",
                    ), //Text
                    onPressed: () {},
                  ), //RaisedButton
                  SizedBox(height: 20),
                  ElevatedButton(
                    child: Text("Name "),
                    onPressed: () {},
                  ), //RaisedButton
                  SizedBox(height: 20),
                  ElevatedButton(
                    child: Text(
                      "Score",
                    ),
                    onPressed: () {},
                  ), //Text
                ])));
  }
}
